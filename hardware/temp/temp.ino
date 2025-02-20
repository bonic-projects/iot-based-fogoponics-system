#include <OneWire.h>
#include <DallasTemperature.h>

// Pin connected to the DS18B20 data pin
const int oneWireBus = 13;

// Create a OneWire instance
OneWire oneWire(oneWireBus);

// Pass the OneWire instance to DallasTemperature
DallasTemperature tempSensor(&oneWire);

// Variable to store the temperature
float temperature;
void setup() {
  // Start the Serial Monitor
  Serial.begin(115200);
  Serial.println("DS18B20 Temperature Sensor Initialized");

  // Initialize the temperature sensor
  tempSensor.begin();
}

void loop() {
  // Request temperature measurements from the sensor
 temp();
}

void temp(){
   tempSensor.requestTemperatures();

  // Get the temperature in Celsius and print it
  temperature = tempSensor.getTempCByIndex(0);
  Serial.print("Temperature: ");
  Serial.print(temperature);
  Serial.println(" °C");

  // Wait for a second before the next reading
  delay(1000);
}
