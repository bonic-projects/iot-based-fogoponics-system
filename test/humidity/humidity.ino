#include <DFRobot_DHT11.h>
DFRobot_DHT11 DHT;
#define DHT11_PIN 35
int humidity = 0;
int temperature = 0;
void setup(){
  Serial.begin(115200);
}

void loop(){
  readHumidity();
}

void readHumidity(){
  DHT.read(DHT11_PIN);
  humidity = DHT.humidity;
  temperature = DHT.temperature;
  Serial.print("temp");
  Serial.print(temperature);
  Serial.print("humi:");
  Serial.println(humidity);
  delay(1000);
}
