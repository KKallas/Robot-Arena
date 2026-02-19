# Physical Bot Firmware

**Purpose:** Software stack for MechArena bots using Phone + ESP32 architecture.

## Hardware Stack

```
┌─────────────────────────────────────────────────────────────┐
│              Single Bot Node (1 of 30 per team)             │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────┐│
│  │         Phone (Mounted on Bot - Python App)             ││
│  │   Bot Brain • POV Camera • WiFi to Team Controller      ││
│  └──────────────────────────┬──────────────────────────────┘│
│                             │ UART (USB-OTG serial)         │
│                             ▼                               │
│  ┌─────────────────────────────────────────────────────────┐│
│  │         ESP32 Hardware Bridge (Arduino C++)             ││
│  │   I2C/SPI sensors • GPIO motors • IR LED                ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

**Key Concept:** Each bot has its own phone mounted on it. The phone runs the behavior script and records POV footage. The ESP32 is the hardware bridge — connected to the phone via UART (USB-OTG serial) — and interfaces with motors, sensors, and IR LED via I2C/SPI/GPIO.

## Robot Classes

| Class | Size Limit | Budget | Game Mode | Arena |
|-------|-----------|--------|-----------|-------|
| **Starter Class (20cm)** | 20cm diameter, 20cm height | €100-150 | Sumo (teams) | 3x3m fixed floor |
| **Maintenance Class (60cm)** | 60cm diameter, 60cm height | €250-450 | Challenges (vs clock) | Modular 1x1m modules |

See [BOT-SPECIFICATIONS.md](../BOT-SPECIFICATIONS.md) for complete specifications.

## Module Responsibilities

### Phone (Mounted on Each Bot) (`/phone-app/`)
**Role:** Bot brain, POV camera, WiFi link to team controller

**One phone per bot. Up to 30 phones per team.**

**Capabilities:**
- Executes local behavior logic (Python) — runs independently if WiFi is lost
- Records POV camera footage (60 camera angles per match in Sumo!)
- Receives commands from team controller via WiFi
- Reports telemetry back to team controller via WiFi
- Sends motor/LED commands to ESP32 via UART (USB-OTG serial)
- Logs all telemetry for Knowledge Commons

**Communicates via:**
- UART to ESP32 on this bot (motor commands, sensor telemetry)
- WiFi to team controller (swarm commands, telemetry reporting)

### ESP32 Hardware Bridge (`/esp32-firmware/`)
**Role:** UART bridge from phone to low-level hardware (I2C/SPI/GPIO)

**Written in:** Arduino C++ (Arduino IDE)

**Receives from phone (UART):**
- Movement commands (forward, backward, turn, stop, differential drive)
- IR LED control (on/off)
- Sensor requests

**Sends to phone (UART):**
- Sensor readings (IMU via I2C, encoders via GPIO interrupts)
- Battery voltage (ADC)
- Motor state, IR LED state
- Telemetry stream at 10Hz

**Hardware interfaces:**
- I2C: IMU (MPU6886 or similar), magnetometer, other sensors
- SPI: high-speed peripherals as needed
- GPIO: motor PWM outputs, wheel encoder interrupts, IR LED control
- ADC: battery voltage monitoring

## Communication Protocols

### WiFi Protocol (Team Controller ↔ Node Phones)

Standard WiFi (TCP/UDP). This is the hackable link in Sumo mode.

**Controller → Node:** JSON commands over TCP
```json
{"cmd": "move_forward", "speed": 80, "duration_ms": 2000}
{"cmd": "set_formation", "role": "flank_left", "target": [1.5, 2.0]}
```

**Node → Controller:** JSON telemetry over UDP
```json
{"node_id": 5, "battery": 92, "enc_l": 45, "enc_r": 42, "ir_led": true}
```

### UART Protocol (Phone ↔ ESP32)

**Configuration:** USB-OTG serial, 115200 baud, 8N1

**Packet Format:** STX + Cmd + Length + Payload + CRC8

```
┌─────┬─────┬────────┬─────────────────┬──────┐
│ STX │ Cmd │ Length │     Payload     │ CRC8 │
│ 0x02│ 1B  │   1B   │    0-16 B       │  1B  │
└─────┴─────┴────────┴─────────────────┴──────┘
```

**Commands (Phone → ESP32):**
- 0x01 MOVE_FORWARD — duration_ms (2B), speed (1B)
- 0x02 MOVE_BACKWARD — duration_ms (2B), speed (1B)
- 0x03 TURN_LEFT — duration_ms (2B), speed (1B)
- 0x04 TURN_RIGHT — duration_ms (2B), speed (1B)
- 0x05 STOP
- 0x06 DRIVE — left_speed (1B), right_speed (1B)
- 0x07 GET_SENSORS
- 0x08 SET_IR_LED — state (1B: 0=off, 1=on)
- 0x09 EMERGENCY_STOP
- 0x0A PING

**Telemetry (ESP32 → Phone, 10Hz):**
- Battery %, encoder L/R, accelerometer XYZ, gyro Z, flags (IR LED state)

## Software Layers

**Layer 0: ESP32 Firmware (this directory)**
- Arduino C++ compiled via Arduino IDE
- UART command parser, I2C/SPI sensor reading, GPIO motor PWM, IR LED control
- Telemetry streaming at 10Hz back to phone via UART

**Layer 1: Phone App (per bot)**
- Python (Flask server + Chrome browser for UI)
- Controls ESP32 via UART (USB-OTG serial)
- Receives commands from team controller via WiFi
- Runs local fallback behavior if WiFi is lost
- POV camera recording

**Layer 2: Team Controller Script**
- Python behavior script written by pilot (with LLM assistance)
- Runs on team main controller (laptop/phone)
- Communicates with up to 30 node phones via WiFi
- Receives overview camera feed (IR LED positions)

## Development Workflow

**ESP32:**
1. Write C++ code in Arduino IDE
2. Compile and upload to ESP32
3. Test UART communication with phone app

**Phone App:**
1. Write Python behavior script (Flask backend + web UI)
2. Test on emulator or single bot
3. Test UART connection to ESP32 via USB-OTG
4. Deploy to all phones on team's bots

## Deployment

**Rental Fleet:**
- All bots run identical ESP32 firmware
- Version tracked in Logistics Operations inventory
- Updates deployed between events (ESP32 firmware via USB, phone apps via WiFi)

**Pilot Customization:**
- Pilots write behavior scripts (Python) and upload as a GitHub repo
- Repo is pulled automatically onto the team controller at match start
- Same firmware, different strategies
- Share strategies via Knowledge Commons

## Data Collection

**Match Logs (Critical for Dataset):**
- Each phone records POV footage (60 camera angles per Sumo match!)
- Each phone logs all UART telemetry from its ESP32
- Auto-uploads to Knowledge Commons after match via WiFi
- Collision events extracted for ML training

**Why This Matters:**
The match logs are the raw data that proves the dataset captures real swarm physics. When the Virtual Arena Simulator is trained on these logs and achieves 85%+ accuracy, it validates the entire dataset for commercial licensing.

---

For complete technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For hardware specifications, see [BOT-SPECIFICATIONS.md](../BOT-SPECIFICATIONS.md).
