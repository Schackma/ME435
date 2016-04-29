#include <GolfBallStand.h>

GolfBallStand stand;
int ballColor_1, ballColor_2, ballColor_3;

int[] location1_red = [1023,440,851,977,408];
int[] location1_green = [1023,731,602,933,481];
int[] location1_blue = [1023,731,636,862,480];
int[] location1_yellow = [1019,227,368,899,175];
int[] location1_black = [1022,902,881,985,774];
int[] location1_white = [1007,227,315,655,156];

int[] location2_red = [1022,639,826,969,558];
int[] location2_green = [1022,901,653,868,579];
int[] location2_blue = [1022,639,826,969,558];
int[] location2_yellow = [1020,440,380,906,273];
int[] location2_black = [1022,967,863,976,801];
int[] location2_white = [1010,389,290,661,207];

int[] location3_red = [1023,654,965,932,597];
int[] location3_green = [1023,853,825,802,617];
int[] location3_blue = [1023,875,873,659,561];
int[] location3_yellow = [1016,412,652,761,329];
int[] location3_black = [1022,912,944,855,758];
int[] location3_white = [1022,404,580,404,240];

void setup() {
  Serial.begin(9600);
  stand.setLedState(LED_RED, LOCATION_3, LED_FRONT);
}

void loop() {
  while(digitalRead(PIN_GOLF_BALL_STAND_SWITCH)) {
    // Do nothing until the switch is pressed.
  }
  ballColor_1 = stand.determineBallColor(LOCATION_1);
  Serial.print("  Location 1 ball   = ");
  printBallColor(ballColor_1);
  delay(1000);
  ballColor_2 = stand.determineBallColor(LOCATION_2);
  Serial.print("  Location 2 ball   = ");
  printBallColor(ballColor_2);
  delay(1000);
  ballColor_3 = stand.determineBallColor(LOCATION_3);
  Serial.print("  Location 3 ball   = ");
  printBallColor(ballColor_3);
  delay(1000);
  stand.setLedState(LED_GREEN, LOCATION_3, LED_FRONT);
  
  // External reading.
  int externalPhotoCellReading = stand.getAnalogReading(LOCATION_EXTERNAL);
  // Note, you don't have to use the library function.
  //int externalPhotoCellReading = analogRead(PIN_PHOTO_EXTERNAL);
  Serial.println();
  Serial.print("External photo cell reading = ");
  Serial.print(externalPhotoCellReading);  
  Serial.println(externalPhotoCellReading > 950 ? " (ball present)" : " (no ball)");
  
  // Pretty lights for fun.
//  stand.setLedState(LED_RED, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
//  delay(1000);
//  stand.setLedState(LED_GREEN, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
//  delay(1000);
//  stand.setLedState(LED_BLUE, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
//  delay(1000); 
//  stand.setLedState(LED_WHITE, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
//  delay(1000); 
//  stand.setLedState(LED_OFF, 0, 0);
}

void printBallColor(int ballColor) {
  switch (ballColor) {
    case BALL_NONE:
      Serial.println("No ball");
      break;
    case BALL_BLACK:
      Serial.println("Black ball");
      break;
    case BALL_BLUE:
      Serial.println("Blue ball");
      break;
    case BALL_GREEN:
      Serial.println("Green ball");
      break;
    case BALL_RED:
      Serial.println("Red ball");
      break;
    case BALL_YELLOW:
      Serial.println("Yellow ball");
      break;
    case BALL_WHITE:
      Serial.println("White ball");
      break;
  }
}
