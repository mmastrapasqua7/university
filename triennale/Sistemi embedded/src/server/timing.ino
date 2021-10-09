#define ULTRASOUND_NEARBY 15

const int triggerPort = 9;
const int echoPort = 10;

void sensorSetup() {
//  Serial.print("SETUP SENSORE... ");

  pinMode(triggerPort, OUTPUT);
  pinMode(echoPort, INPUT);
  
  xTaskCreate(
    timeCar,
    "TimeCar",
    sizeof(unsigned long) * 10,
    NULL,
    1,
    NULL);

//  Serial.println("DONE");
}

unsigned long startTime;
unsigned long endTime;
unsigned long lastNewTime;

void timeCar(void *args) {
  waitCarPassBy();
  startTime = millis();
//  Serial.println("PASSAGGIO MACCHINA!");
  delay(2000);

  while (true) {
    waitCarPassBy();
    endTime = millis();
//    Serial.println("PASSAGGIO MACCHINA");
    
    lastNewTime = endTime - startTime;
    startTime = endTime;
    
    delay(2000);
  }
}

void waitCarPassBy() {
  while (measureDistance() >= ULTRASOUND_NEARBY) {
    ; // wait unit it gets close to sensor
  }
  
  long min_distance = measureDistance();
  long current_distance = min_distance;
  while (current_distance <= min_distance) {
    min_distance = current_distance;
    current_distance = measureDistance();
  }
}

long measureDistance() {
  digitalWrite(triggerPort, LOW);
  delayMicroseconds(2);
  digitalWrite(triggerPort, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPort, LOW);
   
  long durata = pulseIn(echoPort, HIGH);
  return (long) ((durata / 2) / 29.1);
}
