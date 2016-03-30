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

#define PIN_CONTRAST_ANALOG 8

#define FLAG_INTERRUPT_0 0x01
#define FLAG_INTERRUPT_1 0x02
#define FLAG_INTERRUPT_2 0x04

#include <LiquidCrystal.h>

LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20); // you've changed pin numbers!

volatile int mainEventFlags = 0b0000000000000011;
int analogReading;

void setup() {
	lcd.begin(16, 2);
	pinMode(PIN_LEFT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);
	attachInterrupt(0, int0_isr, FALLING);
	attachInterrupt(1, int1_isr, FALLING);
}

void loop() {
	// lcd.setCursor(column, line);
	// Set the cursor to column 0, line 1
	// If line = 1 that’s the second row, since counting begins with 0
	lcd.setCursor(0, 0);
	lcd.print("Reading = ");
	lcd.print(analogReading);
	lcd.print("  ");
	lcd.setCursor(0, 1);
	lcd.print("Voltage = ");
	lcd.print((float)analogReading / 1023.0 * 5.0);
	lcd.print("  ");
	analogReading = analogRead(PIN_CONTRAST_ANALOG);
}

void int0_isr() {
	mainEventFlags |= FLAG_INTERRUPT_0;
}

void int1_isr() {
	mainEventFlags |= FLAG_INTERRUPT_1;
}
