#include <Max3421e.h>
#include <Usb.h>
#include <AndroidAccessory.h>
#include <LiquidCrystal.h>
#include <RobotAsciiCom.h>
#include <WildThumperCom.h>
#include <GolfBallStand.h>

#define TEAM_NUMBER 3  // Replace this with your team number.

char manufacturer[] = "Rose-Hulman";
char model[] = "Final Golf Ball Delivery";  // Change to your app name.
//char model[] = "Arm Scripts";  // Change to your app name.

char versionStr[] = "1.0";

GolfBallStand stand;
int ballColor_1, ballColor_2, ballColor_3;

// Only Manufacturer, Model, and Version matter to Android
AndroidAccessory acc(manufacturer,
	model,
	"ME435 robot arm message relay station.",
	versionStr,
	"https://sites.google.com/site/me435spring2015/",
	"12345");

byte rxBuf[255];
char txBuf[64];
int batteryVoltageReplyLength = 0;
int wheelCurrentReplyLength = 0;
// Note, when sending commands <b>to</b> Android I don't add the '\n'.
// Turned out to be easier since the whole message arrives together.

// Just a random set of scripts that you might make for testing.
char rightButtonScript[] = "script3";
char leftButtonScript[] = "script2";
char selectButtonScript[] = "script1";

/***  Pin I/O   ***/
#define PIN_RIGHT_BUTTON 2
#define PIN_LEFT_BUTTON 3
#define PIN_SELECT_BUTTON 21

/*** Interrupt flags ***/
volatile int mainEventFlags = 0;
#define FLAG_INTERRUPT_0                   0x0001
#define FLAG_INTERRUPT_1                   0x0002
#define FLAG_INTERRUPT_2                   0x0004
#define FLAG_NEED_TO_SEND_BATTERY_VOLTAGE  0x0008
#define FLAG_NEED_TO_SEND_WHEEL_CURRENT    0x0010

LiquidCrystal lcd(14, 15, 16, 17, 18, 19, 20);
#define LINE_1 0
#define LINE_2 1

RobotAsciiCom robotAsciiCom;
WildThumperCom wildThumperCom(TEAM_NUMBER);

void setup() {
	Serial.begin(9600);  // Change if you are using a different baudrate.
	pinMode(PIN_LEFT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_RIGHT_BUTTON, INPUT_PULLUP);
	pinMode(PIN_SELECT_BUTTON, INPUT_PULLUP);
	attachInterrupt(0, int0_isr, FALLING);
	attachInterrupt(1, int1_isr, FALLING);
	attachInterrupt(2, int2_isr, FALLING);
	lcd.begin(16, 2);

	// Register callbacks for commands you might receive from Android.
	robotAsciiCom.registerWheelSpeedCallback(wheelSpeedMessageFromAndroid);
	robotAsciiCom.registerPositionCallback(positionMessageFromAndroid);
	robotAsciiCom.registerJointAngleCallback(jointAngleMessageFromAndroid);
	robotAsciiCom.registerGripperCallback(gripperMessageFromAndroid);
	robotAsciiCom.registerAttachSelectedServosCallback(attachSelectedServosCallback);
	robotAsciiCom.registerBatteryVoltageRequestCallback(batteryVoltageRequestFromAndroid);
	robotAsciiCom.registerWheelCurrentRequestCallback(wheelCurrentRequestFromAndroid);
	robotAsciiCom.registerCustomStringCallback(customStringCallbackFromAndroid);

	// Register callbacks for commands you might receive from the Wild Thumper.
	wildThumperCom.registerBatteryVoltageReplyCallback(batteryVoltageReplyFromThumper);
	wildThumperCom.registerWheelCurrentReplyCallback(wheelCurrentReplyFromThumper);

	lcd.clear();
	stand.setLedState(LED_RED, LOCATION_3, LED_FRONT);
	lcd.print("Relay Station");
	delay(1500);
	acc.powerOn();
	wildThumperCom.sendAttachSelectedServos(0x3F);
}

void wheelSpeedMessageFromAndroid(byte leftMode, byte rightMode, byte leftDutyCycle, byte rightDutyCycle) {
	wildThumperCom.sendWheelSpeed(leftMode, rightMode, leftDutyCycle, rightDutyCycle);
	lcd.clear();
	lcd.print("Wheel speed:");
	lcd.setCursor(0, LINE_2);
	lcd.print("L");
	lcd.print(leftMode);
	lcd.print(" R");
	lcd.print(rightMode);
	lcd.print(" L");
	lcd.print(leftDutyCycle);
	lcd.print(" R");
	lcd.print(rightDutyCycle);
}

void positionMessageFromAndroid(int joint1Angle, int joint2Angle, int joint3Angle, int joint4Angle, int joint5Angle) {
	wildThumperCom.sendPosition(joint1Angle, joint2Angle, joint3Angle, joint4Angle, joint5Angle);
	lcd.clear();
	lcd.print("Position:");
	lcd.setCursor(0, LINE_2);
	lcd.print(joint1Angle);
	lcd.print(" ");
	lcd.print(joint2Angle);
	lcd.print(" ");
	lcd.print(joint3Angle);
	lcd.print(" ");
	lcd.print(joint4Angle);
	lcd.print(" ");
	lcd.print(joint5Angle);
}

void jointAngleMessageFromAndroid(byte jointNumber, int jointAngle) {
	wildThumperCom.sendJointAngle(jointNumber, jointAngle);
	lcd.clear();
	lcd.print("Joint angle:");
	lcd.setCursor(0, LINE_2);
	lcd.print("J");
	lcd.print(jointNumber);
	lcd.print(" move to ");
	lcd.print(jointAngle);
}

void gripperMessageFromAndroid(int gripperDistance) {
	gripperDistance = constrain(gripperDistance, 10, 65);
	wildThumperCom.sendGripperDistance(gripperDistance);
	lcd.clear();
	lcd.print("Gripper:");
	lcd.setCursor(0, LINE_2);
	lcd.print("Gripper to ");
	lcd.print(gripperDistance);
}

void attachSelectedServosCallback(byte servosToEnable) {
	wildThumperCom.sendAttachSelectedServos(servosToEnable);
	lcd.clear();
	lcd.print("Attach:");
	lcd.setCursor(0, LINE_2);
	lcd.print("54321G = ");
	lcd.print(servosToEnable, BIN);
}

void batteryVoltageRequestFromAndroid(void) {
	wildThumperCom.sendBatteryVoltageRequest();
}

void wheelCurrentRequestFromAndroid(void) {
	wildThumperCom.sendWheelCurrentRequest();
}

void customStringCallbackFromAndroid(String customString) {
	lcd.clear();
	if (customString.equalsIgnoreCase("COLOR_DETECT")) {
		handle_ball_detection();
	}
	else if (customString.equalsIgnoreCase("CALIBRATE_BALLS")) {
		ball_calibration();
	}else		{
		lcd.print("Unknown CUSTOM");
	}
	lcd.setCursor(0, LINE_2);
	lcd.print(customString);
}

void batteryVoltageReplyFromThumper(int batteryMillivolts) {
	// Send to Android from within the main event loop.
	mainEventFlags |= FLAG_NEED_TO_SEND_BATTERY_VOLTAGE;
	batteryVoltageReplyLength = robotAsciiCom.prepareBatteryVoltageReply(
		batteryMillivolts, txBuf, sizeof(txBuf));
	// Display battery voltage on LCD.
	lcd.clear();
	lcd.print("Battery voltage:");
	lcd.setCursor(0, LINE_2);
	lcd.print(batteryMillivolts / 1000);
	lcd.print(".");
	if (batteryMillivolts % 1000  < 100) {
		lcd.print("0");
	}
	if (batteryMillivolts % 1000 < 10) {
		lcd.print("0");
	}
	lcd.print(batteryMillivolts % 1000);
}

void wheelCurrentReplyFromThumper(int leftWheelMotorsMilliamps, int rightWheelMotorsMilliamps) {
	// Send to Android from within the main event loop.
	mainEventFlags |= FLAG_NEED_TO_SEND_WHEEL_CURRENT;
	wheelCurrentReplyLength = robotAsciiCom.prepareWheelCurrentReply(
		leftWheelMotorsMilliamps, rightWheelMotorsMilliamps, txBuf, sizeof(txBuf));

	// Display wheel currents on LCD.
	lcd.clear();
	lcd.print("Wheel current:");
	lcd.setCursor(0, LINE_2);
	lcd.print(leftWheelMotorsMilliamps / 1000);
	lcd.print(".");
	if (leftWheelMotorsMilliamps % 1000  < 100) {
		lcd.print("0");
	}
	if (leftWheelMotorsMilliamps % 1000 < 10) {
		lcd.print("0");
	}
	lcd.print(leftWheelMotorsMilliamps % 1000);
	lcd.print("  ");
	lcd.print(rightWheelMotorsMilliamps / 1000);
	lcd.print(".");
	if (rightWheelMotorsMilliamps % 1000  < 100) {
		lcd.print("0");
	}
	if (rightWheelMotorsMilliamps % 1000 < 10) {
		lcd.print("0");
	}
	lcd.print(rightWheelMotorsMilliamps % 1000);
}

void loop() {
	// See if there is a new message from Android.
	if (acc.isConnected()) {

		int len = acc.read(rxBuf, sizeof(rxBuf), 1);
		if (len > 0) {
			robotAsciiCom.handleRxBytes(rxBuf, len);
		}
		// Testing sending some scripts to Android on button press instead of a real sensor.
		if (mainEventFlags & FLAG_INTERRUPT_0) {
			delay(20);
			mainEventFlags &= ~FLAG_INTERRUPT_0;
			if (!digitalRead(PIN_RIGHT_BUTTON)) {
				acc.write(rightButtonScript, sizeof(rightButtonScript));
			}
		}
		if (mainEventFlags & FLAG_INTERRUPT_1) {
			delay(20);
			mainEventFlags &= ~FLAG_INTERRUPT_1;
			if (!digitalRead(PIN_LEFT_BUTTON)) {
				acc.write(leftButtonScript, sizeof(leftButtonScript));
			}
		}
		if (mainEventFlags & FLAG_INTERRUPT_2) {
			delay(20);
			mainEventFlags &= ~FLAG_INTERRUPT_2;
			if (!digitalRead(PIN_SELECT_BUTTON)) {
				acc.write(selectButtonScript, sizeof(selectButtonScript));
			}
		}
		// Passing commands from the Wild Thumper on up to Android.
		if (mainEventFlags & FLAG_NEED_TO_SEND_BATTERY_VOLTAGE) {
			mainEventFlags &= ~FLAG_NEED_TO_SEND_BATTERY_VOLTAGE;
			acc.write(txBuf, batteryVoltageReplyLength);
		}
		if (mainEventFlags & FLAG_NEED_TO_SEND_WHEEL_CURRENT) {
			mainEventFlags &= ~FLAG_NEED_TO_SEND_WHEEL_CURRENT;
			acc.write(txBuf, wheelCurrentReplyLength);
		}
	}

	// See if there is a new message from the Wild Thumper.
	if (Serial.available() > 0) {
		wildThumperCom.handleRxByte(Serial.read());
	}
}


void int0_isr() {
	mainEventFlags |= FLAG_INTERRUPT_0;
}

void int1_isr() {
	mainEventFlags |= FLAG_INTERRUPT_1;
}

void int2_isr() {
	mainEventFlags |= FLAG_INTERRUPT_2;
}

void handle_ball_detection() {
	//delay(1000); //this may or may not come back.  Keep it around, for now.
	lcd.print("Known CUSTOM");
	ballColor_1 = stand.determineBallColor(LOCATION_1);
	ballColor_2 = stand.determineBallColor(LOCATION_2);
	ballColor_3 = stand.determineBallColor(LOCATION_3);
	stand.setLedState(LED_GREEN, LOCATION_3, LED_FRONT); //indicate that we're done
	
	char message1[2] = { '1', getLetter(ballColor_1) };
	acc.write(message1, 2);

	char message2[2] = { '2', getLetter(ballColor_2) };
	acc.write(message2, 2);

	char message3[2] = { '3', getLetter(ballColor_3) };
	acc.write(message3, 2);
}

void ball_calibration() {
	lcd.clear();
	lcd.setCursor(0, LINE_1);
	lcd.print("Ball calibration");
	lcd.setCursor(0, LINE_2);
	lcd.print("Red Yellow Green");
	while (digitalRead(PIN_GOLF_BALL_STAND_SWITCH));
	stand.calibrate(BALL_RED, BALL_YELLOW, BALL_GREEN);

	lcd.setCursor(0, LINE_2);
	lcd.print("Green Red Yellow");
	while (digitalRead(PIN_GOLF_BALL_STAND_SWITCH));
	stand.calibrate(BALL_GREEN, BALL_RED, BALL_YELLOW);

	lcd.setCursor(0, LINE_2);
	lcd.print("Yellow Green Red");
	while (digitalRead(PIN_GOLF_BALL_STAND_SWITCH));
	stand.calibrate(BALL_YELLOW, BALL_GREEN, BALL_RED);

	lcd.clear();
	lcd.setCursor(0, LINE_1);
	lcd.print("Ball calibration");
	lcd.setCursor(0, LINE_2);
	lcd.print("Black White Blue");
	while (digitalRead(PIN_GOLF_BALL_STAND_SWITCH));
	stand.calibrate(BALL_BLACK, BALL_WHITE, BALL_BLUE);

	lcd.setCursor(0, LINE_2);
	lcd.print("Blue Black White");
	while (digitalRead(PIN_GOLF_BALL_STAND_SWITCH));
	stand.calibrate(BALL_BLUE, BALL_BLACK, BALL_WHITE);

	lcd.setCursor(0, LINE_2);
	lcd.print("White Blue Black");
	while (digitalRead(PIN_GOLF_BALL_STAND_SWITCH));
	stand.calibrate(BALL_WHITE, BALL_BLUE, BALL_BLACK);
	lcd.clear();
	char message[2] = { '0', 'D' };
	acc.write(message, 2);
  lcd.setCursor(0,LINE_1);
  lcd.print("calibration complete");
}

char getLetter(int BALL_TYPE) {
	switch (BALL_TYPE) {
	case BALL_BLACK:
		return 'N';
	case BALL_BLUE:
		return 'B';
	case BALL_GREEN:
		return 'G';
	case BALL_RED:
		return 'R';
	case BALL_YELLOW:
		return 'Y';
	case BALL_WHITE:
		return 'W';
	default:
		return 'X';
	}
}
