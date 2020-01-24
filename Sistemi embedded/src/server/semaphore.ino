#define SEMAPHORE_LEDS_NUMBER 5
const byte ledSemaforo[SEMAPHORE_LEDS_NUMBER] = {16, 17, 5, 18, 19};

void semaphoreSetup() {
//  Serial.printf("%22s", "SETUP SEMAFORO... ");
  for (byte i = 0; i < SEMAPHORE_LEDS_NUMBER; i++) {
    pinMode(ledSemaforo[i], OUTPUT);
  }
//  Serial.println("DONE");
}

void semaphoreStart() {
  for (byte i = 0; i < SEMAPHORE_LEDS_NUMBER; i++) {
    delay(1000);
    digitalWrite(ledSemaforo[i], HIGH);
  }

  delay(2000);

  for (byte i = 0; i < SEMAPHORE_LEDS_NUMBER; i++) {
    digitalWrite(ledSemaforo[i], LOW);
  }
}

void semaphoreTest() {
  semaphoreStart();
}
