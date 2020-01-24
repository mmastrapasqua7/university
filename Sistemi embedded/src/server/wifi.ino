void wifiAPSetup() {
//  Serial.printf("%22s", "SETUP WIFI AP... ");
  const char *wifi_ssid = "fiawifi";
  const char *wifi_password = "password";
  
  bool result = WiFi.softAP(wifi_ssid, wifi_password);
  while (result != true) {
    delay(500);
  }
  
//  Serial.println("DONE");
}
