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

#include <LiquidCrystal.h>

LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20); // you've changed pin numbers!
int age = 21;

void setup() {
	lcd.begin(16, 2);
	lcd.print("Matthew  Schack is!");
	pinMode(PIN_LEFT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);
	attachInterrupt(0, int0_isr, FALLING);
	attachInterrupt(1, int1_isr, FALLING);
}

void loop() {
	// lcd.setCursor(column, line);
	// Set the cursor to column 0, line 1
	// If line = 1 that’s the second row, since counting begins with 0
	lcd.setCursor(0, 1);
	// print the number of seconds since reset:
	lcd.print(age);
	lcd.print(" years old.");
}

void int0_isr() {
	age++;
}
void int1_isr() {
	age--;
}
