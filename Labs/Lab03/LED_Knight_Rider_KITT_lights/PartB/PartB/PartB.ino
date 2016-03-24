#define PIN_LED_1 64
#define PIN_LED_2 65
#define PIN_LED_3 66
#define PIN_LED_4 67
#define PIN_LED_5 68
#define PIN_LED_6 69
#define delay_time 200

int led_ports[6] = { PIN_LED_1, PIN_LED_2, PIN_LED_3, PIN_LED_4, PIN_LED_5, PIN_LED_6 };
char curPos = 0;
char dir = -1;

// the setup function runs once when you press reset or power the board
void setup() {
	pinMode(PIN_LED_1, OUTPUT);
	pinMode(PIN_LED_2, OUTPUT);
	pinMode(PIN_LED_3, OUTPUT);
	pinMode(PIN_LED_4, OUTPUT);
	pinMode(PIN_LED_5, OUTPUT);
	pinMode(PIN_LED_6, OUTPUT);
}

// the loop function runs over and over again until power down or reset
void loop() {
	digitalWrite(led_ports[curPos], HIGH);
	delay(delay_time);
	digitalWrite(led_ports[curPos], LOW);

	if (curPos == 5 || curPos == 0) { dir = -dir; }
	curPos += dir;
}
