const byte ledNotify[3] = {12, 14, 27};

void notifySetup() {
//  Serial.printf("%22s", "SETUP NOTIFY LEDS"); 
  for (byte i = 0; i < 3; i++) {
    pinMode(ledNotify[i], OUTPUT);
  }

//  Serial.println("DONE");
}

void notifyPerformanceLED(String color) {
  if (color.equals("fuxia")) {
    digitalWrite(ledNotify[0], HIGH);
  } else if (color.equals("green")) {
    digitalWrite(ledNotify[1], HIGH);
  } else if (color.equals("yellow")) {
    digitalWrite(ledNotify[2], HIGH);
  }

  delay(2000);
  for (byte i = 0; i < 3; i++) {
    digitalWrite(ledNotify[i], LOW);
  }
}

void notifyPerformanceLEDTest() {
  notifyPerformanceLED("fuxia");
  notifyPerformanceLED("green");
  notifyPerformanceLED("yellow");  
}

void notifyFastestLapOnDisplay() {
  String message = String(ranking[0]->name) + String(" ") + String(printTime(ranking[0]->time) + " ");
  byte messageBytes[16] = {'0'};
  message.getBytes(messageBytes, 16);
  Serial.write(messageBytes, 16);
}

//void notifyFastestLapOnDisplay() {
//  lcd.clear();
//  lcd.setCursor(0, ROW_1);
//  lcd.print("  GIRO VELOCE!  ");
//
//  lcd.setCursor(0, ROW_2);
//  lcd.print("  " + String(ranking[0]->name) + " " + printTime(ranking[0]->time) + "  ");
//  
//  delay(5000);
//}
