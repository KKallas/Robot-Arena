# Physical Bot Firmware

**Purpose:** Software stack for SMARS bots with shared UART bus architecture.

## Hardware Stack

```
┌─────────────────────────────────────────┐
│         Shared UART Bus                  │
│     (921600 baud, all modules)          │
│                                         │
│  ┌─────────┐  ┌─────────┐  ┌────────┐ │
│  │ M5 Cam  │  │ M5 Atom │  │Arduino │ │
│  │ ESP32-S3│  │ ESP32   │  │ Nano   │ │
│  └─────────┘  └─────────┘  └────────┘ │
│      │             │            │      │
│  (Web UI)     (Logic)      (Motors)    │
│  (Logs all)                            │
└─────────────────────────────────────────┘
```

**Key Concept:** Single shared UART bus where:
- Everyone listens to all traffic
- Modules ignore commands not meant for them
- M5 Camera logs everything to SD card
- Arduino processes commands 0x01-0x0E (motor control)
- M5 Atom processes commands 0x0F (Custom type 0x01 - web UI commands)

## Module Responsibilities

### Arduino Motor Controller (`/arduino-motor-controller/`)
**Role:** Motor PWM control, encoder reading, battery monitoring

**Listens for:**
- 0x01 MOVE_FORWARD
- 0x02 MOVE_BACKWARD
- 0x03 TURN_LEFT
- 0x04 TURN_RIGHT
- 0x05 STOP
- 0x06 DRIVE_DIFFERENTIAL
- 0x0A EMERGENCY_STOP

**Ignores:**
- 0x0F CUSTOM (not for motors)

**Sends:**
- 0x08 STATUS (battery voltage, encoder counts) @ 10Hz

### M5 Atom Logic Brain (`/m5atom-micropython/`)
**Role:** Pure application logic in vanilla MicroPython + custom init.py

**Listens for:**
- 0x0F CUSTOM type 0x01 (web UI commands from M5 Camera)
- 0x08 STATUS (from Arduino, for position estimate)

**Ignores:**
- Motor commands (Arduino handles those)

**Sends:**
- 0x01-0x06 motor commands (to Arduino)
- 0x0F CUSTOM type 0x06 (debug telemetry for M5 Camera logging)

**No HTTP server** - all networking handled by M5 Camera

### M5 Camera Web Server (`/m5camera-webui/`)
**Role:** Web UI + passive UART logger

**Listens for:**
- **All UART traffic** (logs everything to SD card)

**Sends:**
- 0x0F CUSTOM type 0x01 (web UI commands to M5 Atom)

**HTTP Endpoints:**
- `GET /` - Serve 3-tab interface
- `POST /api/trigger` - Forward commands to M5 Atom via UART
- `GET /api/camera` - Stream POV feed (MJPEG)
- `GET /api/logs` - Return recent UART log entries

**Automatic Upload:**
After each event, M5 Camera uploads UART logs to Knowledge Commons via WiFi.

## UART Protocol (`/uart-protocol/`)

**16-Command Specification**
- See [ARCHITECTURE.md](../ARCHITECTURE.md) for complete protocol details
- Packet format: STX + Cmd + Length + Payload + CRC8
- Commands 0x00-0x0E: Standard (motor control, status, etc.)
- Command 0x0F: Custom (extensible for sensors, web UI, etc.)

**Custom Command Structure:**
```
0x0F [type] [length_2B] [data]

Types:
0x01 - Web UI command (M5 Camera → M5 Atom)
0x02 - Lidar scan data (future)
0x03 - Vision detection (future)
0x06 - Debug telemetry (M5 Atom → M5 Camera for logging)
```

## Software Layers

**Layer 0: Firmware (this directory)**
- Low-level motor control, sensor reads
- Built into Arduino/M5 Atom

**Layer 1: Python Automation**
- User-defined functions in M5 Atom init.py
- Uploaded via web UI (Tab 2)

**Layer 2: JavaScript Orchestration**
- Multi-bot coordination in browser (Tab 3)
- Sends HTTP commands to multiple bots

## Development Workflow

**Arduino:**
1. Write C++ code in Arduino IDE
2. Compile and upload to Arduino Nano
3. Test UART communication with M5 Atom

**M5 Atom:**
1. Write Python in `init.py`
2. Upload vanilla MicroPython firmware + init.py
3. Test UART bus, ESP-NOW mesh

**M5 Camera:**
1. Write Python web server + HTML/JS UI
2. Upload MicroPython firmware
3. Test web UI, UART logging

## Deployment

**Rental Fleet:**
- All 60 bots in fleet run identical firmware
- Version tracked in Logistics Operations inventory
- Updates deployed between events

**Custom Mods:**
- Pilots modify init.py (M5 Atom)
- Upload via web UI or SD card
- Document in Knowledge Commons for recognition

## Data Collection

**UART Logs (Critical for Dataset):**
- M5 Camera logs all bus traffic to SD card
- Auto-uploads to Knowledge Commons after match
- Collision events extracted for ML training
- Complete communication record (every motor command, status update)

**Why This Matters:**
The UART logs are the raw data that proves the dataset captures real swarm physics. When the Virtual Arena Simulator is trained on these logs and achieves 85%+ accuracy, it validates the entire dataset for commercial licensing.

---

For complete technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For hardware specifications, see [02-logistics-operations/README.md](../02-logistics-operations/README.md).
