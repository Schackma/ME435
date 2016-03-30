/*
Name:		PartC.ino
Created:	3/30/2016 1:06:07 PM
Author:	horvegc
*/

// the setup function runs once when you press reset or power the board
#define PIN_RIGHT_BUTTON 2
#define PIN_LEFT_BUTTON 3

#define PIN_LED_1 64
#define PIN_LED_2 65
#define PIN_LED_3 66
#define PIN_LED_4 67
#define PIN_LED_5 68
#define PIN_LED_6 69


void setup() {
	pinMode(PIN_LEFT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);

	pinMode(PIN_LED_1, OUTPUT);
	pinMode(PIN_LED_2, OUTPUT);
	pinMode(PIN_LED_3, OUTPUT);
	pinMode(PIN_LED_4, OUTPUT);
	pinMode(PIN_LED_5, OUTPUT);
	pinMode(PIN_LED_6, OUTPUT);

}

// the loop function runs over and over again until power down or reset
void loop() {
	if (!digitalRead(PIN_LEFT_BUTTON)) {
		digitalWrite(PIN_LED_1, HIGH);
		digitalWrite(PIN_LED_2, HIGH);
		digitalWrite(PIN_LED_3, HIGH);
	}
	else {
		digitalWrite(PIN_LED_1, LOW);
		digitalWrite(PIN_LED_2, LOW);
		digitalWrite(PIN_LED_3, LOW);
	}
	if (!digitalRead(PIN_RIGHT_BUTTON)) {
		digitalWrite(PIN_LED_4, HIGH);
		digitalWrite(PIN_LED_5, HIGH);
		digitalWrite(PIN_LED_6, HIGH);
	}
	else {
		digitalWrite(PIN_LED_4, LOW);
		digitalWrite(PIN_LED_5, LOW);
		digitalWrite(PIN_LED_6, LOW);
	}
}
