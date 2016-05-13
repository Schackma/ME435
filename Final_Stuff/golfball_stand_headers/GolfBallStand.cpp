#include "Arduino.h"
#include "GolfBallStand.h"
#include <math.h>

int location1_red[5] = { 1023,440,851,977,408 };
int location1_green[5] = { 1023,731,602,933,481 };
int location1_blue[5] = { 1023,731,636,862,480 };
int location1_yellow[5] = { 1019,227,368,899,175 };
int location1_black[5] = { 1022,902,881,985,774 };
int location1_white[5] = { 1007,227,315,655,156 };

int location2_red[5] = { 1022,639,826,969,558 };
int location2_green[5] = { 1022,901,653,868,579 };
int location2_blue[5] = { 1022,639,826,969,558 };
int location2_yellow[5] = { 1020,440,380,906,273 };
int location2_black[5] = { 1022,967,863,976,801 };
int location2_white[5] = { 1010,389,290,661,207 };

int location3_red[5] = { 1023,654,965,932,597 };
int location3_green[5] = { 1023,853,825,802,617 };
int location3_blue[5] = { 1023,875,873,659,561 };
int location3_yellow[5] = { 1016,412,652,761,329 };
int location3_black[5] = { 1022,912,944,855,758 };
int location3_white[5] = { 1022,404,580,404,240 };

GolfBallStand::GolfBallStand() {
	_init();
}

void GolfBallStand::_init() {
	pinMode(PIN_LED_1_UNDER, OUTPUT);
	pinMode(PIN_LED_1_FRONT, OUTPUT);
	pinMode(PIN_LED_2_UNDER, OUTPUT);
	pinMode(PIN_LED_2_FRONT, OUTPUT);
	pinMode(PIN_LED_3_UNDER, OUTPUT);
	pinMode(PIN_LED_3_FRONT, OUTPUT);
	pinMode(PIN_RED, OUTPUT);
	pinMode(PIN_GREEN, OUTPUT);
	pinMode(PIN_BLUE, OUTPUT);
	pinMode(PIN_GOLF_BALL_STAND_SWITCH, INPUT_PULLUP);
	digitalWrite(PIN_LED_1_UNDER, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_1_FRONT, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_2_UNDER, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_2_FRONT, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_3_UNDER, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_3_FRONT, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_RED, COLOR_TRANSISTOR_OFF);
	digitalWrite(PIN_GREEN, COLOR_TRANSISTOR_OFF);
	digitalWrite(PIN_BLUE, COLOR_TRANSISTOR_OFF);
}

void GolfBallStand::setLedState(int ledColor, int location,
		int underOrFront) {
	// Start by clearing off all LEDs and colors.
	digitalWrite(PIN_RED, COLOR_TRANSISTOR_OFF);
	digitalWrite(PIN_GREEN, COLOR_TRANSISTOR_OFF);
	digitalWrite(PIN_BLUE, COLOR_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_1_UNDER, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_2_UNDER, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_3_UNDER, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_1_FRONT, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_2_FRONT, LED_TRANSISTOR_OFF);
	digitalWrite(PIN_LED_3_FRONT, LED_TRANSISTOR_OFF);

	// Decide which of the six LEDs to turn on.
	if ((location & LOCATION_1) && (underOrFront & LED_UNDER)) {
		digitalWrite(PIN_LED_1_UNDER, LED_TRANSISTOR_ON);
	}
	if ((location & LOCATION_1) && (underOrFront & LED_FRONT)) {
		digitalWrite(PIN_LED_1_FRONT, LED_TRANSISTOR_ON);
	}
	if ((location & LOCATION_2) && (underOrFront & LED_UNDER)) {
		digitalWrite(PIN_LED_2_UNDER, LED_TRANSISTOR_ON);
	}
	if ((location & LOCATION_2) && (underOrFront & LED_FRONT)) {
		digitalWrite(PIN_LED_2_FRONT, LED_TRANSISTOR_ON);
	}
	if ((location & LOCATION_3) && (underOrFront & LED_UNDER)) {
		digitalWrite(PIN_LED_3_UNDER, LED_TRANSISTOR_ON);
	}
	if ((location & LOCATION_3) && (underOrFront & LED_FRONT)) {
		digitalWrite(PIN_LED_3_FRONT, LED_TRANSISTOR_ON);
	}

	// Set the color.
	if (ledColor & LED_BLUE) {
		digitalWrite(PIN_BLUE, COLOR_TRANSISTOR_ON);
	}
	if (ledColor & LED_GREEN) {
		digitalWrite(PIN_GREEN, COLOR_TRANSISTOR_ON);
	}
	if (ledColor & LED_RED) {
		digitalWrite(PIN_RED, COLOR_TRANSISTOR_ON);
	}
}

int GolfBallStand::getAnalogReading(int location) {
	int photoReading = -1;
	switch (location) {
	case LOCATION_1:
		photoReading = analogRead(PIN_PHOTO_1);
		break;
	case LOCATION_2:
		photoReading = analogRead(PIN_PHOTO_2);
		break;
	case LOCATION_3:
		photoReading = analogRead(PIN_PHOTO_3);
		break;
	case LOCATION_EXTERNAL:
		photoReading = analogRead(PIN_PHOTO_EXTERNAL);
		break;
	}
	return photoReading;
}

void GolfBallStand::getLedReadings(int location, int values[]) {
	setLedState(LED_OFF, location, LED_UNDER_AND_FRONT);
	delay(TIME_DELAY);
	values[0] = getAnalogReading(location);

	setLedState(LED_RED, location, LED_UNDER_AND_FRONT);
	delay(TIME_DELAY);
	values[1] = getAnalogReading(location);

	setLedState(LED_GREEN, location, LED_UNDER_AND_FRONT);
	delay(TIME_DELAY);
	values[2] = getAnalogReading(location);

	setLedState(LED_BLUE, location, LED_UNDER_AND_FRONT);
	delay(TIME_DELAY);
	values[3] = getAnalogReading(location);

	setLedState(LED_WHITE, location, LED_UNDER_AND_FRONT);
	delay(TIME_DELAY);
	values[4] = getAnalogReading(location);

	setLedState(LED_OFF, location, LED_UNDER_AND_FRONT);
}

int GolfBallStand::determineBallColor(int location) {
	int values[5] = { 0 };
	getLedReadings(location, values);
	Serial.println();
	Serial.print("Readings for location ");
	Serial.println(location == LOCATION_3 ? 3 : location);
	Serial.print("  LED off reading   = ");
	Serial.println(values[0]);
	Serial.print("  LED red reading   = ");
	Serial.println(values[1]);
	Serial.print("  LED green reading = ");
	Serial.println(values[2]);
	Serial.print("  LED blue reading  = ");
	Serial.println(values[3]);
	Serial.print("  LED white reading = ");
	Serial.println(values[4]);

	//int values[5] = { offReading, redReading,greenReading,blueReading,whiteReading };
	double red_dist, blue_dist, green_dist, white_dist, black_dist, yellow_dist;

	switch (location) {
	case(LOCATION_1) :
		red_dist = calcBallValue(values, location1_red);
		blue_dist = calcBallValue(values, location1_blue);
		green_dist = calcBallValue(values, location1_green);
		white_dist = calcBallValue(values, location1_white);
		black_dist = calcBallValue(values, location1_black);
		yellow_dist = calcBallValue(values, location1_yellow);
		break;
	case(LOCATION_2) :
		red_dist = calcBallValue(values, location2_red);
		blue_dist = calcBallValue(values, location2_blue);
		green_dist = calcBallValue(values, location2_green);
		white_dist = calcBallValue(values, location2_white);
		black_dist = calcBallValue(values, location2_black);
		yellow_dist = calcBallValue(values, location2_yellow);
		break;
	case(LOCATION_3) :
		red_dist = calcBallValue(values, location3_red);
		blue_dist = calcBallValue(values, location3_blue);
		green_dist = calcBallValue(values, location3_green);
		white_dist = calcBallValue(values, location3_white);
		black_dist = calcBallValue(values, location3_black);
		yellow_dist = calcBallValue(values, location3_yellow);
		break;
	default:
		Serial.print("BAD INPUT");
		return BALL_NONE;
		break;
	}

	double dists[6] = { red_dist,blue_dist, green_dist, white_dist, black_dist, yellow_dist };
	int minIndex = findMin(dists);

	//Debugging
	// for(int i=0;i<sizeof(dists)/sizeof(dists[0]);i++){
	// Serial.println(dists[i]);
	// }
	// Serial.println(minIndex);
	//Debugging

	int returnArray[6] = { BALL_RED,BALL_BLUE,BALL_GREEN,BALL_WHITE,BALL_BLACK,BALL_YELLOW };
	return returnArray[minIndex];
}

double GolfBallStand::calcBallValue(int foundArray[], int valueArray[]) {
	return sqrt(pow(foundArray[0] - valueArray[0], 2) + pow(foundArray[1] - valueArray[1], 2) +
		pow(foundArray[2] - valueArray[2], 2) + pow(foundArray[3] - valueArray[3], 2) +
		pow(foundArray[4] - valueArray[4], 2));
}

int GolfBallStand::findMin(double values[]) {
	int minIndex = 0;
	for (int i = 1; i < 6; i++) {
		if (values[i] < values[minIndex]) {
			minIndex = i;
		}
	}
	return minIndex;
}

void GolfBallStand::calibrate(int ball1, int ball2, int ball3) {
	int newValues[5];
	getLedReadings(LOCATION_1, newValues);
	findAndMerge(LOCATION_1, ball1, newValues);

	getLedReadings(LOCATION_2, newValues);
	findAndMerge(LOCATION_2, ball2, newValues);

	getLedReadings(LOCATION_3, newValues);
	findAndMerge(LOCATION_3, ball3, newValues);
}

void GolfBallStand::findAndMerge(int location, int ball_color, int newValues[]) {
	switch (location) {
	case LOCATION_1:
		switch (ball_color) {
		case BALL_BLACK:
			mergeArrays(location1_black, newValues);
			break;
		case BALL_BLUE:
			mergeArrays(location1_blue, newValues);
			break;
		case BALL_GREEN:
			mergeArrays(location1_green, newValues);
			break;
		case BALL_RED:
			mergeArrays(location1_red, newValues);
			break;
		case BALL_WHITE:
			mergeArrays(location1_white, newValues);
			break;
		case BALL_YELLOW:
			mergeArrays(location1_yellow, newValues);
			break;
		}
		break;
	case LOCATION_2:
		switch (ball_color) {
		case BALL_BLACK:
			mergeArrays(location2_black, newValues);
			break;
		case BALL_BLUE:
			mergeArrays(location2_blue, newValues);
			break;
		case BALL_GREEN:
			mergeArrays(location2_green, newValues);
			break;
		case BALL_RED:
			mergeArrays(location2_red, newValues);
			break;
		case BALL_WHITE:
			mergeArrays(location2_white, newValues);
			break;
		case BALL_YELLOW:
			mergeArrays(location2_yellow, newValues);
			break;
		}
		break;
	case LOCATION_3:
		switch (ball_color) {
		case BALL_BLACK:
			mergeArrays(location3_black, newValues);
			break;
		case BALL_BLUE:
			mergeArrays(location3_blue, newValues);
			break;
		case BALL_GREEN:
			mergeArrays(location3_green, newValues);
			break;
		case BALL_RED:
			mergeArrays(location3_red, newValues);
			break;
		case BALL_WHITE:
			mergeArrays(location3_white, newValues);
			break;
		case BALL_YELLOW:
			mergeArrays(location3_yellow, newValues);
			break;
		}
		break;
	}
}

void GolfBallStand::mergeArrays(int inArray[], int outArray[]) {
	for (int i = 0; i < 5; i++) {
		inArray[i] = outArray[i];
	}
}
