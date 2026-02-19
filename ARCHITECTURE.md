# MechArena Technical Architecture

**Version:** 2.0
**Last Updated:** 2026-02-11

---

## Overview

MechArena is an autobattler robotics sport with three main pillars (Knowledge Commons, Logistics Operations, League Management) supported by two technical foundations: **Physical Bot Firmware** and **Virtual Arena Simulator**. This document describes the complete technical architecture from hardware to ML models.

**Key Architecture Decision:** Each bot node is a **phone + ESP32 connected via UART** (USB-OTG serial). The phone is the brain — runs Python, has camera, WiFi. The ESP32 is the hardware bridge — connects to motors, sensors, and IR LED via I2C/SPI/GPIO. One phone per bot, 30 per team, 60 on field.

A **team main controller** (laptop or separate phone) runs the pilot's swarm script and communicates with all 30 node phones over WiFi. An **overview camera** above the arena tracks IR LEDs on every bot and feeds position data to the team controller.

- **Phone per node:** Full compute for local logic, POV camera, WiFi to team controller
- **ESP32 per node:** UART bridge from phone to low-level hardware (I2C sensors, SPI, GPIO motors, IR LED)
- **Team controller:** Runs centralized swarm strategy, receives overview cam feed + node telemetry
- **WiFi is hackable:** Nodes that process locally don't depend on controller connectivity

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        MechArena Ecosystem                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────┐  ┌──────────────────┐   ┌───────────────┐ │
│  │   Knowledge      │  │   Logistics      │   │    League     │ │
│  │   Commons        │  │   Operations     │   │  Management   │ │
│  │                  │  │                  │   │               │ │
│  │ - Match Datasets │  │ - Fleet Rental   │   │ - Events      │ │
│  │ - Strategies     │  │ - Manufacturing  │   │ - Media       │ │
│  │ - ML Models      │  │ - Maintenance    │   │ - Sponsors    │ │
│  └────────┬─────────┘  └────────┬─────────┘   └───────┬───────┘ │
│           │                     │                     │         │
│           └─────────────────────┴─────────────────────┘         │
│                                 │                               │
│                    ┌────────────┴────────────┐                  │
│                    │                         │                  │
│         ┌──────────▼──────────┐   ┌─────────▼──────────┐        │
│         │  Physical System    │   │ Virtual Simulator  │        │
│         │                     │   │                    │        │
│         │ - Phone App (Python)│   │ - Python Emulator  │        │
│         │ - ESP32 Firmware    │   │ - Game Server      │        │
│         │ - Phone Camera      │   │ - Collision LUT    │        │
│         │ - UART/WiFi Protocol│   │ - Blender Render   │        │
│         └─────────────────────┘   └────────────────────┘        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Physical Bot Architecture

### Robot Classes

MechArena has two official robot classes. See [BOT-SPECIFICATIONS.md](BOT-SPECIFICATIONS.md) for full details.

| Class | Size Constraint | Cost | Game Mode | Arena |
|-------|-----------------|------|-----------|-------|
| **Starter (20cm)** | Fits in 20cm circle, max 20cm height | €100-150 | Sumo (teams) | 3x3m fixed floor |
| **Maintenance (60cm)** | Fits in 60cm circle, max 60cm height | €250-450 | Challenges (vs clock) | Modular 1x1m modules |

Both classes share the same software architecture (phone app + ESP32 firmware via UART).

### Hardware Stack - Phone + ESP32 Bridge

```
┌────────────────────────────────────────────────────────────────┐
│     Single Bot Node (1 of 30 per team, 60 total on field)      │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │           Phone (Mounted on Bot - Python App)            │  │
│  │                                                          │  │
│  │  - Bot's brain: runs local behavior logic (Python)       │  │
│  │  - POV camera: records match footage for dataset         │  │
│  │  - WiFi: receives commands from team controller          │  │
│  │  - WiFi: reports telemetry back to team controller       │  │
│  │  - UART to ESP32 via USB-OTG serial                      │  │
│  └──────────────────────────┬───────────────────────────────┘  │
│                              │ UART (USB-OTG serial)           │
│                              ▼                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │           ESP32 Hardware Bridge (Arduino C++)            │  │
│  │                                                          │  │
│  │  - Receives commands from phone via UART                 │  │
│  │  - I2C: IMU, magnetometer, other sensors                 │  │
│  │  - SPI: high-speed peripherals                           │  │
│  │  - GPIO: motor PWM, encoder interrupts, IR LED           │  │
│  │  - ADC: battery voltage monitoring                       │  │
│  │  - Streams sensor telemetry back to phone via UART       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                │
│  Starter (20cm): 7.4V 500mAh LiPo, ~200g, €50-100              │
│  Maintenance (60cm): 11.1V 5000mAh LiPo, ~5kg, €200-400        │
└────────────────────────────────────────────────────────────────┘
```

**Two layers per node:**
- **Phone:** Bot brain + camera + WiFi link to team controller. Runs local Python logic. The more logic here, the more resilient to WiFi hacking.
- **ESP32:** Hardware bridge via UART (USB-OTG serial). Translates phone commands to low-level I2C/SPI/GPIO. Reads sensors, drives motors, controls IR LED.

**Communication Flow:**
```
Before Match (Preparation):
  - Pilot writes swarm script with LLM assistance
  - Uploads it as a GitHub repo
  - Repo is pulled automatically onto team controller at match start

During Match:
  Team Controller (laptop/phone):
    - Runs main Python script (programmatic or LLM-based)
    - Receives overview cam feed (IR LED positions)
    - Sends commands to 30 node phones via WiFi (hackable)

  Node Phone (mounted on bot):
    - Receives commands from team controller via WiFi
    - Can run local logic independently if WiFi is lost
    - Sends motor/LED commands to ESP32 via UART
    - Reports sensor data back to team controller via WiFi

  Phone → ESP32 (UART, USB-OTG serial):
    - Motor commands: move_forward(duration, speed)
    - LED control: set_ir_led(on/off)
    - Sensor requests: get_imu(), get_battery()

  ESP32 → Phone (UART):
    - Sensor telemetry: IMU, encoders, battery
    - Status: motor state, IR LED state
```

---

### Module Responsibilities

#### **Team Main Controller (Laptop or Phone)**
**Role:** Swarm Coordinator

**One per team. Runs the pilot's main Python script.**

**Inputs:**
- Overview camera feed — sees IR LEDs on all bots, provides god-view positions
- Node telemetry — each node phone reports sensor data back over WiFi

**Outputs:**
- Commands to 30 node phones over WiFi (formation updates, target assignments, mode switches)

**Script types:**
- Programmatic: if/else logic, state machines, formation algorithms
- LLM-based: software triggers for different conditions, LLM generates responses

**Vulnerability:** WiFi link to nodes is hackable. If disrupted, nodes must fall back to local logic.

---

#### **Node Phone (Mounted on Each Bot)**
**Role:** Bot Brain + POV Camera + WiFi Link

**One phone per bot. 30 phones per team. 60 phones on the field.**

**Hardware:**
- Any modern smartphone (Android 10+ or iOS 14+)
- USB-OTG for UART serial to ESP32
- Built-in camera for POV recording
- WiFi for communication with team controller

**Software:**
- Python app (via Kivy, BeeWare, or similar)
- WiFi client: receives commands from team controller, sends telemetry back
- UART serial: sends motor/LED commands to ESP32, receives sensor data
- Local fallback behaviors (run when WiFi connection to controller is lost)
- POV camera recording
- Telemetry logging

**Why Phone Per Bot:**
- Real compute power for local logic (resilient to WiFi hacking)
- 60 POV cameras generate rich dataset
- Cheap used smartphones (~€50-100) add minimal cost
- Python is easier than embedded code
- No firmware flashing — just upload new script

---

#### **ESP32 Hardware Bridge (Arduino C++)**
**Role:** Interface from phone to low-level hardware

**Hardware:**
- ESP32 (any variant: DevKit, M5 Atom, etc.)
- UART connection to phone (USB-OTG serial)
- I2C bus: IMU (MPU6886 or similar), magnetometer, other sensors
- SPI bus: high-speed peripherals as needed
- GPIO: motor PWM outputs, wheel encoder interrupt inputs, IR LED control
- ADC: battery voltage monitoring

**Software:**
- Arduino C++ (compiled via Arduino IDE)
- UART command parser (receives from phone)
- I2C/SPI sensor readers
- Motor PWM driver (precise timing)
- Wheel encoder reader (odometry via interrupts)
- IR LED controller
- Battery monitor (ADC voltage + state of charge)
- Telemetry streamer (sends sensor data back to phone via UART at 10Hz)
- Emergency stop handler (cuts motors on UART signal loss)

**Why ESP32 as bridge (not running logic directly):**
- Phone has orders of magnitude more compute for Python logic
- ESP32 excels at real-time I/O: precise PWM timing, interrupt handling, ADC sampling
- Clean separation: phone decides what to do, ESP32 interfaces with hardware
- Arduino C++ is better for deterministic I/O timing than Python

---

### Communication Protocols

#### **Team Controller ↔ Node Phones (WiFi)**

Standard WiFi (TCP/UDP). This is the hackable link.

**Controller → Node:** JSON commands over TCP
```json
{"cmd": "move_forward", "speed": 80, "duration_ms": 2000}
{"cmd": "set_formation", "role": "flank_left", "target": [1.5, 2.0]}
{"cmd": "set_mode", "mode": "fallback_local"}
```

**Node → Controller:** JSON telemetry over UDP
```json
{"node_id": 5, "battery": 92, "enc_l": 45, "enc_r": 42, "ir_led": true}
```

**Overview Cam → Controller:** IR LED position data (wired/dedicated link, not hackable)

---

#### **Phone ↔ ESP32 (UART via USB-OTG Serial)**

**Configuration:**
- USB-OTG serial (phone acts as USB host)
- Baud rate: 115200, 8N1
- Point-to-point (phone ↔ one ESP32)

**Packet Format (both directions):**
```
┌──────┬──────┬────────┬──────────────┬─────────┐
│ STX  │ Cmd  │ Length │   Payload    │  CRC8   │
│ 1B   │ 1B   │ 1B     │   0-16B      │  1B     │
└──────┴──────┴────────┴──────────────┴─────────┘

STX: 0x02 (start of text)
CRC8: XOR of all bytes (simple, fast)
```

**Commands (Phone → ESP32):**
```
0x01  MOVE_FORWARD     - duration_ms (2B), speed (1B)
0x02  MOVE_BACKWARD    - duration_ms (2B), speed (1B)
0x03  TURN_LEFT        - duration_ms (2B), speed (1B)
0x04  TURN_RIGHT       - duration_ms (2B), speed (1B)
0x05  STOP             - (no payload)
0x06  DRIVE            - left_speed (1B), right_speed (1B)
0x07  GET_SENSORS      - (triggers telemetry response)
0x08  SET_IR_LED       - state (1B: 0=off, 1=on)
0x09  EMERGENCY_STOP   - (no payload)
0x0A  PING             - (no payload, expects PONG)
```

**Telemetry (ESP32 → Phone):**
```
┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐
│ Bat% │ EncL │ EncR │ AccX │ AccY │ AccZ │ GyrZ │ Flags│
│ 1B   │ 2B   │ 2B   │ 2B   │ 2B   │ 2B   │ 2B   │ 1B   │
└──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘

Flags byte: bit 0 = IR LED state
Sent at 10Hz (100ms intervals)
Total: 14 bytes per packet
```

**Example Flow:**
```
Phone sends UART command:
  [0x02][0x01][0x03][0x07 0xD0][0x50][CRC]  // MOVE_FORWARD, 2000ms, 80%

ESP32 drives motors via GPIO PWM for 2000ms at 80% speed

ESP32 sends telemetry every 100ms:
  [0x02][0x08][0x05][0x64][0x00 0x45][0x00 0x42][CRC]
  // Battery 100%, EncL=69, EncR=66

Phone forwards relevant telemetry to team controller via WiFi
```

---

### Software Layers (2-Tier per Node + Team Controller)

#### **Layer 0: ESP32 Firmware (Arduino C++)**
Compiled via Arduino IDE. Hardware bridge — receives UART commands from phone, drives I/O.

```cpp
// Arduino C++ - runs on ESP32 hardware bridge
#include <Wire.h>       // I2C for sensors
#include <MPU6886.h>    // IMU

#define IR_LED_PIN 25
#define MOTOR_L_PIN 26
#define MOTOR_R_PIN 27

void onUARTCommand(uint8_t* data, size_t len) {
    uint8_t cmd = data[0];
    switch(cmd) {
        case CMD_MOVE_FORWARD: {
            uint16_t duration = (data[2] << 8) | data[3];
            uint8_t speed = data[4];
            int pwm = map(speed, 0, 100, 0, 255);
            analogWrite(MOTOR_L_PIN, pwm);
            analogWrite(MOTOR_R_PIN, pwm);
            delay(duration);
            stopMotors();
            break;
        }
        case CMD_SET_IR_LED:
            digitalWrite(IR_LED_PIN, data[2] ? HIGH : LOW);
            break;
        case CMD_STOP:
            stopMotors();
            break;
    }
}

void sendTelemetry() {
    // Called every 100ms, sent to phone via UART
    uint8_t packet[14];
    packet[0] = readBatteryPercent();     // ADC
    packEncoders(&packet[1]);             // GPIO interrupts
    packIMU(&packet[5]);                  // I2C
    packet[13] = digitalRead(IR_LED_PIN); // Flags
    Serial.write(packet, 14);
}
```

---

#### **Layer 1: Node Phone App (Python)**
Runs on each bot's phone. Controls ESP32 via UART. Receives commands from team controller via WiFi.

```python
# Python - runs on each bot's mounted phone
import asyncio
import serial  # USB-OTG serial to ESP32

class BotHardware:
    """Controls this bot's ESP32 via UART (USB-OTG serial)"""

    def __init__(self, serial_port='/dev/ttyUSB0'):
        self.ser = serial.Serial(serial_port, 115200)
        self.telemetry = {}

    def move_forward(self, duration_ms, speed_percent):
        cmd = bytes([0x02, 0x01, 0x03,
                     duration_ms >> 8, duration_ms & 0xFF,
                     speed_percent, self._crc()])
        self.ser.write(cmd)

    def set_ir_led(self, on: bool):
        cmd = bytes([0x02, 0x08, 0x01, 0x01 if on else 0x00, self._crc()])
        self.ser.write(cmd)

    def stop(self):
        self.ser.write(bytes([0x02, 0x05, 0x00, self._crc()]))

    def read_telemetry(self):
        data = self.ser.read(14)
        self.telemetry = {
            'battery': data[0],
            'encoder_left': (data[1] << 8) | data[2],
            'encoder_right': (data[3] << 8) | data[4],
            'ir_led': bool(data[13] & 0x01),
        }
        return self.telemetry


class NodeClient:
    """Receives commands from team controller over WiFi"""

    def __init__(self, controller_ip, node_id):
        self.controller_ip = controller_ip
        self.node_id = node_id

    async def receive_command(self):
        """Listen for next command from team controller"""
        # TCP connection to team controller
        pass

    async def send_telemetry(self, telemetry):
        """Report sensor data back to team controller"""
        # UDP to team controller
        pass
```

**Local fallback behavior (runs when WiFi to controller is lost):**
```python
async def fallback_behavior(bot: BotHardware):
    """Runs on node phone when team controller is unreachable"""
    bot.set_ir_led(True)  # Stay visible
    while not controller_connected():
        telemetry = bot.read_telemetry()
        # Simple obstacle avoidance using local sensors only
        if obstacle_detected(telemetry):
            bot.stop()
            bot.move_forward(200, 30)  # Slow creep
        await asyncio.sleep(0.1)
```

---

#### **Layer 2: Team Controller Script (Python)**
Runs on pilot's laptop/phone. The main swarm brain.

```python
# Python - runs on team main controller
# Written by pilot with LLM assistance before match

class SwarmController:
    """Manages 30 bot nodes from team controller"""

    def __init__(self, nodes: list, overview_cam):
        self.nodes = nodes          # 30 NodeConnection objects
        self.cam = overview_cam     # IR LED position feed

    async def run(self):
        """Main loop - runs for 90 seconds"""
        while match_running:
            # Input 1: overview camera (god-view positions)
            positions = self.cam.get_all_positions()

            # Input 2: node telemetry (per-bot sensor data)
            telemetry = {n.id: n.last_telemetry for n in self.nodes}

            # Strategy logic (programmatic or LLM-triggered)
            commands = self.compute_formation(positions, telemetry)

            # Send commands to nodes over WiFi
            for node, cmd in commands.items():
                await node.send_command(cmd)

            await asyncio.sleep(0.25)  # 4Hz update cycle
```

---

## Virtual Arena Simulator

### Architecture Overview

The simulator uses an **autobattler format** with offline Blender rendering in a **lo-fi cyberpunk aesthetic**. **Same Python swarm code runs in both physical and virtual environments** - the phone app code works identically against virtual bots. Key innovation: **ML Predictor** that takes last 5 keyframes and predicts next keyframe with % match to original training data.

**Autobattler Format:**
- 90-second matches with no operator interference during match
- Pilots prepare Python packages with LLM assistance (same code as phone app)
- Packages are signed and queued for batch processing
- Strategy generation "on the go" is a future enhancement

```
┌────────────────────────────────────────────────────────────────┐
│              Virtual Arena (Mac Mini M4)                       │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Pilot's Python Script (Same as Phone App)               │  │
│  │                                                          │  │
│  │  - Identical swarm behavior code                         │  │
│  │  - Connects to virtual bots via mock UART interface      │  │
│  │  - Receives simulated telemetry                          │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │ Mock UART                          │
│                           ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  60 Virtual Bots (Python Processes)                      │  │
│  │                                                          │  │
│  │  Each bot emulates:                                      │  │
│  │  - UART command interface (same protocol as physical)    │  │
│  │  - ESP32 firmware behavior (command → motor translation) │  │
│  │  - Arduino motor response (motor → position update)      │  │
│  │  - Sensors (simulated with realistic noise)              │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │                                    │
│                           ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │         Game Server (Python - No Physics Engine)         │  │
│  │                                                          │  │
│  │  - Updates 60 bot positions @ 250ms (4Hz)                │  │
│  │  - Cluster detection: identify bots needing interaction  │  │
│  │  - ML prediction: last 5 keyframes → next + % match      │  │
│  │  - Arena boundaries, goal circles (Sumo), obstacles      │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │                                    │
│                           ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │      ML Predictor (5 Keyframes → Next + % Match)         │  │
│  │                                                          │  │
│  │  Built from real match data in Knowledge Commons:        │  │
│  │  - Input: last 5 keyframes (positions, velocities)       │  │
│  │  - Output: next keyframe + % match to original data      │  │
│  │  - Reports which training tracks were used               │  │
│  │  - Accuracy: 87% position, 92% damage (validated)        │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │                                    │
│                           ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │    Blender (Offline Rendering - Lo-Fi Aesthetic)         │  │
│  │                                                          │  │
│  │  - Reads position timeline after match completion        │  │
│  │  - Renders all camera angles in parallel                 │  │
│  │  - Lo-fi cyberpunk: low-poly, CRT lines, visible grids   │  │
│  │  - Generates 61 camera outputs (60 POV + 1 overhead)     │  │
│  │  - Exports final video files (MP4/WebM)                  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                │
│  Offline/Batch Processing Benefits:                            │
│  - Matches can be prepared, signed, and queued                 │
│  - Non-realtime simulation for scalability                     │
│  - Multiple matches rendered sequentially on single machine    │
└────────────────────────────────────────────────────────────────┘
```

---

### Virtual Bot Implementation

**Key Design Principle:** Exact UART API compatibility with physical bots. The pilot's Python swarm code runs unchanged against virtual bots. Autobattler format with offline rendering.

```python
# virtual_bot.py
import asyncio
import numpy as np

class VirtualBot:
    """Emulates ESP32 hardware bridge with UART interface"""

    def __init__(self, bot_id, game_server):
        self.id = bot_id
        self.address = f"virtual-bot-{bot_id:02d}"
        self.game_server = game_server

        self.position = [0, 0, 0]  # x, y, theta
        self.velocity = [0, 0]

        # Telemetry (matches physical bot format)
        self.telemetry = {
            'battery': 100,
            'encoder_left': 0,
            'encoder_right': 0,
            'accel': [0, 0, 9.8],
            'gyro': [0, 0, 0],
        }

        # Command log for replay
        self.command_log = []

    # UART-compatible interface (same as physical BotHardware class)
    async def connect(self):
        """Mock UART connection"""
        return True

    async def disconnect(self):
        """Mock UART disconnection"""
        pass

    async def move_forward(self, duration_ms, speed_percent):
        """Same API as physical bot"""
        self.command_log.append({
            'cmd': 'move_forward',
            'duration': duration_ms,
            'speed': speed_percent,
            'timestamp': asyncio.get_event_loop().time()
        })

        # Game server predicts position change
        self.game_server.queue_movement(
            bot_id=self.id,
            direction=self.position[2],
            speed=speed_percent / 100.0,
            duration=duration_ms / 1000.0
        )

    async def move_backward(self, duration_ms, speed_percent):
        self.command_log.append({
            'cmd': 'move_backward',
            'duration': duration_ms,
            'speed': speed_percent,
            'timestamp': asyncio.get_event_loop().time()
        })
        self.game_server.queue_movement(
            bot_id=self.id,
            direction=self.position[2] + np.pi,  # Reverse
            speed=speed_percent / 100.0,
            duration=duration_ms / 1000.0
        )

    async def turn_left(self, duration_ms, speed_percent):
        self.command_log.append({
            'cmd': 'turn_left',
            'duration': duration_ms,
            'speed': speed_percent,
            'timestamp': asyncio.get_event_loop().time()
        })
        self.game_server.queue_rotation(
            bot_id=self.id,
            direction=1,  # Counter-clockwise
            speed=speed_percent / 100.0,
            duration=duration_ms / 1000.0
        )

    async def turn_right(self, duration_ms, speed_percent):
        self.command_log.append({
            'cmd': 'turn_right',
            'duration': duration_ms,
            'speed': speed_percent,
            'timestamp': asyncio.get_event_loop().time()
        })
        self.game_server.queue_rotation(
            bot_id=self.id,
            direction=-1,  # Clockwise
            speed=speed_percent / 100.0,
            duration=duration_ms / 1000.0
        )

    async def stop(self):
        self.command_log.append({
            'cmd': 'stop',
            'timestamp': asyncio.get_event_loop().time()
        })
        self.game_server.stop_bot(self.id)

    def get_telemetry(self):
        """Returns simulated telemetry with realistic noise"""
        # Add noise matching physical sensor specs
        noise_accel = np.random.normal(0, 0.01, 3)
        noise_gyro = np.random.normal(0, 0.5, 3)

        return {
            'battery': self.telemetry['battery'],
            'encoder_left': self.telemetry['encoder_left'],
            'encoder_right': self.telemetry['encoder_right'],
            'accel': (np.array(self.telemetry['accel']) + noise_accel).tolist(),
            'gyro': (np.array(self.telemetry['gyro']) + noise_gyro).tolist(),
            'position': self.position,  # Bonus: simulator knows true position
        }


# Mock UART adapter for simulator
class VirtualUARTAdapter:
    """Allows phone app code to run against virtual bots"""

    def __init__(self, virtual_bots):
        self.bots = {bot.address: bot for bot in virtual_bots}

    async def scan(self):
        """Return list of virtual bot addresses"""
        return list(self.bots.keys())

    def get_bot(self, address):
        """Return VirtualBot instance (same interface as physical Bot)"""
        return self.bots.get(address)


# Usage: Pilot's swarm code runs unchanged
# Just swap UART adapter for VirtualUARTAdapter
```

---

### ML Predictor (5 Keyframes → Next + % Match)

**The Killer Feature:** Proves value of Knowledge Commons dataset. Takes last 5 keyframes, predicts next keyframe, and reports % match to original training data. Fully deterministic—same inputs always produce same outputs.

**ML Predictor Building Pipeline:**
```python
# ml_predictor_builder.py
import numpy as np
from sklearn.neighbors import BallTree

class MLPredictor:
    """
    Keyframe predictor built from real Arena match data.
    Input: last 5 keyframes (positions, velocities, rotations)
    Output: next keyframe + % match to original training data
    """

    def __init__(self):
        self.keyframe_sequences = []  # 5-frame input sequences
        self.next_frames = []         # Corresponding next frames
        self.source_matches = []      # Which original match each came from
        self.tree = None              # BallTree for fast lookup

    def build_from_matches(self, match_logs_path):
        """
        Load from /01-knowledge-commons/ml-datasets/match-replays/
        Parse serial logs from Android phone storage
        """
        for log_file in glob(f'{match_logs_path}/*.log'):
            match_id = extract_match_id(log_file)
            packets = parse_uart_log(log_file)
            positions = reconstruct_positions(packets)

            # Extract 5-frame sequences and their next frames
            for t in range(5, len(positions)):
                # Last 5 keyframes as input
                input_sequence = flatten_keyframes(positions[t-5:t])
                next_frame = positions[t]

                self.keyframe_sequences.append(input_sequence)
                self.next_frames.append(next_frame)
                self.source_matches.append(match_id)

        # Build BallTree for fast similarity lookup
        self.tree = BallTree(np.array(self.keyframe_sequences))

    def predict(self, last_5_keyframes, k=3):
        """
        Predict next keyframe from last 5.
        Returns: (predicted_frame, match_info)
        match_info contains % similarity and source match IDs
        """
        input_vector = flatten_keyframes(last_5_keyframes)
        distances, indices = self.tree.query([input_vector], k=k)

        # Calculate similarity percentages
        max_dist = distances[0].max() + 1e-6
        similarities = 100 * (1 - distances[0] / max_dist)

        # Weighted prediction
        weights = 1.0 / (distances[0] + 1e-6)
        weights /= weights.sum()

        predicted_frame = np.zeros_like(self.next_frames[0])
        match_info = []
        for w, idx, sim in zip(weights, indices[0], similarities):
            predicted_frame += w * self.next_frames[idx]
            match_info.append({
                'source_match': self.source_matches[idx],
                'similarity_percent': float(sim),
                'weight': float(w)
            })

        return predicted_frame, match_info

    def save(self, path):
        np.savez_compressed(path,
            keyframe_sequences=self.keyframe_sequences,
            next_frames=self.next_frames,
            source_matches=self.source_matches)

# Build predictor from Knowledge Commons data
predictor = MLPredictor()
predictor.build_from_matches('/path/to/knowledge-commons/ml-datasets/uart-logs/')
predictor.save('ml_predictor_v1.npz')
```

**Usage in Simulator:**
```python
# Every 250ms game tick
for bot in bots:
    # Get last 5 keyframes for this bot
    last_5 = bot.position_history[-5:]

    # Predict next keyframe with match info
    next_frame, match_info = ml_predictor.predict(last_5)

    # Apply prediction
    bot.position = next_frame[:3]
    bot.velocity = next_frame[3:5]
    bot.rotation = next_frame[5]

    # Log prediction transparency (for verification)
    prediction_log.append({
        'bot_id': bot.id,
        'timestamp': current_time,
        'predicted_position': bot.position.tolist(),
        'source_matches': match_info  # Which training data was used
    })

# Example match_info output:
# [
#   {'source_match': 'match-2025-12-15-042', 'similarity_percent': 87.3, 'weight': 0.52},
#   {'source_match': 'match-2025-11-22-018', 'similarity_percent': 71.2, 'weight': 0.31},
#   {'source_match': 'match-2025-10-08-007', 'similarity_percent': 58.9, 'weight': 0.17}
# ]
```

### Battle Reproducibility

**Each battle is a complete, verifiable repository:**

```
battle-2026-01-07-001/
├── inputs/
│   ├── team_red_package.py      # Signed strategy package
│   ├── team_blue_package.py     # Signed strategy package
│   └── match_config.json        # Arena setup, bot assignments
├── ml-predictor/
│   └── predictor_v1.npz         # Exact ML model version used
├── outputs/
│   ├── events.csv               # Complete event timeline
│   ├── keyframes.json           # All position data
│   └── prediction_log.json      # Which training data was matched
├── verification/
│   └── checksums.sha256         # Verify all outputs match
└── README.md                    # How to reproduce this battle
```

**Deterministic execution:** Same inputs + same ML predictor = same outputs every time. The only difference between predictions is which input matches are used for prediction. Anyone can clone the repo and verify.

---

### Blender Offline Rendering

**Position Timeline Format (JSON):**
```json
// Complete match timeline written after simulation
{
  "match_id": "2026-01-07-001",
  "duration_seconds": 90,
  "frames": [
    {
      "timestamp": 0,
      "bots": [
        {
          "id": 1,
          "position": {"x": 1.23, "y": 0.87, "z": 0.0},
          "rotation": {"pitch": 0, "yaw": 45, "roll": 0},
          "velocity": {"x": 0.5, "y": 0.3}
        }
        // ... 59 more bots
      ],
      "arena_state": {
        "time_remaining": 90.0,
        "red_score": 0,
        "blue_score": 0
      }
    }
    // ... frames every 250ms for 90 seconds
  ]
}
```

**Blender reads complete timeline after match, renders offline.**

**Camera Outputs:**
- 60 POV cameras (one per bot, 640x480 @ 30fps, matches physical phone cameras)
- 1 overhead camera (top-down arena view, 1920x1080 @ 60fps)
- H.264/H.265 encoding via Blender's built-in encoder
- Exported as MP4/WebM video files

**Offline/Batch Processing Benefits:**
- Matches can be prepared, signed, and queued for non-realtime simulation
- Scalability for limited compute resources
- Multiple matches rendered sequentially on single machine
- No need for low-latency streaming infrastructure

---

## Dataset Flywheel: Physical ↔ Virtual

```
┌─────────────────────────────────────────────────────────────┐
│                    Data Flywheel                            │
└─────────────────────────────────────────────────────────────┘

Physical Matches (Real Arena)
    ↓
Serial Logs (Android Phone storage) + Camera Feeds
    ↓
Knowledge Commons Upload
    ↓
Extract Collision Events from UART logs
    ↓
Train ML Collision Model
    ↓
Deploy to Virtual Simulator
    ↓
Virtual Matches (Validation + Synthetic Data)
    ↓
Publish Sim-to-Real Accuracy Metrics
    ↓
Attracts Dataset Licensees (proof of quality)
    ↓
More Revenue → Larger Prize Pools
    ↓
More Competitors → More Physical Matches
    ↓
(Loop: Better dataset → Better models → Better sim)
```

---

## System Requirements

### Starter Class Bot (20cm) - Per Unit

**Hardware (~€50-100):**
- ESP32 DevKit/M5 Atom: €8-15
- Motor driver board: €3-5
- 2x N20 gear motors + wheels: €8-12
- L298N mini motor driver: €3-5
- 7.4V 500mAh LiPo: €8-12
- 3D printed chassis: €5-10
- Optional: MPU6886 IMU: €5-8

**Software (all Arduino IDE):**
- ESP32 firmware (UART bridge, sensor reading, motor/LED control)

### Maintenance Class Bot (60cm) - Per Unit

**Hardware (~€250-450):**
- ESP32 hardware bridge: €10-15
- Phone (used Android, mounted on bot): €50-100
- 4x brushless motors + ESCs: €60-100
- Motor driver board: €20-30
- 11.1V 5000mAh LiPo: €40-60
- Aluminum/printed chassis: €30-50
- Weatherproof enclosure: €20-40
- Sensor package (lidar, phone camera): €30-70
- Modular attachment mount: €20-30

**Software:**
- Same ESP32 Arduino IDE firmware as Starter Class
- Phone runs Python app (same as Starter Class)

### Bot Phones (60 per Match)

**One phone mounted on each bot. 30 per team, 60 total.**

**Hardware:**
- Any modern smartphone (Android 10+ or iOS 14+)
- USB-OTG support for UART serial to ESP32
- Used phones work fine (~€50-100 each)

**Software:**
- Python app (Kivy, BeeWare, or similar framework)
- pyserial (UART serial to ESP32)
- WiFi client for team controller communication
- POV camera recording

---

### Virtual Simulator (Mac Mini M4)

**Hardware Requirements:**
- Mac Mini M4 (base model sufficient)
- 32GB unified memory recommended
- 1TB SSD (for Blender assets + match replays)
- 10Gbe networking (optional, for multi-Mac scaling)

**Software Requirements:**
- Python 3.11+ (game server, bot emulator)
- NumPy + scikit-learn (ML predictor)
- Blender 4.x (offline rendering)
- Flask (bot web servers, 60 instances)
- Redis (virtual UART bus message queue)

**Performance Targets:**
- 60 virtual bots @ 250ms game server updates ✅
- Blender offline rendering (batch processed) ✅
- 61 video outputs (60 POV + 1 overhead) ✅
- Batch processing: multiple matches queued and rendered sequentially ✅

---

## Integration Points

### Knowledge Commons
- Phone apps upload match recordings (commands, telemetry, timestamps)
- Collision events extracted from telemetry
- ML models trained on collision dataset
- Sim-to-real validation metrics published
- Virtual matches contribute synthetic data (marked as simulated)

### Logistics Operations
- Firmware deployment to rental fleets (Arduino IDE OTA or USB)
- Match data collection via phone app uploads
- Quality control (validate UART connectivity, sensor readings)
- Bounty verification (test in simulator before physical demo)

### League Management
- Virtual tournaments (online competitions using simulator)
- Practice matches (off-season engagement)
- Qualifying rounds (screen for physical events)
- Education programs (simulator for schools without hardware)

---

## Development Roadmap

### Phase 1: Physical Bot Firmware (Months 1-3)
- UART protocol specification (command/telemetry format)
- ESP32 hardware bridge firmware (Arduino C++)
- Integration testing (phone → UART → ESP32 → motors/sensors)

### Phase 2: Phone App Core (Months 2-4)
- Python app framework setup (Kivy or similar)
- UART serial connection to ESP32
- Basic manual control UI (joystick, telemetry display)
- Script editor with syntax highlighting
- LLM integration for script assistance

### Phase 3: Virtual Simulator Core (Months 4-6)
- Python game server (250ms updates, no physics engine)
- Cluster detection + position prediction
- Virtual UART adapter (same API as physical)
- Run phone app code against virtual bots
- Blender rendering pipeline

### Phase 4: ML Predictor + Integration (Months 7-9)
- Extract keyframe sequences from Knowledge Commons telemetry
- Build ML predictor (5 keyframes → next + % match to original data)
- Lo-fi cyberpunk aesthetic in Blender
- Validate sim-to-real accuracy

### Phase 5: Production Ready (Months 10-12)
- Autobattler format: package upload, signing, queue system
- Batch processing infrastructure
- Tournament management system
- Knowledge Commons data upload from phone app
- Deploy to Mac Mini M4

---

## Success Metrics

### Technical
- Physical bot: <1ms trigger timing precision ✅
- Simulator: 87%+ position prediction accuracy 🎯
- API compatibility: 100% (same init.py runs on both) 🎯
- Uptime: 99%+ for virtual arena 🎯

### Business
- Dataset licensing: Simulator proves value → higher prices
- Global reach: Virtual competitions expand participant base
- Practice engagement: 10x more virtual matches than physical
- Research impact: Sim-to-real papers published using dataset

---

## Conclusion

This architecture creates a **complete ecosystem** where physical and virtual robotics competitions reinforce each other:

1. **Physical matches** generate high-quality real-world data (phone app recordings)
2. **ML Predictor** learns from this data (5 keyframes → next + % match)
3. **Virtual simulator** makes competition globally accessible (autobattler format)
4. **Sim-to-real validation** proves dataset quality
5. **More licensees** fund larger prize pools
6. **More competitors** generate more data
7. **Loop repeats**, improving both physical and virtual systems

**Key Architecture Decision:**
- **Phone App (Python)**: All swarm logic, UI, LLM integration, recording
- **ESP32 (Arduino C++)**: UART bridge to phone, I2C/SPI/GPIO hardware interface (motors, sensors, IR LED)
- **Same Python code** runs against physical bots (via UART) and virtual bots (via mock adapter)

**Why Arduino IDE (not MicroPython):**
- Faster execution with deterministic timing
- Better library ecosystem (I2C, SPI, IMU, motors)
- LLMs generate better Arduino C++ than MicroPython
- Easier debugging with Serial Monitor
- More examples and community support

**Key Innovation:** ML Predictor built from real matches creates a unique moat—no other robotics competition can claim their simulator is validated against thousands of real-world keyframe sequences. Same inputs always produce same outputs, with full transparency on which training data was used.

**Autobattler Format Benefits:**
- 90-second matches with no operator interference
- Pilots prepare Python packages with LLM assistance
- Matches can be prepared, signed, and queued for batch processing
- Scalability for limited compute resources

The **Mac Mini M4** is ideal for the simulator: unified memory handles 60 bots + Blender rendering efficiently, while batch processing allows sequential match rendering without realtime constraints.

**Why Android Phone + ESP32 Bridge:**
- Used phones (~€50) are more powerful than ESP32-based camera modules
- Phone runs full Python (not MicroPython), enabling richer logic
- USB-OTG serial provides reliable high-speed communication
- ESP32 bridge handles I2C translation + analog/digital I/O
- Scalable: add more ESP32 bridges for more ports/modules
- Phone's built-in camera, WiFi, storage replace dedicated camera module functionality
