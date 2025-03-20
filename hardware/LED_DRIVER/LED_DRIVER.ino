#define LDR 33
#define DRIVER 32
void setup() {
  // put your setup code here, to run once:
pinMode(LDR,INPUT);
pinMode(DRIVER,OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
int analogValue = analogRead(LDR);
// int pwm = map(analogValue,0,4095,255,0);
int pwm = map(analogValue,0,4095,100,0);
analogWrite(DRIVER,pwm);
delay(100);
}
