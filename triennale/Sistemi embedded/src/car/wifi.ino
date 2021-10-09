void setupWifiClient() {
  Serial.print("CONNECTING TO WIFI AP... ");
  const char* wifi_ssid = "fiawifi";
  const char* wifi_password = "password";
  
  WiFi.begin(wifi_ssid, wifi_password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(10);
  }
  Serial.println("DONE");
}

void sendTimeToServer(unsigned long newTime) {
  const char* server_ip = "192.168.4.1";
  const int server_port = 80;
  
  if (!client.connect(server_ip, server_port)) {
    delay(10);
  }

  Serial.println("Sending data to server: " + pilotName + " " + String(newTime) + " END");
  client.print(pilotName);
  client.print(" ");
  client.print(String(newTime));
  client.print(" END");

  client.flush();
}
