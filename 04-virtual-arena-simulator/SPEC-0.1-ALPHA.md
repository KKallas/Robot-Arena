# Virtual Arena Simulator - v0.1 Alpha Specification

**Version:** 0.1-alpha
**Status:** Draft
**Last Updated:** 2026-02-10

---

## Overview

This specification defines the minimum viable product (MVP) for the Virtual Arena Simulator v0.1 Alpha release. The goal is to validate the core simulation loop and ML collision prediction before adding visual polish.

**Scope Limitation:** This spec covers only what is required for a functional alpha. Features like CRT shaders, terminal UI aesthetics, and advanced rendering are deferred to later releases.

---

## Documentation Consistency Note

**Contradiction Found:** `ARCHITECTURE.md` references Unreal Engine 5 for rendering, while `04-virtual-arena-simulator/README.md` explicitly states Godot Engine 4.x. This spec follows the README's direction (Godot) as it appears to be a deliberate architectural revision toward a lightweight, open-source stack.

**Recommendation:** Update `ARCHITECTURE.md` to reflect the Godot decision, or clarify if both rendering options will be supported.

---

## Core Features

### 1. Physics Engine (Python)

**Minimum Requirements:**
- Update loop running at 4Hz (250ms intervals)
- Support for 60 virtual bots simultaneously
- Grid-based position tracking (x, y, theta)
- Basic collision detection (proximity-based, configurable threshold)
- Arena boundary enforcement

**Deferred to v0.2+:**
- Obstacles and goal circles
- Damage/disabling mechanics

### 2. ML Collision Predictor (PyTorch)

**Minimum Requirements:**
- Load pre-trained model file (`collision_predictor_v1.pth`)
- Accept 11-feature input vector:
  - Bot A: position (2), velocity (2), mass (1)
  - Bot B: position (2), velocity (2), mass (1)
  - Collision angle (1)
- Output 6 values:
  - Post-collision velocities for both bots (4)
  - Damage values for both bots (2)
- Inference time: <10ms per collision on M4 Neural Engine

**Deferred to v0.2+:**
- On-device training/fine-tuning
- Multi-bot collision chains

### 3. Virtual Bot Emulation

**Minimum Requirements:**
- Single bot class emulating M5 Atom + Arduino behavior
- Execute Layer 0 movement commands (forward, backward, turn, stop)
- Simulated IMU sensor data with noise injection
- Basic position dead-reckoning

**Deferred to v0.2+:**
- Full UART bus simulation
- Camera feed generation
- Web server per bot (Flask)

### 4. Event Logging

**Minimum Requirements:**
- Write `events.csv` in same format as physical matches
- Log: timestamp, bot_id, event_type, position, velocity
- Log collision events with pre/post states

**Deferred to v0.2+:**
- Full UART packet logging
- Network traffic capture simulation

---

## Input/Output Specification

### Inputs

| Input | Format | Description |
|-------|--------|-------------|
| Initial bot positions | JSON array | `[{id, x, y, theta, mass}, ...]` |
| Bot commands | JSON | `{bot_id, command, params}` |
| ML model weights | `.pth` file | PyTorch state dict |
| Arena config | JSON | `{width, height, boundaries}` |

**Example Initial Positions:**
```json
{
  "bots": [
    {"id": 1, "x": 0.5, "y": 0.5, "theta": 0.0, "mass": 0.18},
    {"id": 2, "x": 1.5, "y": 0.5, "theta": 3.14, "mass": 0.20}
  ],
  "arena": {
    "width": 3.0,
    "height": 2.0
  }
}
```

**Example Command:**
```json
{
  "bot_id": 1,
  "command": "MOVE_FORWARD",
  "params": {
    "duration_ms": 1000,
    "speed_percent": 80
  }
}
```

### Outputs

| Output | Format | Description |
|--------|--------|-------------|
| Bot states | JSON (WebSocket) | Position updates at 4Hz |
| Event log | CSV | `events.csv` for match replay |
| Collision log | JSON | Per-collision state changes |

**Example State Update (WebSocket):**
```json
{
  "timestamp": 1704657600000,
  "bots": [
    {"id": 1, "x": 0.6, "y": 0.5, "theta": 0.0, "vx": 0.4, "vy": 0.0},
    {"id": 2, "x": 1.4, "y": 0.5, "theta": 3.14, "vx": -0.4, "vy": 0.0}
  ]
}
```

**Example events.csv:**
```csv
timestamp,bot_id,event_type,x,y,theta,vx,vy,extra
0.000,1,SPAWN,0.500,0.500,0.000,0.000,0.000,
0.000,2,SPAWN,1.500,0.500,3.140,0.000,0.000,
0.250,1,MOVE,0.600,0.500,0.000,0.400,0.000,
1.250,1,COLLISION,0.950,0.500,0.000,0.100,0.200,bot_id=2
```

---

## Test Plan

### Unit Tests

| Test ID | Component | Description | Pass Criteria |
|---------|-----------|-------------|---------------|
| UT-01 | Physics | Bot moves forward correctly | Position delta matches expected velocity * time |
| UT-02 | Physics | Bot respects arena boundaries | Position clamped to arena bounds |
| UT-03 | Physics | Collision detected at threshold | Collision triggered when distance < 0.1m |
| UT-04 | ML Model | Model loads successfully | No exceptions, model in eval mode |
| UT-05 | ML Model | Inference returns correct shape | Output tensor shape is (6,) |
| UT-06 | ML Model | Inference time acceptable | <10ms per prediction |
| UT-07 | Logging | events.csv created | File exists after simulation run |
| UT-08 | Logging | CSV format valid | All required columns present |

### Integration Tests

| Test ID | Description | Pass Criteria |
|---------|-------------|---------------|
| IT-01 | 2-bot collision scenario | ML model called, velocities updated |
| IT-02 | 60-bot initialization | All bots spawn without error |
| IT-03 | 90-second match simulation | Completes without crash, events.csv written |
| IT-04 | WebSocket state broadcast | Client receives updates at ~4Hz |

### Validation Tests (Sim-to-Real)

| Test ID | Metric | Target | Data Source |
|---------|--------|--------|-------------|
| VT-01 | Position RMSE | <15cm after 90s | Compare to physical match replay |
| VT-02 | Collision velocity accuracy | >70% | Compare predicted vs actual post-collision velocities |
| VT-03 | Event sequence match | >80% events in correct order | Compare events.csv to physical match log |

**Note:** Validation tests require physical match data from Knowledge Commons. For alpha, use synthetic test scenarios if real data unavailable.

---

## Tasks

### Phase 1: Core Infrastructure

- [ ] **T1.1** Set up Python project structure (`/game-engine/`)
- [ ] **T1.2** Implement `Bot` class with position, velocity, mass attributes
- [ ] **T1.3** Implement `Arena` class with boundary enforcement
- [ ] **T1.4** Implement main physics loop (4Hz timer)
- [ ] **T1.5** Add proximity-based collision detection

### Phase 2: ML Integration

- [ ] **T2.1** Create `CollisionPredictor` PyTorch model class
- [ ] **T2.2** Implement model loading from `.pth` file
- [ ] **T2.3** Integrate collision predictor into physics loop
- [ ] **T2.4** Add collision event logging (JSON format)

### Phase 3: Bot Emulation

- [ ] **T3.1** Implement movement commands (forward, backward, turn, stop)
- [ ] **T3.2** Add simulated IMU sensor with Gaussian noise
- [ ] **T3.3** Implement position dead-reckoning from motor commands

### Phase 4: Event System

- [ ] **T4.1** Implement `events.csv` writer
- [ ] **T4.2** Log spawn events for all bots
- [ ] **T4.3** Log movement state changes
- [ ] **T4.4** Log collision events with both bot states

### Phase 5: Communication

- [ ] **T5.1** Implement WebSocket server for state broadcast
- [ ] **T5.2** Define JSON message schema for state updates
- [ ] **T5.3** Test with simple WebSocket client

### Phase 6: Testing & Validation

- [ ] **T6.1** Write unit tests (UT-01 through UT-08)
- [ ] **T6.2** Write integration tests (IT-01 through IT-04)
- [ ] **T6.3** Create synthetic test scenario for validation
- [ ] **T6.4** Document test results and known limitations

---

## Success Criteria for v0.1 Alpha

1. **Functional:** 60 virtual bots complete a 90-second simulated match without crashes
2. **Logged:** `events.csv` contains all spawn, movement, and collision events
3. **ML-Integrated:** Collision predictor model is called for all detected collisions
4. **Observable:** WebSocket endpoint broadcasts bot positions at 4Hz
5. **Tested:** All unit tests pass, integration tests documented

---

## Out of Scope for v0.1 Alpha

- Godot renderer integration (visual display)
- Web interface / Flask servers per bot
- CRT shaders and cyberpunk aesthetics
- Full UART bus simulation
- Camera feed generation
- Match scoring system
- Network attack simulation
- Multi-Mac scaling

---

## Dependencies

- Python 3.11+
- PyTorch 2.0+
- NumPy
- websockets (Python library)
- pytest (for testing)

---

## References

- [ARCHITECTURE.md](../ARCHITECTURE.md) - Full system architecture
- [README.md](./README.md) - Simulator overview and aesthetic direction
- [Knowledge Commons](../01-knowledge-commons/README.md) - Dataset structure for ML training
