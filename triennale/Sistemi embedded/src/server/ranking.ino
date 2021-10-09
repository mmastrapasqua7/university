#define PILOTS_NUMBER 20
#define NO_TIME 4000000000

char *pilotName[20] = {
  "HAM", "BOT", "VER", "VET", "LEC",
  "GAS", "SAI", "NOR", "RAI", "RIC",
  "HUL", "MAG", "PER", "KYV", "ALB",
  "STR", "GRO", "GIO", "RUS", "KUB"
};

void rankingSetup() {
//  Serial.printf("%22s", "SETUP CLASSIFICA... ");
  for (byte i = 0; i < PILOTS_NUMBER; i++) {
    Pilot *newPilot = (Pilot*) malloc(sizeof(Pilot));
    newPilot->name = pilotName[i];
    newPilot->time = NO_TIME;
    ranking[i] = newPilot;
  }
  
  sortClassifica(0, PILOTS_NUMBER);
//  Serial.println("DONE");
}

int indexOfPilot(String name) {
  for (byte i = 0; i < PILOTS_NUMBER; i++) {
    if ( (String(ranking[i]->name)).equals(name) ) {
      return i;
    }
  }
  return -1;
}

String printTime(unsigned long time) {
  if (time == (unsigned long) NO_TIME) {
    return String("NO TIME");
  }
  
  char buffer[20] = {'\0'};
  sprintf(buffer, "%ld:%02ld.%03ld",
    (time / 1000) / 60,
    (time / 1000) % 60,
    time % 1000);

  return String(buffer);
}

String printInterval(unsigned long current, unsigned long precedent) {
  char buffer[20] = {'\0'};
  sprintf(buffer, " +%ld.%03ld",
    ((current - precedent) / 1000) % 60,
    (current - precedent) % 1000);

  return String(buffer);
}
