#include <LiquidCrystal.h>
#define ROW_1 0
#define ROW_2 1

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  lcd.begin(16, 2);
}

void loop() {
  char message[16] = {'0'};
  lcd.clear();
  if (Serial.available() > 0) {
    Serial.readBytes(message, 16);

    lcd.setCursor(0, ROW_1);
    lcd.print("  GIRO VELOCE!  ");
    
    lcd.setCursor(0, ROW_2);
    lcd.print(message);

    delay(4000);
  }
}
