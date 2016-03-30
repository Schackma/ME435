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

#define PIN_HORZ_ANALOG 0
#define PIN_VERT_ANALOG 1

#define FLAG_INTERRUPT_0 0x01
#define FLAG_INTERRUPT_1 0x02
#define FLAG_INTERRUPT_2 0x04

#define max_threshold 900
#define min_threshold 100

#define DELAY_TIME 100

#include <LiquidCrystal.h>

LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20); // you've changed pin numbers!

volatile int mainEventFlags = 0b0000000000000011;
int vertReading, horzReading;
int light = PIN_LED_1;

int angles[] = { 90,90,90,90,90,90 };

void setup() {
	lcd.begin(16, 2);
	pinMode(PIN_LEFT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_SELECT_BUTTON, INPUT_PULLUP);
	attachInterrupt(0, int0_isr, FALLING);
	attachInterrupt(1, int1_isr, FALLING);
	digitalWrite(light, HIGH);
}

void loop() {
	// lcd.setCursor(column, line);
	// Set the cursor to column 0, line 1
	// If line = 1 that’s the second row, since counting begins with 0
	lcd.setCursor(0, 0);
	for (int i = 0; i < 3; i++) {
		lcd.print(angles[i]);
		lcd.print("  ");
	}
	lcd.setCursor(0, 1);
	for (int i = 3; i < 6; i++) {
		lcd.print(angles[i]);
		lcd.print("  ");
	}

	if (!digitalRead(PIN_SELECT_BUTTON)) {
		angles[light%PIN_LED_1] = 90;
	}


	vertReading = analogRead(PIN_VERT_ANALOG);

	if (vertReading > max_threshold) {
		angles[light%PIN_LED_1] += 4;
		if (angles[light%PIN_LED_1] > 180) {
			angles[light%PIN_LED_1] = 180;
		}
	}
	else if (vertReading < min_threshold) {
		angles[light%PIN_LED_1] -= 4;
		if (angles[light%PIN_LED_1] < 0) {
			angles[light%PIN_LED_1] = 0;
		}
	}

	horzReading = analogRead(PIN_HORZ_ANALOG);

	if (horzReading > max_threshold) {
		angles[light%PIN_LED_1] += 1;
		if (angles[light%PIN_LED_1] > 180) {
			angles[light%PIN_LED_1] = 180;
		}
	}
	else if (horzReading < min_threshold) {
		angles[light%PIN_LED_1] -= 1;
		if (angles[light%PIN_LED_1] < 0) {
			angles[light%PIN_LED_1] = 0;
		}
	}


	if (mainEventFlags & FLAG_INTERRUPT_0) {
		delay(20);
		mainEventFlags &= ~FLAG_INTERRUPT_0;
		if (!digitalRead(PIN_RIGHT_BUTTON)) {
			digitalWrite(light, LOW);
			light++;
			if (light > PIN_LED_6) {
				light = PIN_LED_1;
			}
			digitalWrite(light, HIGH);
		}
	}
	if (mainEventFlags & FLAG_INTERRUPT_1) {
		delay(20);
		mainEventFlags &= ~FLAG_INTERRUPT_1;
		if (!digitalRead(PIN_LEFT_BUTTON)) {
			digitalWrite(light, LOW);
			light--;
			if (light < PIN_LED_1) {
				light = PIN_LED_6;
			}
			digitalWrite(light, HIGH);
		}
	}
	delay(DELAY_TIME);

}

void int0_isr() {
	mainEventFlags |= FLAG_INTERRUPT_0;
}

void int1_isr() {
	mainEventFlags |= FLAG_INTERRUPT_1;
}
