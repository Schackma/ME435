/*
 ME435 Shield Template
 Name:		Exam2_Horve.ino
 Created:	4/14/2016 11:47:20 AM
 Author:	horvegc
*/

#include <LiquidCrystal.h>

/***  Pin I/O   ***/
#define PIN_LED_6 69
#define PIN_RIGHT_BUTTON 2
#define PIN_VERT_ANALOG 1

/*** Interrupt flags ***/
volatile int mainEventFlags = 0;
#define FLAG_INTERRUPT_0 0x01

/***  LCD ***/
LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20);
#define LINE_1 0

int prevVert;
int starCount = 0;
unsigned long lastStartTime = 0;

void setup() {
	Serial.begin(9600);
	pinMode(PIN_LED_6, OUTPUT);
	digitalWrite(PIN_LED_6, LOW);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);
	attachInterrupt(0, int0_isr, FALLING);
	lcd.begin(16, 2);
	prevVert = analogRead(PIN_VERT_ANALOG);
	lastStartTime = millis();
}

void loop() {
	vertPrint(analogRead(PIN_VERT_ANALOG));
	toggleLED6();
	addStar();

	if (mainEventFlags & FLAG_INTERRUPT_0) {
		delay(20);
		mainEventFlags &= ~FLAG_INTERRUPT_0;
		if (!digitalRead(PIN_RIGHT_BUTTON)) {
			lcd.clear();
			starCount = 0;
		}
	}
}

void vertPrint(int vertReading) {
	if (abs(vertReading-prevVert) > 10) {
		prevVert = vertReading;
		Serial.println(vertReading);
	}
}

void toggleLED6() {
	if (Serial.available()) {
		char newChar = Serial.read();
		if (newChar == '0' || newChar == '2' || newChar == '4' || newChar == '6' || newChar == '8') {
			digitalWrite(PIN_LED_6, LOW);
		} else if (newChar == '1' || newChar == '3' || newChar == '5' || newChar == '7' || newChar == '9') {
			digitalWrite(PIN_LED_6, HIGH);
		}
	}
}

void addStar() {
	if (millis() - lastStartTime > 1000 && starCount < 17) {
		lcd.write('*');
		starCount++;
		lastStartTime = millis();
	}
}

void int0_isr() {
	mainEventFlags |= FLAG_INTERRUPT_0;
}