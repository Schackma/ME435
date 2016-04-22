/*
 Name:		PartC.ino
 Created:	4/14/2016 3:41:19 PM
 Author:	schackma
*/

#include <Servo.h> 
#include <ArmServos.h>
#include <ArmServosSpeedControlled.h>
#include <RobotAsciiCom.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20); // you've changed pin numbers!

ArmServosSpeedControlled robotArm;

RobotAsciiCom robotCom;



void setup(){
	robotArm.attach();

	Serial.begin(9600);  // Any speed is ok
						 // Register functions to be called when that command is received.
	robotCom.registerPositionCallback(positionCallback);
	robotCom.registerJointAngleCallback(jointAngleCallback);
	robotCom.registerGripperCallback(gripperCallback);
	lcd.begin(16, 2);
	lcd.clear();

}

void loop() {
	if (Serial.available() > 0) {
		robotCom.handleRxByte(Serial.read());
	}
	robotArm.updateServos();
}


void serialEvent() {
	while (Serial.available()) {
		robotCom.handleRxByte(Serial.read());
	}
}


// Called when a POSITION command is received.
void positionCallback(int joint1Angle, int joint2Angle, int joint3Angle, int joint4Angle, int joint5Angle) {
	lcd.clear();
	lcd.setCursor(0, 0);
	// Inform ArmServo of the position command.
	lcd.print(joint1Angle);
	lcd.print(" ");
	lcd.print(joint2Angle);
	lcd.print(" ");
	lcd.print(joint3Angle);
	lcd.setCursor(0, 1);
	lcd.print(joint4Angle);
	lcd.print(" ");
	lcd.print(joint5Angle);
	robotArm.setPosition(joint1Angle, joint2Angle, joint3Angle, joint4Angle, joint5Angle);

}

// Called when a JOINT ANGLE command is received.
void jointAngleCallback(byte jointNumber, int jointAngle) {
	// Inform ArmServo of the set joint angle command.
	robotArm.setJointAngle(jointNumber, jointAngle);
}

// Called when a GRIPPER command is received.
void gripperCallback(int gripperDistance) {
	// Inform ArmServo of the gripper command.
	Serial.println("gripper called");
	Serial.println(gripperDistance);
	robotArm.setGripperDistance(gripperDistance);
}

