int relayPin = 14;
bool relayState = false;
int onState = 20000;
int offState = 240000;
int atomizertiming = 0;


void setup() {
  Serial.begin(115200);
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, LOW);
  Serial.println("Relay is OFF");
  atomizertiming = millis();

}

void loop() {
  toggleRelay();
}

void toggleRelay(){
  digitalWrite(relayPin, HIGH);
  delay(onState);
  digitalWrite(relayPin, LOW);
  delay(offState);
}