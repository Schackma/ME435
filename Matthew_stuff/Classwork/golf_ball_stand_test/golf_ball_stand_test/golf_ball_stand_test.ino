/*
 Name:		golf_ball_stand_test.ino
 Created:	4/12/2016 12:47:07 PM
 Author:	schackma
*/

#include <GolfBallStand.h>

GolfBallStand stand;

// the setup function runs once when you press reset or power the board
void setup() {
	Serial.begin(9600);
	stand.setLedState(LED_RED, LOCATION_3, LED_FRONT);
}

// the loop function runs over and over again until power down or reset
void loop() {

	stand.determineBallColor(LOCATION_1);
	delay(1000);
  
}
