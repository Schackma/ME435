/*
 Name:		PartB.ino
 Created:	4/14/2016 3:41:19 PM
 Author:	schackma
*/

#include <Servo.h> 
#include <ArmServos.h>


ArmServos robotArm;

int servoAngles[] = { 10,0,90,0,-90,90 };


void setup(){
	robotArm.attach();
	servoAngles[1] = constrain(servoAngles[1], -90, 90);
	servoAngles[2] = constrain(servoAngles[2], 0, 180);
	servoAngles[3] = constrain(servoAngles[3], -90, 90);
	servoAngles[4] = constrain(servoAngles[4], -180, 0);
	servoAngles[5] = constrain(servoAngles[5], 0, 180);
	servoAngles[0] = constrain(servoAngles[0], 0, 71);
	robotArm.setPosition(servoAngles[1], servoAngles[2], servoAngles[3], servoAngles[4], servoAngles[5]);
	robotArm.setGripperDistance(servoAngles[0]);
}

void loop() {

}
