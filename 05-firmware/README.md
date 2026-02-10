# Physical Bot Firmware

**Purpose:** Software stack for SMARS bots with Android phone + ESP32 UART-to-I2C bridge architecture.

## Hardware Stack

```
┌─────────────────────────────────────────┐
│    Android Phone (Termux + Flask)       │
│    Central Controller (~€50 used)       │
│         (Web UI, Python Logic)          │
└──────────────────┬──────────────────────┘
                   │ USB-OTG Serial Cable
                   ▼
┌─────────────────────────────────────────┐
│    ESP32 UART-to-I2C Bridge             │
│    (Interface Layer)                     │
└──────────────────┬──────────────────────┘
                   │ I2C Bus
┌──────────────────┴──────────────────────┐
│  ┌─────────┐  ┌─────────┐  ┌────────┐  │
│  │ M5 Atom │  │Arduino  │  │Sensors │  │
│  │ ESP32   │  │ Nano    │  │ (I2C)  │  │
│  │(Sensors)│  │(Motors) │  │        │  │
│  └─────────┘  └─────────┘  └────────┘  │
└─────────────────────────────────────────┘
```

**Key Concept:** Android phone as central controller:
- Phone runs Flask web server + Python logic (previously on M5 Camera/Atom)
- USB-OTG serial connects phone to ESP32 bridge
- ESP32 bridge translates UART commands to I2C for module communication
- Arduino processes motor commands 0x01-0x0E via I2C
- M5 Atom handles IMU sensors + mesh networking (optional)
- **Scalable:** Add more ESP32 bridges for additional I/O ports

## Module Responsibilities

### Android Phone (Termux) - Central Controller (`/android-termux/`)
**Role:** Web server + Python logic + logger (replaces M5 Camera + most of M5 Atom logic)

**Runs:**
- Flask web server (3-tab interface)
- Python application logic (formation behaviors, trigger management)
- Serial communication via USB-OTG to ESP32 bridge
- POV camera streaming (via phone's built-in camera)
- Complete traffic logging to phone storage

**HTTP Endpoints:**
- `GET /` - Serve 3-tab interface
- `POST /api/trigger` - Execute commands, send via serial to ESP32 bridge
- `GET /api/camera` - Stream POV feed (MJPEG via phone camera)
- `GET /api/logs` - Return recent serial log entries

**Automatic Upload:**
After each event, phone uploads serial logs to Knowledge Commons via WiFi.

### ESP32 UART-to-I2C Bridge (`/esp32-bridge/`)
**Role:** Interface layer between phone and hardware modules

**Receives (from phone via USB-OTG):**
- All command packets (0x00-0x0F)

**Translates and routes:**
- Motor commands (0x01-0x0E) to Arduino via I2C
- Custom commands (0x0F) to M5 Atom via I2C
- Status responses back to phone

**Provides:**
- Analog/digital I/O expansion
- I2C bus master for module communication

**Scalability:**
Add more ESP32 bridges for additional I/O ports (phone can manage multiple via USB hub).

### Arduino Motor Controller (`/arduino-motor-controller/`)
**Role:** Motor PWM control, encoder reading, battery monitoring

**Receives via I2C:**
- 0x01 MOVE_FORWARD
- 0x02 MOVE_BACKWARD
- 0x03 TURN_LEFT
- 0x04 TURN_RIGHT
- 0x05 STOP
- 0x06 DRIVE_DIFFERENTIAL
- 0x0A EMERGENCY_STOP

**Ignores:**
- 0x0F CUSTOM (not for motors)

**Sends via I2C:**
- 0x08 STATUS (battery voltage, encoder counts) @ 10Hz

### M5 Atom Sensor Hub (`/m5atom-micropython/`) - Optional
**Role:** IMU sensor reading + ESP-NOW mesh networking

**Receives via I2C:**
- 0x0F CUSTOM type 0x01 (sensor read requests)

**Sends via I2C:**
- IMU data (gyro, accelerometer)
- Mesh network status
- 0x0F CUSTOM type 0x06 (telemetry data)

**Note:** Python logic that previously ran on M5 Atom now runs on the Android phone. M5 Atom is optional and focuses on sensor reading + mesh networking.

## Serial Protocol (`/serial-protocol/`)

**16-Command Specification**
- See [ARCHITECTURE.md](../ARCHITECTURE.md) for complete protocol details
- Packet format: STX + Cmd + Length + Payload + CRC8
- Commands 0x00-0x0E: Standard (motor control, status, etc.)
- Command 0x0F: Custom (extensible for sensors, web UI, etc.)

**Communication Layers:**
- **Phone ↔ ESP32 Bridge:** USB-OTG serial (921600 baud)
- **ESP32 Bridge ↔ Modules:** I2C bus (400kHz Fast Mode)

**Custom Command Structure:**
```
0x0F [type] [length_2B] [data]

Types:
0x01 - Web UI command (Phone → Bridge → M5 Atom)
0x02 - Lidar scan data (future)
0x03 - Vision detection (future)
0x06 - Debug telemetry (M5 Atom → Bridge → Phone for logging)
```

## Software Layers

**Layer 0: Firmware (this directory)**
- Low-level motor control, sensor reads
- Built into Arduino (motors), ESP32 bridge (translation), M5 Atom (sensors)

**Layer 1: Python Automation**
- User-defined functions run on Android phone (Termux)
- Uploaded/edited via web UI (Tab 2)
- Full Python 3 (not MicroPython) enables richer logic

**Layer 2: JavaScript Orchestration**
- Multi-bot coordination in browser (Tab 3)
- Sends HTTP commands to multiple bot phones

## Development Workflow

**Arduino:**
1. Write C++ code in Arduino IDE
2. Compile and upload to Arduino Nano
3. Test I2C communication with ESP32 bridge

**ESP32 Bridge:**
1. Write C++ or MicroPython firmware
2. Flash to ESP32 dev board
3. Test USB-OTG serial + I2C translation

**M5 Atom (Optional):**
1. Write MicroPython sensor/mesh code
2. Upload vanilla MicroPython firmware
3. Test I2C bus, ESP-NOW mesh

**Android Phone:**
1. Install Termux, Python, Flask
2. Write Python web server + HTML/JS UI
3. Test web UI, USB-OTG serial communication, logging

## Deployment

**Rental Fleet:**
- All 60 bots in fleet run identical firmware (bridge + Arduino)
- Android phones configured with identical Termux + Flask setup
- Version tracked in Logistics Operations inventory
- Updates deployed between events (firmware via OTA, phone apps via WiFi)

**Custom Mods:**
- Pilots modify Python scripts on phone
- Upload via web UI or direct Termux access
- Document in Knowledge Commons for recognition

## Data Collection

**Serial Logs (Critical for Dataset):**
- Android phone logs all serial traffic to phone storage
- Auto-uploads to Knowledge Commons after match via WiFi
- Collision events extracted for ML training
- Complete communication record (every motor command, status update)

**Why This Matters:**
The serial logs are the raw data that proves the dataset captures real swarm physics. When the Virtual Arena Simulator is trained on these logs and achieves 85%+ accuracy, it validates the entire dataset for commercial licensing.

---

For complete technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For hardware specifications, see [02-logistics-operations/README.md](../02-logistics-operations/README.md).
