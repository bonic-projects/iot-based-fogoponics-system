int relayPin = 14;             // Pin connected to the relay
bool relayState = false;       // Current state of the relay
unsigned long timer = 0;       // Keeps track of time
int onTime = 20000;            // Relay ON time in milliseconds (20 seconds)
int offTime = 240000;          // Relay OFF time in milliseconds (240 seconds)

void setup() {
  Serial.begin(115200);
  pinMode(relayPin, OUTPUT);   // Set relay pin as output
  digitalWrite(relayPin, LOW); // Start with relay OFF
  Serial.println("Relay is OFF");
  timer = millis();            // Initialize the timer
}

void loop() {
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
