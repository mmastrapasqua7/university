#include <WiFi.h>
#include <WiFiClient.h>
#define PILOTS_NUMBER 20

WiFiClient client;
String pilotName;

char *pilotsName[PILOTS_NUMBER] = {
  "HAM", "BOT", "VER", "VET", "LEC",
  "GAS", "SAI", "NOR", "RAI", "RIC",
  "HUL", "MAG", "PER", "KYV", "ALB",
  "STR", "GRO", "GIO", "RUS", "KUB"
};

unsigned long startTime;
unsigned long endTime;

void setup() {
  Serial.begin(9600);

  setupWifiClient();
  pilotName = String(pilotsName[random(PILOTS_NUMBER)]);
  Serial.println("Pilot name: " + pilotName);
  
  waitCarPassBy();
  startTime = millis(); // first probe
  Serial.println("PASSAGGIO MACCHINA");
  delay(2000);
}

void loop() {
  waitCarPassBy();
  endTime = millis();
  Serial.println("PASSAGGIO MACCHINA");
//  
  unsigned long newTime = endTime - startTime;
  startTime = endTime;
  sendTimeToServer(newTime);
//  
  delay(2000);
}

/***********/
/* PASS-BY */
/***********/

const unsigned long RSSI_NEARBY = 40; // distanza di passaggio

void waitCarPassBy() {
  while (WiFi.RSSI()*-1 >= RSSI_NEARBY) {
    ; // wait until it gets close to AP
  }

  long min_rssi = WiFi.RSSI()*-1, current_rssi = WiFi.RSSI()*-1;
  while (current_rssi <= min_rssi) {
    min_rssi = current_rssi;
    current_rssi = WiFi.RSSI()*-1; 
  }
}
