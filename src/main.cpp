#include <Arduino.h>

const int ENA = 25;
const int IN1 = 26;
const int IN2 = 27;

const int IN3 = 14;
const int IN4 = 12;
const int ENB = 13;

const int SENSOR_1 = 23;
const int SENSOR_2 = 22;
const int SENSOR_3 = 19;
const int SENSOR_4 = 18;
const int SENSOR_5 = 5;

const int BASE_SPEED = 180;
const int TURN_SPEED = 220;

void setMotors(int leftSpeed, int rightSpeed) {
  if (leftSpeed >= 0) {
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);
  } else {
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);
    leftSpeed = -leftSpeed;
  }

  if (rightSpeed >= 0) {
    digitalWrite(IN3, HIGH);
    digitalWrite(IN4, LOW);
  } else {
    digitalWrite(IN3, LOW);
    digitalWrite(IN4, HIGH);
    rightSpeed = -rightSpeed;
  }

  analogWrite(ENA, constrain(leftSpeed, 0, 255));
  analogWrite(ENB, constrain(rightSpeed, 0, 255));
}

void setup() {
  Serial.begin(115200);

  pinMode(ENA, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(IN3, OUTPUT);
  pinMode(IN4, OUTPUT);
  pinMode(ENB, OUTPUT);

  pinMode(SENSOR_1, INPUT_PULLUP);
  pinMode(SENSOR_2, INPUT_PULLUP);
  pinMode(SENSOR_3, INPUT_PULLUP);
  pinMode(SENSOR_4, INPUT_PULLUP);
  pinMode(SENSOR_5, INPUT_PULLUP);
}

void loop() {
  int s1 = digitalRead(SENSOR_1);
  int s2 = digitalRead(SENSOR_2);
  int s3 = digitalRead(SENSOR_3);
  int s4 = digitalRead(SENSOR_4);
  int s5 = digitalRead(SENSOR_5);

  if (s3 == LOW) {
    setMotors(BASE_SPEED, BASE_SPEED);
  } else if (s2 == LOW) {
    setMotors(100, TURN_SPEED);
  } else if (s1 == LOW) {
    setMotors(-100, TURN_SPEED);
  } else if (s4 == LOW) {
    setMotors(TURN_SPEED, 100);
  } else if (s5 == LOW) {
    setMotors(TURN_SPEED, -100);
  } else {
    setMotors(0, 0);
  }

  delay(10);
}
