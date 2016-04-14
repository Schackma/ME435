/*
 Name:		GolfBallStand_InClass.ino
 Created:	4/12/2016 12:57:50 PM
 Author:	horvegc
*/

#include <GolfBallStand.h>

GolfBallStand stand;

// the setup function runs once when you press reset or power the board
void setup() {
	Serial.begin(9600);
	//stand.setLedState(LED_GREEN, LOCATION_2, LED_FRONT);
	//stand.setLedState(LED_GREEN, LOCATION_3, LED_UNDER);
	//stand.setLedState(LED_RED, LOCATION_2, LED_FRONT);
	//stand.setLedState(LED_RED, LOCATION_1, LED_FRONT);
}

// the loop function runs over and over again until power down or reset
void loop() {
	// Pretty lights for fun.
	stand.setLedState(LED_RED, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
	delay(1000);
	stand.setLedState(LED_GREEN, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
	delay(1000);
	stand.setLedState(LED_BLUE, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
	delay(1000);
	stand.setLedState(LED_WHITE, LOCATION_1 | LOCATION_2 | LOCATION_3, LED_UNDER | LED_FRONT);
	delay(1000);
	stand.setLedState(LED_OFF, 0, 0);
	delay(1000);
}