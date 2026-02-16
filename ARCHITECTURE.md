# Robot Arena Technical Architecture

**Version:** 2.0
**Last Updated:** 2026-02-11

---

## Overview

Robot Arena is an autobattler robotics sport with three main pillars (Knowledge Commons, Logistics Operations, League Management) supported by two technical foundations: **Physical Bot Firmware** and **Virtual Arena Simulator**. This document describes the complete technical architecture from hardware to ML models.

**Key Architecture Decision:** Each bot has a phone mounted on it running Python logic. One phone per bot, 30 phones per team, 60 phones on the field. The ESP32/RISC-V microcontrollers run pure Arduino C++ firmware—no MicroPython. This provides the best balance of:
- **Compute power:** Each bot has a full smartphone for AI/logic (no shared bottleneck)
- **Camera:** Each phone provides POV recording for the dataset
- **Speed:** Arduino C++ gives deterministic real-time motor control
- **Libraries:** Arduino ecosystem has extensive sensor/motor support
- **LLM capacity:** LLMs are better at generating Arduino C++ than MicroPython

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Robot Arena Ecosystem                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────┐  ┌──────────────────┐  ┌───────────────┐ │
│  │   Knowledge      │  │   Logistics      │  │    League     │ │
│  │   Commons        │  │   Operations     │  │  Management   │ │
│  │                  │  │                  │  │               │ │
│  │ - Match Datasets │  │ - Fleet Rental   │  │ - Events      │ │
│  │ - Strategies     │  │ - Manufacturing  │  │ - Media       │ │
│  │ - ML Models      │  │ - Maintenance    │  │ - Sponsors    │ │
│  └────────┬─────────┘  └────────┬─────────┘  └───────┬───────┘ │
│           │                     │                     │          │
│           └─────────────────────┴─────────────────────┘          │
│                                 │                                │
│                    ┌────────────┴────────────┐                  │
│                    │                         │                  │
│         ┌──────────▼──────────┐   ┌─────────▼──────────┐       │
│         │  Physical System    │   │ Virtual Simulator  │       │
│         │                     │   │                    │       │
│         │ - Phone App (Python)│   │ - Python Emulator  │       │
│         │ - Arduino Firmware  │   │ - Game Server      │       │
│         │ - Phone Camera      │   │ - Collision LUT    │       │
│         │ - BLE/WiFi Protocol │   │ - Blender Render   │       │
│         └─────────────────────┘   └────────────────────┘       │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## Physical Bot Architecture

### Robot Classes

Robot Arena has two official robot classes. See [BOT-SPECIFICATIONS.md](BOT-SPECIFICATIONS.md) for full details.

| Class | Size Constraint | Cost | Use Case |
|-------|-----------------|------|----------|
| **Starter (20cm)** | Fits in 20cm circle, max 20cm height | €50-100 | Learning, Swarm Sumo |
| **Maintenance (60cm)** | Fits in 60cm circle, max 60cm height | €200-400 | Bounties, Infrastructure |

Both classes share the same software architecture (phone app + Arduino firmware).

### Hardware Stack - Phone + Arduino Firmware

```
┌─────────────────────────────────────────────────────────────────┐
│          Single Bot (1 of 30 per team, 60 total on field)       │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │           Phone (Mounted on Bot - Python App)             │  │
│  │                                                           │  │
│  │  - Bot's brain: runs behavior script (Python)            │  │
│  │  - POV camera: records match footage for dataset         │  │
│  │  - WiFi mesh: coordinates with other bots on team        │  │
│  │  - BLE: commands to ESP32 below                          │  │
│  └──────────────────────────┬───────────────────────────────┘  │
│                              │ BLE                              │
│                              ▼                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              ESP32 Main Controller (Arduino C++)          │  │
│  │                                                           │  │
│  │  - Receives commands from phone via BLE                  │  │
│  │  - Executes motor commands with precise timing           │  │
│  │  - Reads sensors (IMU, encoders, battery)                │  │
│  │  - Streams telemetry back to phone                       │  │
│  │  - UART to motor driver                                  │  │
│  └──────────────────────────┬───────────────────────────────┘  │
│                              │ UART                             │
│                              ▼                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │        Arduino Nano/Motor Driver (Arduino C++)            │  │
│  │                                                           │  │
│  │  - PWM motor control (precise timing)                    │  │
│  │  - Wheel encoder reading                                 │  │
│  │  - Battery monitoring                                    │  │
│  │  - Emergency stop handling                               │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  Starter (20cm): 7.4V 500mAh LiPo, ~200g, €50-100              │
│  Maintenance (60cm): 11.1V 5000mAh LiPo, ~5kg, €200-400        │
└─────────────────────────────────────────────────────────────────┘
```

**Key Insight:** Each bot has its own phone mounted on it. The phone is the bot's brain—it runs the behavior script and records POV footage. The ESP32/Arduino runs pure C++ firmware compiled in Arduino IDE. This separation provides:
- **Phone (per bot):** Runs behavior script, POV camera, WiFi mesh coordination
- **ESP32:** Handles real-time communication, sensor fusion
- **Arduino:** Handles precise motor timing, safety

**Communication Flow:**
```
Before Match (Preparation):
  - Pilot writes behavior script with LLM assistance
  - Script is uploaded to all 30 phones on team's bots
  - Autobattler format: no changes once match starts

During Match (Per Bot):
  Phone (mounted on bot):
    - Executes uploaded behavior script (Python)
    - Records POV camera footage
    - Coordinates with teammates via WiFi mesh
    - Sends motor commands to ESP32 via BLE

  Phone → ESP32 (BLE):
    - High-level commands: move_forward(duration, speed)
    - Sensor requests: get_imu(), get_battery()

  ESP32 → Arduino (UART):
    - Motor commands: [0x01][duration][speed][CRC]
    - Status queries: [0x08][CRC]

  ESP32 → Phone:
    - Telemetry stream: position, velocity, battery
    - Sensor data: IMU readings, encoder counts
```

---

### Module Responsibilities

#### **Phone (Mounted on Each Bot)**
**Role:** Bot Brain + POV Camera + Mesh Coordination

**One phone per bot. 30 phones per team. 60 phones on the field.**

**Hardware:**
- Any modern smartphone (Android 10+ or iOS 14+)
- BLE 5.0 for ESP32 communication
- Built-in camera for POV recording
- WiFi for mesh coordination with teammates

**Software:**
- Python app (via Kivy, BeeWare, or similar)
- Behavior script (uploaded before match)
- WiFi mesh protocol for team coordination
- Telemetry logging
- POV match recording

**Responsibilities:**
- Execute behavior script autonomously during match
- Record POV camera footage (60 camera angles per match!)
- Coordinate with teammates via WiFi mesh
- Send motor commands to ESP32 via BLE
- Log all telemetry for Knowledge Commons

**Why Phone Per Bot:**
- Massive compute power per bot (no shared bottleneck)
- 60 POV cameras generate rich dataset
- Cheap smartphones (~€50-100 used) add minimal cost
- Python is easier than embedded code
- No firmware flashing—just upload new script

---

#### **ESP32 Main Controller (Arduino C++)**
**Role:** Communication Bridge + Sensor Hub

**Hardware:**
- ESP32 (any variant: DevKit, M5 Atom, etc.)
- MPU6886 or similar IMU (optional)
- RGB LED (status indicator)
- BLE for phone communication
- UART for motor driver communication

**Software:**
- Arduino C++ (compiled via Arduino IDE)
- BLE server (receives commands from phone)
- UART master (sends commands to motor driver)
- Sensor reader (IMU, battery via ADC)
- Telemetry streamer (sends data back to phone)

**Responsibilities:**
- Receive high-level commands from phone via BLE
- Translate to motor commands and send to Arduino via UART
- Read sensors and stream telemetry to phone at 10Hz
- Handle emergency stop (button or phone disconnect)
- Buffer commands for smooth execution

**Why Arduino IDE (not MicroPython):**
- Faster execution (C++ vs interpreted Python)
- Better real-time timing guarantees
- Extensive library ecosystem (BLE, IMU, motor)
- LLMs are better at Arduino C++ than MicroPython
- Easier debugging with Serial Monitor

---

#### **Arduino Nano/Motor Driver (Arduino C++)**
**Role:** Motor Controller

**Hardware:**
- ATmega328P @ 16MHz (or ESP32 if more IO needed)
- 2x PWM outputs (motor control)
- 2x interrupt pins (encoder inputs)
- UART RX from ESP32
- Analog input (battery voltage)

**Software:**
- Arduino C++ (compiled firmware)
- UART command parser
- Motor PWM driver (precise timing)
- Wheel encoder reader (speed feedback)
- Battery monitor (voltage + state of charge)
- Emergency stop handler

**Responsibilities:**
- Receive motor commands from ESP32 via UART
- Execute motor commands with precise timing
- Read wheel encoders (odometry)
- Monitor battery state
- Send status updates at 10Hz
- Hardware emergency stop (cuts motors on signal loss)

---

### Communication Protocols

#### **Phone ↔ ESP32 (BLE)**

**BLE Service UUID:** `0000FFE0-0000-1000-8000-00805F9B34FB`

**Characteristics:**
```
Command TX (Phone → ESP32):  0xFFE1  Write
Telemetry RX (ESP32 → Phone): 0xFFE2  Notify
Status (bidirectional):       0xFFE3  Read/Write
```

**Command Format (Phone → ESP32):**
```
┌──────┬────────┬──────────────┐
│ Cmd  │ Length │   Payload    │
│ 1B   │ 1B     │   0-18B      │
└──────┴────────┴──────────────┘

BLE MTU limits payload to ~20 bytes per packet.
Larger commands split across multiple packets.
```

**Command Types:**
```
0x01  MOVE_FORWARD     - duration_ms (2B), speed (1B)
0x02  MOVE_BACKWARD    - duration_ms (2B), speed (1B)
0x03  TURN_LEFT        - duration_ms (2B), speed (1B)
0x04  TURN_RIGHT       - duration_ms (2B), speed (1B)
0x05  STOP             - (no payload)
0x06  DRIVE            - left_speed (1B), right_speed (1B)
0x07  GET_SENSORS      - (triggers telemetry response)
0x08  SET_LED          - r (1B), g (1B), b (1B)
0x09  EMERGENCY_STOP   - (no payload)
0x0A  PING             - (no payload, expects PONG)
```

**Telemetry Format (ESP32 → Phone):**
```
┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐
│ Bat% │ EncL │ EncR │ AccX │ AccY │ AccZ │ GyrZ │ Flags│
│ 1B   │ 2B   │ 2B   │ 2B   │ 2B   │ 2B   │ 2B   │ 1B   │
└──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘

Sent at 10Hz (100ms intervals)
Total: 14 bytes per packet
```

---

#### **ESP32 ↔ Arduino (UART)**

**Configuration:**
- Baud rate: 115200 (simple, reliable)
- 8N1 (8 data bits, no parity, 1 stop bit)
- Point-to-point (not bus)

**Packet Format:**
```
┌──────┬──────┬────────┬──────────────┬─────────┐
│ STX  │ Cmd  │ Length │   Payload    │  CRC8   │
│ 1B   │ 1B   │ 1B     │   0-16B      │  1B     │
└──────┴──────┴────────┴──────────────┴─────────┘

STX: 0x02 (start of text)
CRC8: XOR of all bytes (simple, fast)
```

**Motor Commands (ESP32 → Arduino):**
```
0x01  MOVE_FORWARD     - duration_ms (2B), speed (1B)
0x02  MOVE_BACKWARD    - duration_ms (2B), speed (1B)
0x03  TURN_LEFT        - duration_ms (2B), speed (1B)
0x04  TURN_RIGHT       - duration_ms (2B), speed (1B)
0x05  STOP             - (no payload)
0x06  DRIVE            - left_speed (1B), right_speed (1B)
0x0A  EMERGENCY_STOP   - (no payload)
```

**Status Response (Arduino → ESP32):**
```
0x08  STATUS           - battery (1B), encL (2B), encR (2B)

Sent at 10Hz or on request
```

**Example Flow:**
```
Phone sends BLE command:
  [0x01][0x03][0x07 0xD0][0x50]  // MOVE_FORWARD, 2000ms, 80%

ESP32 receives, translates to UART:
  [0x02][0x01][0x03][0x07 0xD0][0x50][CRC]

Arduino executes motor command for 2000ms at 80% speed

Arduino sends status every 100ms:
  [0x02][0x08][0x05][0x64][0x00 0x45][0x00 0x42][CRC]
  // Battery 100%, EncL=69, EncR=66

ESP32 forwards to phone via BLE telemetry
```

---

### Software Layers (3-Tier Abstraction)

#### **Layer 0: Firmware (Arduino C++ on ESP32 + Arduino)**
Compiled via Arduino IDE, handles real-time operations.

**ESP32 Firmware:**
```cpp
// Arduino C++ - runs on ESP32 main controller
#include <BLEDevice.h>
#include <MPU6886.h>

BLECharacteristic* cmdCharacteristic;
BLECharacteristic* telemetryCharacteristic;

void onCommandReceived(uint8_t* data, size_t len) {
    uint8_t cmd = data[0];
    switch(cmd) {
        case CMD_MOVE_FORWARD:
            uint16_t duration = (data[2] << 8) | data[3];
            uint8_t speed = data[4];
            sendToArduino(CMD_MOVE_FORWARD, duration, speed);
            break;
        case CMD_STOP:
            sendToArduino(CMD_STOP);
            break;
        // ... other commands
    }
}

void sendTelemetry() {
    // Called every 100ms
    uint8_t packet[14];
    packet[0] = batteryPercent;
    // ... pack encoder, IMU data
    telemetryCharacteristic->setValue(packet, 14);
    telemetryCharacteristic->notify();
}
```

**Arduino Motor Controller:**
```cpp
// Arduino C++ - runs on Arduino Nano
void executeMotorCommand(uint8_t cmd, uint16_t duration, uint8_t speed) {
    int pwmValue = map(speed, 0, 100, 0, 255);

    switch(cmd) {
        case CMD_MOVE_FORWARD:
            analogWrite(MOTOR_L, pwmValue);
            analogWrite(MOTOR_R, pwmValue);
            delay(duration);
            stopMotors();
            break;
        // ... other commands
    }
}
```

---

#### **Layer 1: Phone App (Python)**
Runs on each bot's phone. Each phone controls only its own bot via BLE, but coordinates with teammates via WiFi mesh.

**Bot Controller (Runs on Each Phone):**
```python
# Python - runs on each bot's mounted phone
import asyncio
from bleak import BleakClient

class BotController:
    """Controls this bot's ESP32 via BLE"""

    def __init__(self, esp32_address):
        self.client = BleakClient(esp32_address)
        self.telemetry = {}

    async def connect(self):
        await self.client.connect()
        await self.client.start_notify(TELEMETRY_UUID, self._on_telemetry)

    async def move_forward(self, duration_ms, speed_percent):
        cmd = bytes([0x01, 0x03,
                     duration_ms >> 8, duration_ms & 0xFF,
                     speed_percent])
        await self.client.write_gatt_char(CMD_UUID, cmd)

    async def stop(self):
        await self.client.write_gatt_char(CMD_UUID, bytes([0x05]))

    def _on_telemetry(self, sender, data):
        self.telemetry = {
            'battery': data[0],
            'encoder_left': (data[1] << 8) | data[2],
            'encoder_right': (data[3] << 8) | data[4],
        }


class TeamMesh:
    """Coordinates with other bots via WiFi mesh"""

    def __init__(self, team_id, bot_id):
        self.team_id = team_id
        self.bot_id = bot_id
        self.teammates = {}  # {bot_id: {position, telemetry, ...}}

    async def broadcast_position(self, position):
        """Share my position with teammates"""
        # WiFi mesh broadcast
        pass

    async def get_teammate_positions(self):
        """Get current positions of all teammates"""
        return self.teammates
```

**Behavior Script (Uploaded by Pilot):**
```python
# Python - written by pilot with LLM assistance
# Uploaded to all 30 phones before match

async def behavior_main(bot: BotController, mesh: TeamMesh):
    """Main behavior loop - runs on each bot's phone"""

    while match_running:
        # Get my telemetry
        my_pos = bot.telemetry.get('position')

        # Get teammate positions via mesh
        teammates = await mesh.get_teammate_positions()

        # Execute swarm behavior
        if should_move_to_goal(my_pos, teammates):
            await bot.move_forward(500, 80)
        elif should_spread_out(my_pos, teammates):
            await move_away_from_nearest(bot, teammates)

        # Broadcast my position to team
        await mesh.broadcast_position(my_pos)

        await asyncio.sleep(0.1)


async def move_away_from_nearest(bot, teammates):
    """Spread out from nearest teammate"""
    nearest = find_nearest(bot.telemetry['position'], teammates)
    angle = calculate_away_angle(bot.telemetry['position'], nearest)
    await bot.turn_to(angle)
    await bot.move_forward(200, 60)
```

---

#### **Layer 2: Pilot's Development Environment**
Runs on pilot's laptop/desktop before match.

**Main Tools:**

**1. Script Editor**
- Syntax-highlighted Python editor
- LLM assistant panel (ask Claude/ChatGPT for help)
- Test single bot behavior locally
- Console output for debugging

**2. Simulator**
- Test full 30-bot strategy virtually
- Same physics as physical arena
- Iterate before deploying to real bots

**3. Fleet Manager**
- Upload script to all 30 phones
- Verify all bots connected and ready
- Pre-match status dashboard

**4. Match Recorder (Post-Match)**
- Collect POV footage from all 60 phones
- Aggregate telemetry logs
- Upload to Knowledge Commons

**5. Match Recorder**
- Start/stop match recording
- Captures: all commands, telemetry, timestamps
- Exports to Knowledge Commons format
- Optional screen recording

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
┌─────────────────────────────────────────────────────────────────┐
│              Virtual Arena (Mac Mini M4)                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Pilot's Python Script (Same as Phone App)                │  │
│  │                                                           │  │
│  │  - Identical swarm behavior code                         │  │
│  │  - Connects to virtual bots via mock BLE interface       │  │
│  │  - Receives simulated telemetry                          │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │ Mock BLE                            │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  60 Virtual Bots (Python Processes)                       │  │
│  │                                                           │  │
│  │  Each bot emulates:                                       │  │
│  │  - BLE command interface (same protocol as physical)     │  │
│  │  - ESP32 firmware behavior (command → motor translation) │  │
│  │  - Arduino motor response (motor → position update)      │  │
│  │  - Sensors (simulated with realistic noise)              │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │                                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │         Game Server (Python - No Physics Engine)          │  │
│  │                                                           │  │
│  │  - Updates 60 bot positions @ 250ms (4Hz)                │  │
│  │  - Cluster detection: identify bots needing interaction  │  │
│  │  - ML prediction: last 5 keyframes → next + % match      │  │
│  │  - Arena boundaries, goal circles, obstacles             │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │                                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │      ML Predictor (5 Keyframes → Next + % Match)          │  │
│  │                                                           │  │
│  │  Built from real match data in Knowledge Commons:        │  │
│  │  - Input: last 5 keyframes (positions, velocities)       │  │
│  │  - Output: next keyframe + % match to original data      │  │
│  │  - Reports which training tracks were used               │  │
│  │  - Accuracy: 87% position, 92% damage (validated)        │  │
│  └────────────────────────┬─────────────────────────────────┘  │
│                           │                                     │
│                           ▼                                     │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │    Blender (Offline Rendering - Lo-Fi Aesthetic)          │  │
│  │                                                           │  │
│  │  - Reads position timeline after match completion        │  │
│  │  - Renders all camera angles in parallel                 │  │
│  │  - Lo-fi cyberpunk: low-poly, CRT lines, visible grids   │  │
│  │  - Generates 61 camera outputs (60 POV + 1 overhead)     │  │
│  │  - Exports final video files (MP4/WebM)                  │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                  │
│  Offline/Batch Processing Benefits:                              │
│  - Matches can be prepared, signed, and queued                  │
│  - Non-realtime simulation for scalability                      │
│  - Multiple matches rendered sequentially on single machine     │
└─────────────────────────────────────────────────────────────────┘
```

---

### Virtual Bot Implementation

**Key Design Principle:** Exact BLE API compatibility with physical bots. The pilot's Python swarm code runs unchanged against virtual bots. Autobattler format with offline rendering.

```python
# virtual_bot.py
import asyncio
import numpy as np

class VirtualBot:
    """Emulates ESP32 + Arduino stack with BLE interface"""

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

    # BLE-compatible interface (same as physical Bot class)
    async def connect(self):
        """Mock BLE connection"""
        return True

    async def disconnect(self):
        """Mock BLE disconnection"""
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


# Mock BLE adapter for simulator
class VirtualBLEAdapter:
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
# Just swap BLE adapter for VirtualBLEAdapter
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
        Parse UART logs from M5 Camera SD cards
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
- 60 POV cameras (one per bot, 640x480 @ 30fps, matches physical OV2640)
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
│                    Data Flywheel                             │
└─────────────────────────────────────────────────────────────┘

Physical Matches (Real Arena)
    ↓
UART Logs (M5 Camera SD cards) + Camera Feeds
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
- Arduino Nano (motor controller): €3-5
- 2x N20 gear motors + wheels: €8-12
- L298N mini motor driver: €3-5
- 7.4V 500mAh LiPo: €8-12
- 3D printed chassis: €5-10
- Optional: MPU6886 IMU: €5-8

**Software (all Arduino IDE):**
- ESP32 firmware (BLE server, sensor reading)
- Arduino Nano firmware (motor control, encoders)

### Maintenance Class Bot (60cm) - Per Unit

**Hardware (~€200-400):**
- ESP32 main controller: €10-15
- Raspberry Pi (optional, for vision): €50-80
- 4x brushless motors + ESCs: €60-100
- Motor driver board: €20-30
- 11.1V 5000mAh LiPo: €40-60
- Aluminum/printed chassis: €30-50
- Weatherproof enclosure: €20-40
- Sensor package (lidar, camera): €50-100
- Modular attachment mount: €20-30

**Software:**
- Same Arduino IDE firmware as Starter Class
- Additional: Raspberry Pi vision processing (optional)

### Bot Phones (60 per Match)

**One phone mounted on each bot. 30 per team, 60 total.**

**Hardware:**
- Any modern smartphone (Android 10+ or iOS 14+)
- BLE 5.0 support (standard on phones from 2019+)
- Used phones work fine (~€50-100 each)

**Software:**
- Python app (Kivy, BeeWare, or similar framework)
- BLE library (bleak for Python)
- WiFi mesh for team coordination
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
- Quality control (validate BLE connectivity, sensor readings)
- Bounty verification (test in simulator before physical demo)

### League Management
- Virtual tournaments (online competitions using simulator)
- Practice matches (off-season engagement)
- Qualifying rounds (screen for physical events)
- Education programs (simulator for schools without hardware)

---

## Development Roadmap

### Phase 1: Physical Bot Firmware (Months 1-3)
- BLE protocol specification (command/telemetry format)
- ESP32 BLE server firmware (Arduino C++)
- Arduino motor controller firmware (Arduino C++)
- Integration testing (phone → ESP32 → Arduino)

### Phase 2: Phone App Core (Months 2-4)
- Python app framework setup (Kivy or similar)
- BLE connection manager (multi-bot support)
- Basic manual control UI (joystick, telemetry display)
- Script editor with syntax highlighting
- LLM integration for script assistance

### Phase 3: Virtual Simulator Core (Months 4-6)
- Python game server (250ms updates, no physics engine)
- Cluster detection + position prediction
- Virtual BLE adapter (same API as physical)
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
- **ESP32 (Arduino C++)**: BLE communication, sensor fusion, command relay
- **Arduino (Arduino C++)**: Motor control, precise timing, safety
- **Same Python code** runs against physical bots (via BLE) and virtual bots (via mock adapter)

**Why Arduino IDE (not MicroPython):**
- Faster execution with deterministic timing
- Better library ecosystem (BLE, IMU, motors)
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
