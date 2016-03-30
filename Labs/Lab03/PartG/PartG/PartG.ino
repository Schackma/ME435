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

#define PIN_SELECT_BUTTON 21

#define PIN_CONTRAST_ANALOG 8

#define PIN_HORZ_ANALOG 1
#define PIN_VERT_ANALOG 2

#define FLAG_INTERRUPT_0 0x01
#define FLAG_INTERRUPT_1 0x02
#define FLAG_INTERRUPT_2 0x04

#include <LiquidCrystal.h>

LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20); // you've changed pin numbers!

volatile int mainEventFlags = 0b0000000000000011;
int vertReading, horzReading;

void setup() {
	lcd.begin(16, 2);
	pinMode(PIN_LEFT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_SELECT_BUTTON, INPUT_PULLUP);
	attachInterrupt(0, int0_isr, FALLING);
	attachInterrupt(1, int1_isr, FALLING);
}

void loop() {
	// lcd.setCursor(column, line);
	// Set the cursor to column 0, line 1
	// If line = 1 that’s the second row, since counting begins with 0
	lcd.setCursor(0, 0);
	lcd.print("Horz = ");
	lcd.print(horzReading);
	lcd.print("  ");
	lcd.setCursor(0, 1);
	lcd.print("Vert = ");
	lcd.print(vertReading);
	lcd.print("  ");
	vertReading = analogRead(PIN_HORZ_ANALOG);
	horzReading = analogRead(PIN_VERT_ANALOG);

	if (!digitalRead(PIN_SELECT_BUTTON)) {
		digitalWrite(PIN_LED_2, HIGH);
	}
	else {
		digitalWrite(PIN_LED_2, LOW);
	}

	if (!digitalRead(PIN_LEFT_BUTTON)) {
		digitalWrite(PIN_LED_4, HIGH);
	}
	else {
		digitalWrite(PIN_LED_4, LOW);
	}

	if (!digitalRead(PIN_RIGHT_BUTTON)) {
		digitalWrite(PIN_LED_6, HIGH);
	}
	else {
		digitalWrite(PIN_LED_6, LOW);
	}
}

void int0_isr() {
	mainEventFlags |= FLAG_INTERRUPT_0;
}

void int1_isr() {
	mainEventFlags |= FLAG_INTERRUPT_1;
}
