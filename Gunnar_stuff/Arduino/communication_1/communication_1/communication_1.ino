#include <Max3421e.h>
#include <Usb.h>
#include <AndroidAccessory.h>

#define STARTUP_DELAY 1500
#define PIN_LED 13

char manufacturer[] = "Rose-Hulman";
char model[] = "My LED Toggle";
char versionStr[] = "1.0";
char onMessage[] = "I have an idea!";
char offMessage[] = "Nope.  Lost it.";

AndroidAccessory acc(manufacturer, model, "Turning LED 13 on and off", versionStr, "http://sites.google.com/site/me435spring2016", "12345");
char rxBuf[255];

/*
Name:		communication_1.ino
Created:	3/29/2016 12:02:19 PM
Author:	horvegc
*/

// the setup function runs once when you press reset or power the board
void setup() {
	pinMode(PIN_LED, OUTPUT);
	delay(STARTUP_DELAY);
	acc.powerOn();
}

// the loop function runs over and over again until power down or reset
void loop() {
	if (!acc.isConnected()) { return; } // you're not even connected.  What are you trying to pull...?
	int len = acc.read(rxBuf, sizeof(rxBuf), 1);
	if (len <= 0) { return; }           // this isn't a message.  Try again, peasant.
	handleString(len);					// you did it!  You win a prize for adequacy
}

void handleString(int len) {
	rxBuf[len - 1] = '\0';
	String inputString = String(rxBuf);
	if (inputString.equalsIgnoreCase("ON")) {
		digitalWrite(PIN_LED, HIGH);
		acc.write(onMessage, sizeof(onMessage));
	}
	else if (inputString.equalsIgnoreCase("OFF")) {
		digitalWrite(PIN_LED, LOW);
		acc.write(offMessage, sizeof(offMessage));
	}
}