# Robot Arena Bot Specifications

**Version:** 1.0
**Last Updated:** 2026-02-11

---

## Overview

Robot Arena has two official robot classes, each designed for specific use cases:

| Class | Size Limit | Budget | Game Mode | Arena |
|-------|-----------|--------|-----------|-------|
| **Starter Class (20cm)** | 20cm diameter, 20cm height | €100-150 (incl. phone) | Sumo (teams) | 3x3m fixed floor |
| **Maintenance Class (60cm)** | 60cm diameter, 60cm height | €250-450 (incl. phone) | Challenges (vs clock) | Modular 1x1m modules |

Both classes share the same software architecture: **each bot has a phone mounted on it** running Python behavior scripts, with an ESP32 connected via UART (USB-OTG serial) as hardware bridge to motors, sensors, and IR LED. One phone per bot, up to 30 per team.

---

## Starter Class (20cm)

**Purpose:** Low-cost entry point for learning swarm robotics. Used in Sumo mode (2 teams, 3x3m fixed arena).

### Physical Constraints

```
┌─────────────────────────────────────┐
│         20cm Starter Class          │
├─────────────────────────────────────┤
│                                     │
│    ┌───────────────────────┐        │
│    │                       │        │
│    │    Must fit inside    │  20cm  │
│    │    20cm diameter      │  max   │
│    │    circle at start    │ height │
│    │                       │        │
│    └───────────────────────┘        │
│         20cm diameter               │
│                                     │
│  - Can extend during match          │
│  - Must start within bounds         │
│  - Weight: <500g recommended        │
└─────────────────────────────────────┘
```

**Size Rules:**
- Must fit within 20cm diameter circle when placed at start position
- Must not exceed 20cm height when placed at start position
- May extend/unfold during match (no limit once started)
- No weight limit, but <500g recommended for battery life

### Reference Platform: SMARS Mini

**Bill of Materials (~€100-150 including phone):**
- **Phone (mounted on bot):** €50-100 (used Android phone)
- ESP32 DevKit or M5 Atom: €8-15
- 2x N20 gear motors: €8-12
- L298N mini motor driver: €3-5
- 7.4V 500mAh LiPo: €8-12
- 3D printed SMARS chassis: €5-10
- Phone mount bracket: €3-5
- Wheels, wires, fasteners: €5-10
- Optional: MPU6886 IMU: €5-8

**Capabilities:**
- Speed: ~0.3 m/s
- Runtime: ~30 minutes continuous
- Sensors: Basic (IMU, encoders) + phone camera
- Compute: Full smartphone for behavior scripts
- Communication: UART (phone↔ESP32 via USB-OTG), WiFi (phone↔team controller)

### Who Uses Starter Class

- **Ages 15-19:** The primary target audience — between ROS and bare-metal C/Python
- **Schools:** Robotics clubs, STEM programs
- **Beginners:** First-time competitors learning the ropes
- **Casual Events:** Meetups, demo days

---

## Maintenance Class (60cm)

**Purpose:** Larger platform for timed challenges. Used in Challenge mode (1 team vs clock, modular arena built from 1x1m modules with 3D-printed panels).

### Physical Constraints

```
┌─────────────────────────────────────┐
│       60cm Maintenance Class        │
├─────────────────────────────────────┤
│                                     │
│    ┌───────────────────────┐        │
│    │                       │        │
│    │    Must fit inside    │  60cm  │
│    │    60cm diameter      │  max   │
│    │    circle at start    │ height │
│    │                       │        │
│    └───────────────────────┘        │
│         60cm diameter               │
│                                     │
│  - Can extend during operation      │
│  - Modular attachment points        │
│  - Weatherproof recommended         │
└─────────────────────────────────────┘
```

**Size Rules:**
- Must fit within 60cm diameter circle when placed at start position
- Must not exceed 60cm height when placed at start position
- May extend/unfold during operation
- Weight limit: <15kg (for safe handling)

### Reference Platform: Custom Maintenance Bot

**Bill of Materials (~€250-450 including phone):**
- **Phone (mounted on bot):** €50-100 (used Android phone)
- ESP32 main controller: €10-15
- 4x brushless motors + ESCs: €60-100
- Motor driver board: €20-30
- 11.1V 5000mAh LiPo: €40-60
- Aluminum/printed chassis: €30-50
- Weatherproof enclosure: €20-40
- Sensor package (lidar, optional camera): €30-70
- Phone mount (weatherproof): €10-20
- Modular attachment mount: €20-30

**Capabilities:**
- Speed: ~1 m/s
- Runtime: 2+ hours
- Payload: Up to 2kg
- Sensors: Full suite (lidar, phone camera, IMU, environmental)
- Compute: Full smartphone for behavior scripts
- Communication: UART (phone↔ESP32 via USB-OTG), WiFi (phone↔team controller)
- Weatherproof: IP54 minimum recommended
- Modular: Standard attachment points for task-specific tools

### Who Uses Maintenance Class

- **Challenge Competitors:** Teams tackling timed tasks on modular arenas
- **Professional Competitors:** Championship-level events
- **Infrastructure Operators:** Validated designs for real-world deployment

---

## Competition Types

### Sumo (Starter Class, 20cm)

**Format:** 2 teams compete to control territory on a fixed 3x3m arena.

```
┌─────────────────────────────────────────┐
│           3m × 3m Fixed Arena           │
│                                         │
│   🔴 Red                     Blue 🔵   │
│   Goal                       Goal       │
│   Circle                    Circle      │
│                                         │
│         🤖🤖🤖   🤖🤖🤖               │
│         Team     Team                   │
│         Red      Blue                   │
│                                         │
└─────────────────────────────────────────┘
```

**Rules:**
- 90-second matches
- 2 teams (Pilot + Hacker per team)
- 30 bots per team (60 total on field)
- **Victory:** Team with more bots in opponent's goal circle when time expires
- Autobattler format: No intervention during match

### Challenge (Maintenance Class, 60cm)

**Format:** Single team attempts to complete a task objective within 90 seconds on a modular arena.

```
┌─────────────────────────────────────────┐
│        Modular Arena (1x1m modules)     │
│                                         │
│   ┌────┐┌────┐┌────┐                   │
│   │    ││    ││    │  Each 1x1m module  │
│   │    ││    ││    │  has 10x10cm       │
│   └────┘└────┘└────┘  spigots for       │
│   ┌────┐┌────┐┌────┐  3D-printed panels │
│   │    ││    ││    │  (walls, ramps,    │
│   │    ││    ││    │   obstacles, gates) │
│   └────┘└────┘└────┘                    │
│                                         │
│   Different layout per challenge        │
└─────────────────────────────────────────┘
```

**Rules:**
- 90-second matches (1 team vs clock)
- No opponent — the challenge is the task itself
- 1 Pilot + up to 30 bots
- Arena layout configured per challenge using modular 1x1m floor modules with 3D-printed panels
- Success criteria defined per challenge

---

## Class Comparison

| Feature | Starter (20cm) | Maintenance (60cm) |
|---------|----------------|-------------------|
| **Size** | 20cm × 20cm | 60cm × 60cm |
| **Cost** | €100-150 (incl. phone) | €250-450 (incl. phone) |
| **Build Time** | 1-2 days | 1-2 weeks |
| **Skills Needed** | Basic soldering, 3D printing | Intermediate electronics, weatherproofing |
| **Game Mode** | Sumo (teams) | Challenges (vs clock) |
| **Arena** | 3x3m fixed floor | Modular 1x1m modules |
| **Rental Available** | Yes (events) | Yes (events) |

---

## Upgrading Between Classes

**Starter → Maintenance Path:**
1. Master Sumo competition with Starter Class (win events, build reputation)
2. Learn maintenance-specific skills (weatherproofing, sensors, larger platforms)
3. Build or buy Maintenance Class bot
4. Compete in Challenge mode on modular arenas

**The progression is intentional:** Starter Class teaches swarm fundamentals in Sumo without high financial risk. Maintenance Class applies those skills to more complex challenge tasks.

---

## Rental Options

### Starter Class Rental
- **School package:** €300/semester (6 bots + curriculum)
- **Event rental:** €50/day per bot
- **Tournament package:** €500/weekend (30-bot team)

### Maintenance Class Rental
- **Event rental:** €100/day per bot
- **Tournament package:** €2000/weekend (30-bot team + arena)
- **Contract support:** €200/day (bot + technical assistance)

---

## Design Philosophy

**Why Two Classes?**

1. **Lower barrier to entry:** €50 is accessible; €400 is a commitment
2. **Clear progression:** Start small, prove yourself, scale up
3. **Different economics:** Entertainment vs. income generation
4. **Appropriate complexity:** Simple tasks need simple bots

**Why These Specific Sizes?**

- **20cm:** Fits on a desk, printable on consumer 3D printers, cheap motors work
- **60cm:** Big enough for real work, small enough for one person to carry, fits through standard doors

**Why Budget Constraints?**

- Forces resourcefulness over spending
- Levels playing field
- Proves designs are reproducible
- Matches infrastructure maintenance economics
