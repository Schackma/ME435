/*
 Name:		PartA.ino
 Created:	4/14/2016 3:35:31 PM
 Author:	schackma
*/

#include <Servo.h> 

Servo servo_1;
Servo servo_2;
Servo servo_3;
Servo servo_4;
Servo servo_5;
Servo servo_gripper;


void setup()
{
	servo_1.attach(12);
	servo_2.attach(11);
	servo_3.attach(10);
	servo_4.attach(9);
	servo_5.attach(8);
	servo_gripper.attach(6);
	servo_5.write(0);
	servo_2.write(100);
	servo_gripper.write(180);
}

void loop() {
	//servo_gripper.write(45);
	//delay(2000);
	//servo_gripper.write(90);
	//delay(2000);
	//servo_gripper.write(135);
	//delay(2000);

}
