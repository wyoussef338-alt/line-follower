# ESP32 Differential Drive Line Follower Robot

An autonomous 2-wheel differential drive line follower robot powered by the **ESP32-WROOM-32D** microcontroller, an **L298N Dual H-Bridge Motor Driver**, and a **5-Channel IR Reflectance Sensor Array**. Designed and built for the Hack Club 10-Hour Project Challenge.
![image1](https://github.com/wyoussef338-alt/line-follower/blob/main/Screenshot%202026-10-01%20160316.png?raw=true)
---

## Wokwi Virtual Simulation vs. Physical Hardware

To verify the firmware state machine logic before physical assembly, an interactive simulation was built on **Wokwi**. Due to simulator component limitations, hardware substitutions were made as follows:

* **5-Channel IR Sensor Array $\rightarrow$ 8-Position DIP Switch:** Since Wokwi lacks a dedicated 5-channel IR module, a DIP Switch was used to manually toggle digital input states (`LOW` = line detected) with internal pull-up resistors (`INPUT_PULLUP`).
* **L298N Driver & DC Gear Motors $\rightarrow$ Dual Servo Motors:** Servo motor rotation angles were mapped to PWM steering outputs on GPIO 25 & 26 to visually verify differential turning behavior (Straight, Left, Sharp Left, Right, Sharp Right, Stop).

---

## Hardware Pinouts

| Component Pin | ESP32 Pin | Function / Description |
| :--- | :---: | :--- |
| **L298N ENA** | **GPIO 25** | PWM Speed Control (Left Motor) |
| **L298N IN1** | **GPIO 26** | Direction Logic 1 (Left Motor) |
| **L298N IN2** | **GPIO 27** | Direction Logic 2 (Left Motor) |
| **L298N IN3** | **GPIO 14** | Direction Logic 1 (Right Motor) |
| **L298N IN4** | **GPIO 12** | Direction Logic 2 (Right Motor) |
| **L298N ENB** | **GPIO 13** | PWM Speed Control (Right Motor) |
| **IR Sensor 1** | **GPIO 23** | Digital Input (Far Left Sensor) |
| **IR Sensor 2** | **GPIO 22** | Digital Input (Mid Left Sensor) |
| **IR Sensor 3** | **GPIO 19** | Digital Input (Center Sensor) |
| **IR Sensor 4** | **GPIO 18** | Digital Input (Mid Right Sensor) |
| **IR Sensor 5** | **GPIO 5** | Digital Input (Far Right Sensor) |

---

##  Steering & State Machine Logic

* **Center Track (Sensor 3 = LOW):** Drives straight at `BASE_SPEED` (PWM 180).
* **Slight Off-Center (Sensor 2 or 4 = LOW):** Applies differential PWM speed control (`100` vs `220`) for smooth correction.
* **Sharp Turns / 90° Angles (Sensor 1 or 5 = LOW):** Reverses inner wheel direction (`-100` vs `220`) to perform zero-radius pivot turns.
* **Line Lost Fail-Safe (All Sensors = HIGH):** Immediately cuts power to both motors to prevent runaway.

---

### the design in onshape
I made a design that i will connect all parts on it
![image2](https://github.com/wyoussef338-alt/line-follower/blob/main/Screenshot%202026-10-01%20171447.png?raw=true)
![image3](https://github.com/wyoussef338-alt/line-follower/blob/main/Screenshot%202026-10-01%20171456.png?raw=true)
---
### Circuit Simulation
You can test the simulation here: [ESP32 Line Follower Simulation](https://wokwi.com/projects/476690097413869569)
![image4](https://github.com/wyoussef338-alt/line-follower/blob/main/Screenshot%202026-10-01%20175850.png?raw=true)
![image5](https://github.com/wyoussef338-alt/line-follower/blob/main/Screenshot%202026-10-01%20175836.png?raw=true)
![image6](https://github.com/wyoussef338-alt/line-follower/blob/main/Screenshot%202026-10-01%20175816.png?raw=true)

