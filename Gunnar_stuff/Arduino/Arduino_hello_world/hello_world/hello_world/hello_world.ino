/*
 Name:		hello_world.ino
 Created:	3/24/2016 12:16:47 PM
 Author:	horvegc
*/

// the setup function runs once when you press reset or power the board
void setup() {
	Serial.begin(9600);
	Serial.println("Hello, World!");
}

// the loop function runs over and over again until power down or reset
void loop() {
	//if (Serial.available) {}
}

void serialEvent() {
	char newByte = Serial.read();

	Serial.print("Recieved = ");
	Serial.println(newByte);

	Serial.print("     Actual byte value ");
	Serial.println(newByte, DEC);
	Serial.println("     (binary) ");
	Serial.println(newByte, BIN);
}