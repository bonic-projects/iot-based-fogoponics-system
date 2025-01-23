#define LDR_PIN 34  // Replace with the pin you're using

void setup() {
  Serial.begin(115200);
  Serial.println("Reading LDR Module...");
}

void loop() {
 lightIntensity();
}

void lightIntensity(){
   // Read the analog value from the LDR module
  int ldrValue = analogRead(LDR_PIN);
  Serial.print(ldrValue); 
  // Map the value to a 0-100 scale for easier interpretation (optional)
  int lightLevel = map(ldrValue, 0, 4095, 0, 100);   

  // Print the raw and scaled LDR values
  Serial.print("Raw LDR Value: ");
  Serial.print(ldrValue);
  Serial.print(" | Light Level (%): ");
  Serial.println(lightLevel);

  // Wait for a short period
  delay(500);
}
