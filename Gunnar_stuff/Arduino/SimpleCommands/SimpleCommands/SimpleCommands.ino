#include <Servo.h>
#include <ArmServos.h>
#include <RobotAsciiCom.h>

ArmServos armServos;
RobotAsciiCom robotCom;

void setup() {
	Serial.begin(9600);
	delay(100);
	armServos.attach();
	robotCom.registerPositionCallback(positionCallback);
	robotCom.registerJointAngleCallback(jointAngleCallback);
	robotCom.registerGripperCallback(gripperCallback);
	robotCom.registerAttachSelectedServosCallback(attachSelectedServosCallback);
}

void positionCallback(int joint1Angle, int joint2Angle, int joint3Angle, int joint4Angle, int joint5Angle) {
	armServos.setPosition(joint1Angle, joint2Angle, joint3Angle, joint4Angle, joint5Angle);
	Serial.print("Sending the arm to ");
	Serial.print(joint1Angle);
	Serial.print("  ");
	Serial.print(joint2Angle);
	Serial.print("  ");
	Serial.print(joint3Angle);
	Serial.print("  ");
	Serial.print(joint4Angle);
	Serial.print("  ");
	Serial.println(joint5Angle);
}

void jointAngleCallback(byte jointNumber, int jointAngle) {
	armServos.setJointAngle(jointNumber, jointAngle);
	Serial.print("Moving joint ");
	Serial.print(jointNumber);
	Serial.print(" to angle ");
	Serial.println(jointAngle);
}

void gripperCallback(int gripperDistance) {
	armServos.setGripperDistance(gripperDistance);
	Serial.print("Moving the gripper to ");
	Serial.print(gripperDistance);
	Serial.println(" mm");
}

void attachSelectedServosCallback(byte servosToEnable) {
	armServos.attachSelectedServos(servosToEnable);
	Serial.print("Enable the following servos: ");
	Serial.println(servosToEnable, BIN);
}

void loop() {

}


/** Send all bytes received to the Wild Thumper Com object. */
void serialEvent() {
	while (Serial.available()) {
		robotCom.handleRxByte(Serial.read());
	}
}
