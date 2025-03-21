#include <Arduino.h>
#include <WiFi.h>
#include <FirebaseESP32.h>
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>
#include <DFRobot_DHT11.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define WIFI_SSID "Autobonics_4G"
#define WIFI_PASSWORD "autobonics@27"
#define API_KEY "AIzaSyBDDbroHrarzRo0IBZx-aMlppXWDiV57IE"              // Add API key here
#define DATABASE_URL "https://kart-d23e9-default-rtdb.firebaseio.com"         // Add database URL here
#define USER_EMAIL "device@gmail.com"
#define USER_PASSWORD "12345678"

#define DHT11_PIN 15
#define LDR_PIN 36
#define relayPin 4
#define DRIVER 2       //For connecting LED
#define oneWireBus 32   //Temperature
#define humidityPin 25
#define peltPin1 26      //Different mode pins
#define peltPin2 27     //Different mode pins


// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
FirebaseData stream;



//Humidity
DFRobot_DHT11 DHT;

//temperature
// Create a OneWire instance
OneWire oneWire(oneWireBus);
// Pass the OneWire instance to DallasTemperature
DallasTemperature tempSensor(&oneWire);


 
String uid;
String path;

//

//DHT11
float humidity = 0;
float temperature = 0;

//LDR VALUE
int lightLevel = 0;
int ldrValue = 0;
int value = 0;

//mode
int modeValue = 0;

//Realy - atomizer
bool relayState = false;       // Current state of the relay
unsigned long timer = 0;       // Keeps track of time
int onTime = 60000;            // Relay ON time in milliseconds (60 seconds)
int offTime = 180000;          // Relay OFF time in milliseconds (240 seconds)

float minTemperature = 18;
float maxTemperature = 25;

//automatic 
bool automaticStatus = false;

// void streamCallback(StreamData data) {
//   Serial.println("NEW DATA!");

//   String p = data.dataPath();
//   Serial.println(p);
//   printResult(data);  // see addons/RTDBHelper.h

//   FirebaseJson json = data.jsonObject();
//   FirebaseJsonData atomizer;
//   FirebaseJsonData automatic;
//   FirebaseJsonData humidity;
//   FirebaseJsonData light;
//   FirebaseJsonData pelter;
//   FirebaseJsonData mode;

//   // Check if the "data" field contains a boolean value
//   json.get(atomizer, "atomizer");
//   json.get(automatic, "automatic");
//   json.get(humidity, "humidity");
//   json.get(light, "light");
//   json.get(pelter, "pelter");
//   json.get(mode, "mode");

// if (mode.success){
//   modeValue =  mode.to<int>();
// }

//  if (pelter.success) {
//     bool pelterValue= pelter.to<bool>();
//     if (pelterValue) {
//       peltierON(); // Turn relay ON
//     } else {
//       peltierOFF(); // Turn relay OFF
//     }
//   }


//   if (light.success) {
//     int lightValue= light.to<int>();      
//     controlLight(lightValue);  
//   }  


//   if (humidity.success) {
//     bool humidityValue= humidity.to<bool>();
//     if (humidityValue) {
//       digitalWrite(humidityPin, HIGH); // Turn relay ON
//       Serial.println("DC FAN ON");
//     } else {
//       digitalWrite(humidityPin, LOW); // Turn relay OFF
//       Serial.println("DC FAN OFF");
//     }
//   }


//   if (atomizer.success) {
//     Serial.println("Atomizer relay triger");
//     bool atomizerValue = atomizer.to<bool>();
//     if (atomizerValue) {
//       digitalWrite(relayPin, HIGH); // Turn relay ON
//       Serial.println("Atomizer relay ON");
//     } else {
//       digitalWrite(relayPin, LOW); // Turn relay OFF
//       Serial.println("Atomizer relay OFF");
//     }
//   }

  
//   if (automatic.success) {
//     automaticStatus = automatic.to<bool>();
// }
// }

void streamCallback(StreamData data) {
  Serial.println("NEW DATA!");
  String path = data.dataPath();
  Serial.println(path);

  // Handle specific paths
  if (path == "/atomizer") {
    bool atomizerValue = data.boolData();
    Serial.println("Atomizer relay trigger");
    if (atomizerValue) {
      digitalWrite(relayPin, HIGH);
      Serial.println("Atomizer relay ON");
    } else {
      digitalWrite(relayPin, LOW);
      Serial.println("Atomizer relay OFF");
    }
  }
  else if (path == "/light") {
    int lightValue = data.intData();
    controlLight(lightValue);
    Serial.println("Light set to: " + String(lightValue));
  }
  else if (path == "/humidity") {
    bool humidityValue = data.boolData();
    digitalWrite(humidityPin, humidityValue ? HIGH : LOW);
    Serial.println("DC FAN " + String(humidityValue ? "ON" : "OFF"));
  }
  else if (path == "/pelter") {
    bool pelterValue = data.boolData();
    if (pelterValue) {
      peltierON();
      Serial.println("Peltier ON");
    } else {
      peltierOFF();
      Serial.println("Peltier OFF");
    }
  }
  else if (path == "/mode") {
    modeValue = data.intData();
    Serial.println("Mode set to: " + String(modeValue));
  }
  else if (path == "/automatic") {
    automaticStatus = data.boolData();
    Serial.println("Automatic mode: " + String(automaticStatus ? "ON" : "OFF"));
  }
}



void streamTimeoutCallback(bool timeout) {
  if (timeout) {
    Serial.println("Stream timed out, resuming...\n");
  }

  if (!stream.httpConnected()) {
    Serial.printf("error code: %d, reason: %s\n\n", stream.httpCode(), stream.errorReason().c_str());
  }
}


unsigned long sendDataPrevMillis = 0;



void firebaseSetup(){
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println("\nConnected with IP: " + WiFi.localIP().toString());

  // Firebase setup
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);
  config.api_key = API_KEY;
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;
  config.database_url = DATABASE_URL;
  config.token_status_callback = tokenStatusCallback;

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  fbdo.setResponseSize(2048);

  // Getting the user UID
  Serial.println("Getting User UID...");
  while ((auth.token.uid) == "") {
    Serial.print('.');
    delay(1000);
  }
  uid = auth.token.uid.c_str();
  Serial.println("User UID: " + uid);
  path = "devices/" + uid + "/reading";

  if (!Firebase.beginStream(stream, "devices/" + uid + "/data")) {
    Serial.printf("Stream begin error, %s\n\n", stream.errorReason().c_str());
  }
  Firebase.setStreamCallback(stream, streamCallback, streamTimeoutCallback);
}

void setup() {
  Serial.begin(115200);
  pinMode(humidityPin, OUTPUT);
  pinMode(peltPin1,OUTPUT);
  pinMode(peltPin2,OUTPUT);
  pinMode(DRIVER, OUTPUT);
  tempSensor.begin();
  firebaseSetup();
  pinMode(relayPin, OUTPUT);   // Set relay pin as output
  digitalWrite(relayPin, LOW); // Start with relay OFF
  timer = millis();            // Initialize the timer
}




void loop() {
   readHumidity();
   readtemperature();
   readLightIntensity();
   update();
   if (automaticStatus){   
    automaticControl();
   }
}

void readHumidity(){  //assign current humidity to : humidity
  DHT.read(DHT11_PIN);
  humidity = DHT.humidity;
  Serial.print("humi:");
  Serial.println(humidity);
}

void readtemperature(){
  tempSensor.requestTemperatures();

 // Get the temperature in Celsius and print it
 temperature = tempSensor.getTempCByIndex(0);
 Serial.print("Temperature: ");
 Serial.print(temperature);
 Serial.println(" °C");
}

void readLightIntensity(){ //use lightLevel for updating to firebase and ldrValue for current analog value
   // Read the analog value from the LDR module
  ldrValue = analogRead(LDR_PIN);
  Serial.print(ldrValue); 
  // Map the value to a 0-100 scale for easier interpretation (optional)
  lightLevel = map(ldrValue, 0, 4095, 100, 0);   

  // Print the raw and scaled LDR values
  Serial.print("Raw LDR Value: ");
  Serial.print(ldrValue);
  Serial.print(" | Light Level (%): ");
  Serial.println(lightLevel);
}



void update() {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > 2000)) {
    sendDataPrevMillis = millis();
    FirebaseJson json;
    json.set("humidity",humidity);
    json.set("temperature",temperature);
    json.set("light", lightLevel);
    json.set(F("ts/.sv"), F("timestamp"));
    Serial.printf("Data upload %s\n",Firebase.setJSON(fbdo, path.c_str(), json) ? "success" : fbdo.errorReason().c_str());
  }
}

void controlLight(int pwm) {   
 analogWrite(DRIVER,pwm);     
}
void atomizer(){
  unsigned long currentTime = millis(); // Get the current time

  if (relayState && (currentTime - timer >= onTime)) {  
    // Turn relay OFF after being ON for 'onTime'
    digitalWrite(relayPin, LOW);
    relayState = false;
    timer = currentTime;       // Reset the timer
    Serial.println("Relay is OFF");
  }

  if (!relayState && (currentTime - timer >= offTime)) {   
    // Turn relay ON after being OFF for 'offTime'
    digitalWrite(relayPin, HIGH);
    relayState = true;
    timer = currentTime;       // Reset the timer
    Serial.println("Relay is ON");
  }
}
void automatedlight()
{
  value =map(ldrValue,0,4095,255,0);
  controlLight(value);
}
void heat() {
    digitalWrite(peltPin2, LOW);
    digitalWrite(peltPin1, HIGH);
}

void cool() {
    digitalWrite(peltPin2, HIGH);
    digitalWrite(peltPin1, LOW);
}

void automaticControl(){
  atomizer();
  automatedlight();
  if (modeValue == 0){
    heat();
  }else{
    cool();
  }
}

void peltierOFF(){
   digitalWrite(peltPin2, LOW);
    digitalWrite(peltPin1, LOW);
}

void peltierON(){
  if (modeValue == 0){
    heat();
  }else{
    cool();
  }
}



