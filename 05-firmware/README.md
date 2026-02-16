# Physical Bot Firmware

**Purpose:** Software stack for Robot Arena bots using Phone + ESP32 + Arduino architecture.

## Hardware Stack

```
┌─────────────────────────────────────────────────────────────┐
│              Single Bot (1 of 30 per team)                   │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────┐│
│  │         Phone (Mounted on Bot - Python App)             ││
│  │   Bot Brain • POV Camera • WiFi Mesh • BLE to ESP32    ││
│  └──────────────────────────┬──────────────────────────────┘│
│                              │ BLE                           │
│                              ▼                               │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              ESP32 (BLE Server + Sensors)               ││
│  └──────────────────────────┬──────────────────────────────┘│
│                              │ UART                          │
│                              ▼                               │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              Arduino Nano (Motor Control)               ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

**Key Concept:** Each bot has its own phone mounted on it. One phone per bot, 30 phones per team, 60 phones on the field. The phone runs the behavior script and records POV footage. ESP32 handles BLE communication and sensor aggregation. Arduino Nano handles motor PWM and encoder reading.

## Robot Classes

| Class | Size Limit | Target Use | Budget |
|-------|-----------|------------|--------|
| **Starter Class (20cm)** | 20cm diameter, 20cm height | Learning, casual competition | €50-100 |
| **Maintenance Class (60cm)** | 60cm diameter, 60cm height | Infrastructure work, bounties | €200-400 |

See [BOT-SPECIFICATIONS.md](../BOT-SPECIFICATIONS.md) for complete specifications.

## Module Responsibilities

### Phone (Mounted on Each Bot) (`/phone-app/`)
**Role:** Bot brain, POV camera, mesh coordination

**One phone per bot. 30 phones per team. 60 phones on the field.**

**Capabilities:**
- Executes behavior script autonomously during match
- Records POV camera footage (60 camera angles per match!)
- Coordinates with teammates via WiFi mesh
- Sends motor commands to ESP32 via BLE
- Logs all telemetry for Knowledge Commons

**Communicates via:**
- BLE to ESP32 on this bot (command/telemetry)
- WiFi mesh to other bots on team (coordination)

### ESP32 BLE Hub (`/esp32-firmware/`)
**Role:** BLE server, sensor aggregation, UART bridge to Arduino

**Written in:** Arduino C++ (Arduino IDE)

**Listens for (BLE):**
- Movement commands from phone
- Configuration updates
- Telemetry requests

**Sends (BLE):**
- Sensor readings (IMU, distance, battery)
- Motor feedback (encoder counts)
- Status updates

**UART to Arduino:**
- Forward movement commands
- Receive encoder/battery data

### Arduino Nano Motor Controller (`/arduino-motor-controller/`)
**Role:** Motor PWM control, encoder reading, battery monitoring

**Written in:** Arduino C++ (Arduino IDE)

**Listens for (UART from ESP32):**
- 0x01 MOVE_FORWARD
- 0x02 MOVE_BACKWARD
- 0x03 TURN_LEFT
- 0x04 TURN_RIGHT
- 0x05 STOP
- 0x06 DRIVE_DIFFERENTIAL
- 0x0A EMERGENCY_STOP

**Sends (UART to ESP32):**
- 0x08 STATUS (battery voltage, encoder counts) @ 10Hz

## Communication Protocols

### BLE Protocol (Phone ↔ ESP32)

**Service UUID:** `0000FFE0-0000-1000-8000-00805F9B34FB`

**Characteristics:**
| UUID | Name | Properties | Description |
|------|------|------------|-------------|
| FFE1 | Command | Write | Movement commands from phone |
| FFE2 | Telemetry | Notify | Sensor data to phone @ 10Hz |
| FFE3 | Config | Read/Write | Bot configuration |

**Command Format (FFE1):**
```
[cmd_type:1][param1:2][param2:2][checksum:1]

Commands:
0x01 MOVE_FORWARD  [duration_ms:2][speed_pct:2]
0x02 MOVE_BACKWARD [duration_ms:2][speed_pct:2]
0x03 TURN_LEFT     [duration_ms:2][speed_pct:2]
0x04 TURN_RIGHT    [duration_ms:2][speed_pct:2]
0x05 STOP          [0:2][0:2]
0x06 DIFFERENTIAL  [left_speed:2][right_speed:2]
0x0A EMERGENCY     [0:2][0:2]
```

**Telemetry Format (FFE2):**
```
[battery_mv:2][left_enc:4][right_enc:4][imu_heading:2][distance_cm:2]
```

### UART Protocol (ESP32 ↔ Arduino)

**Baud Rate:** 115200
**Packet Format:** STX + Cmd + Length + Payload + CRC8

```
┌─────┬─────┬────────┬─────────────────┬──────┐
│ STX │ Cmd │ Length │     Payload     │ CRC8 │
│ 0x02│ 1B  │   1B   │    0-255 B      │  1B  │
└─────┴─────┴────────┴─────────────────┴──────┘
```

**Commands (same as BLE, forwarded by ESP32):**
- 0x01-0x06: Movement commands
- 0x08: Status response
- 0x0A: Emergency stop

## Software Layers

**Layer 0: Firmware (this directory)**
- Arduino C++ for ESP32 and Arduino Nano
- Low-level motor control, sensor reads, BLE/UART handling
- Compiled and uploaded via Arduino IDE

**Layer 1: Phone App (per bot)**
- Python (Kivy or BeeWare framework)
- Runs behavior script, POV recording, mesh coordination
- Each bot has its own phone mounted on it

**Layer 2: Pilot's Script**
- Python behavior script written by pilot
- Uploaded to all 30 phones before match
- No changes allowed during match (autobattler format)

## Development Workflow

**Arduino Nano:**
1. Write C++ code in Arduino IDE
2. Compile and upload to Arduino Nano
3. Test UART communication with ESP32

**ESP32:**
1. Write C++ code in Arduino IDE
2. Compile and upload to ESP32
3. Test BLE connection with phone app
4. Test UART bridge to Arduino

**Phone App:**
1. Write Python behavior script (Kivy/BeeWare)
2. Test on emulator or single bot
3. Test BLE connection to ESP32
4. Deploy to all 30 phones on team's bots

## Deployment

**Rental Fleet:**
- All bots run identical ESP32/Arduino firmware
- Version tracked in Logistics Operations inventory
- Updates deployed between events

**Pilot Customization:**
- Pilots write behavior scripts (Python)
- Upload to all 30 phones before match
- Same firmware, different strategies
- Share strategies via Knowledge Commons

## Data Collection

**Match Logs (Critical for Dataset):**
- Each phone records POV footage (60 camera angles per match!)
- Each phone logs all BLE traffic and telemetry
- Auto-uploads to Knowledge Commons after match
- Collision events extracted for ML training

**Why This Matters:**
The match logs are the raw data that proves the dataset captures real swarm physics. When the Virtual Arena Simulator is trained on these logs and achieves 85%+ accuracy, it validates the entire dataset for commercial licensing.

---

For complete technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For hardware specifications, see [02-logistics-operations/README.md](../02-logistics-operations/README.md).
