#include <WiFi.h>
#include <WiFiClient.h>
#define PILOTS_NUMBER 20

struct Pilot {
  char *name;
  unsigned long time;
};

Pilot *ranking[PILOTS_NUMBER];

void setup() {
  Serial.begin(9600);
//  Serial.println("---> F1 TIMER (dei poveri) <---\n");

  rankingSetup();
  semaphoreSetup();
  notifySetup();
//  sensorSetup();
  wifiAPSetup();
  serverSetup();


  /* TESTING */
  semaphoreTest();
//  notifyPerformanceLEDTest();
}

void loop() {
  listenAndServe();
}

/**********/
/* SERVER */
/**********/

WiFiServer server(80);

void serverSetup() {
//  Serial.printf("%22s", "SETUP WIFI SERVER... ");
  server.begin();
//  Serial.println("DONE\n");
  
//  Serial.print("AP IP Address: ");
//  Serial.println(WiFi.softAPIP());
}

void listenAndServe() {
  WiFiClient client = server.available(); // listen

  if (client) {
//    Serial.println("New Client.");
    String currentLine = "";

    while (client.connected()) {
      if (client.available()) {
        char receivedByte = client.read();
        currentLine += receivedByte;
        
        if (currentLine.endsWith("END")) {
          client.stop();
          handleData(currentLine);
          break;
        }
        
        if (currentLine.endsWith("GET /stats")) {
          handleHTTPRequestForStats(client);
          break;
        }
      }
    }
  }
}

void handleData(String currentLine) {
//  Serial.println("Client CAR Disconnected.");
          
  String pilotName = currentLine.substring(0, 3); // 3 chars
  int indexAfterTime = currentLine.lastIndexOf(' ');
  String newTimeString = currentLine.substring(4, indexAfterTime);
  unsigned long newTime = (unsigned long) newTimeString.toInt();

  int index = indexOfPilot(pilotName);
  if (index == -1) {
    return; // error
  }
  
  unsigned long oldTime = ranking[index]->time;
  
  if (newTime < oldTime) {
    ranking[index]->time = newTime;
    notifyPerformanceLED("fuxia");
  } else if (newTime >= oldTime && newTime <= (oldTime+3000)) {
    notifyPerformanceLED("green");
  } else {
    notifyPerformanceLED("yellow");
  }

  sortClassifica(0, PILOTS_NUMBER);

  index = indexOfPilot(pilotName);
  if (index == -1) {
    return; // error
  }
  
  if (index == 0) { // se sei primo
    notifyFastestLapOnDisplay();
  }

//  Serial.println(pilotName + " " + printTime(newTime));
  return;
}

void handleHTTPRequestForStats(WiFiClient client) {
  client.println("HTTP/1.1 200 OK");
  client.println("Content-type:text/html");
  client.println("Connection: close");
  client.println();       
  
  client.print(
    "<!DOCTYPE html>"
    "<html>"
    "<head>"
    "<meta charset=\"UTF-8\">"
    "<title>F1 Timer</title>"
    "<link rel=\"shortcut icon\" href=\"data:image/x-icon;,\" type=\"image/x-icon\">" // prevent favicon fetch 
    "</head>"      
    "<body>"
    "<table>"
    "<thead>"
    "<tr>"
    "<th>PILOT</th>"
    "<th>TIME</th>"
    "<th>INTERVAL</th>"
    "</tr>"
    "</thead>"
    "<tbody>");
  
  for (byte i = 0; i < PILOTS_NUMBER; i++) {
    client.println("<tr>");
    client.printf("<td>%s</td>\n", ranking[i]->name);
    client.println("<td>" + printTime(ranking[i]->time) + "</td>");
  
    if (i == 0) {
      client.println("<td> -</td>");
    } else {
      if (ranking[i]->time != 4000000000) {
        client.println("<td>" + printInterval(ranking[i]->time, ranking[i-1]->time) + "</td>");
      }
    }
  
    client.println("</tr>");
  }
  
  client.print(
    "</tbody>"
    "</body>"
    "</html>");

  client.flush();
  while (client.connected()) {
    delay(10);
  }
  client.stop();
//  Serial.println("Client HTTP Disconnected.");
}
