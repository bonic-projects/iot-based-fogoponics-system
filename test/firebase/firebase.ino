#include <Arduino.h>
#include <WiFi.h>
#include <FirebaseESP32.h>
#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>
// #include <Wire.h>

#define WIFI_SSID "Autobonics_4G"
#define WIFI_PASSWORD "autobonics@27"
#define API_KEY "AIzaSyBDDbroHrarzRo0IBZx-aMlppXWDiV57IE"              // Add API key here
#define DATABASE_URL "https://kart-d23e9-default-rtdb.firebaseio.com"         // Add database URL here
#define USER_EMAIL "device@gmail.com"
#define USER_PASSWORD "12345678"

// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
FirebaseData stream;

String uid;
String path;

unsigned long sendDataPrevMillis = 0;


const int relayPin = 14;

bool relayState = false;


void setup() {
  Serial.begin(115200);


   pinMode(relayPin, OUTPUT);

  // Ensure the relay is initially OFF
  digitalWrite(relayPin, LOW);
  Serial.println("Relay is OFF");



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

}

void loop() {
relay();
update();
}
void relay(){
   relayState = !relayState;
  digitalWrite(relayPin, relayState ? HIGH : LOW);
  delay(5000);
}



void update() {
  if (Firebase.ready() && (millis() - sendDataPrevMillis > 2000)) {
    sendDataPrevMillis = millis();
    FirebaseJson json;
    json.set("relay",relayState );
    json.set(F("ts/.sv"), F("timestamp"));

    Serial.printf("Data upload %s\n",Firebase.setJSON(fbdo, path.c_str(), json) ? "success" : fbdo.errorReason().c_str());
  }
}
