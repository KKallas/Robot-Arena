# Robot Arena

**Auto chess meets robotics.** Two teams each prepare swarm scripts with AI copilots (Claude, ChatGPT), then watch 30 bots fight autonomously for 90 seconds. Nobody touches anything once the match starts. The team with more bots in the opponent's goal circle wins.

Each bot has a phone on it — that's 60 cameras filming every match. 90-second clips from 60 angles, ready for TikTok/Reels/Shorts. Every pilot becomes a content creator.

**Built for ages 15-19** — the gap between ROS (too complex, academic) and bare-metal C/Python (too low-level, no structure). Robot Arena gives young engineers a real competition framework with Python scripts, AI copilots, and physical robots, without needing a university robotics lab.

**You don't start from zero.** Fork someone's strategy from the Knowledge Commons. Retrofit an old Roomba with a €50 phone + ESP32 kit. Use last season's winning script as your starting point. Or just rent everything — bots, arena, the whole setup. Built something good? Sell your bots back to the rental pool, where they get rented and resold to the next wave of competitors. New isn't always better — Robot Arena makes the complicated things systematic and easier to manage. The whole stack is open-source: hardware designs, firmware, strategies, and match data.

**The actual product is match data.** Every match captures the full AI-assisted development process: the prompts, iterations, debugging sessions, and the swarm behavior that resulted. This is the same format as chess game notation (PGN) — but for physical robotics with adversarial WiFi hacking. AI companies license this data to train the next generation of physical-world automation systems.

---

## The Sport

**Two game modes:**

| Mode | Class | Teams | Arena | Objective |
|------|-------|-------|-------|-----------|
| **Sumo** | Starter (20cm) | 2 teams (Red vs Blue) | 3m x 3m fixed floor | Most bots in opponent's goal circle when timer hits zero |
| **Challenge** | Maintenance (60cm) | 1 team vs clock | Modular (1x1m modules) | Complete task objective within 90 seconds |

**Sumo arena:** 3m x 3m fixed floor. Goal circles at each end. Overview camera mounted above sees all IR LEDs and gives the controller a god-view of the arena.

**Challenge arena:** Built per challenge from 1x1m floor modules. Each module has 10x10cm spigots that accept 3D-printed panels — walls, ramps, obstacles, gates. Different challenges use different layouts. Overview camera above.

**Per team:** 1 main controller (laptop/phone) + up to 30 bot nodes on the field.

### How a Match Runs

**Before match:** Pilot prepares a Python script (with or without LLM assistance) and uploads it as a GitHub repo.

**Match starts (90 seconds, no human intervention):**

1. The repo is pulled and the script runs automatically on the team controller
2. It communicates with up to 30 individual nodes over WiFi
3. The script reacts to two input sources:
   - **Node telemetry** — each bot reports its own sensor data back to the controller
   - **Overview camera** — sees IR LEDs mounted on top of each bot, gives the controller a god-view of the arena

The main script can be purely programmatic (if/else, state machines) or LLM-based with software triggers for different conditions. Nobody touches anything once it starts.

**Match ends:** Timer hits zero. Scoring is evaluated.

### IR LED Rule

Every bot has an IR LED on top, visible to the overview camera. **The LED must be on for at least 45 of the 90 seconds.** This ensures bots are trackable and forces teams to be visible — you can't just go dark and hide from the overview cam.

### The Strategic Tradeoff: Central vs Local Processing

The main controller talks to nodes over WiFi. In Sumo, WiFi can be disrupted by the opposing team's hacker. This creates the core strategic tension:

**Centralized (controller-heavy):**
- Controller runs all strategy logic using overview cam + node telemetry
- Nodes are dumb actuators — just execute motor commands
- Advantage: Can coordinate the full swarm using god-view data
- Vulnerability: WiFi disruption kills everything

**Distributed (node-heavy):**
- Each node runs its own behavior logic locally
- Controller only sends high-level updates when WiFi is available
- Advantage: Resilient to WiFi hacking — nodes keep operating independently
- Vulnerability: No big-picture coordination, nodes are blind to each other

**Hybrid (the real game):**
- Nodes have fallback behaviors when they lose contact with controller
- Controller pushes formation updates when WiFi is healthy
- Best teams balance coordination with resilience

**If you can process locally on the node, you don't depend on WiFi infrastructure.** This is the hacking defense — and the core skill gap between beginner and advanced pilots.

### Teams

**Sumo (2 teams, Starter class):**

| Role | Count | Job |
|------|-------|-----|
| **Pilot** | 1 per team | Writes/prepares the swarm script that runs on the main controller |
| **Hacker** | 1 per team | Prepares WiFi disruption scripts targeting opponent's controller-to-node communication |

60 bots total on field (30 per team). Nobody touches anything once the match starts.

**Challenge (1 team, Maintenance class):**

1 Pilot + up to 30 bots vs the clock. No hacker role — no opponent to hack. The challenge is the task itself.

### Robot Classes

| Class | Size | Cost | Game Mode | Arena |
|-------|------|------|-----------|-------|
| **Starter (20cm)** | 20cm diameter, 20cm height max | ~€100-150 | Sumo (teams) | 3x3m fixed floor |
| **Maintenance (60cm)** | 60cm diameter, 60cm height max | ~€250-450 | Challenges (vs clock) | Modular 1x1m modules |

Each node is a **phone + ESP32**. The phone is the brain (runs Python, has camera, WiFi). The ESP32 connects to the phone via UART and serves as the hardware interface to low-level peripherals (I2C, SPI, GPIO → motors, sensors, IR LED). Open-source, 3D-printable chassis.

See [BOT-SPECIFICATIONS.md](BOT-SPECIFICATIONS.md) for full hardware specs.

---

## Architecture

```
                    TEAM SETUP (x2 in Sumo, x1 in Challenge)

  ┌─────────────────────────┐         ┌──────────────────────┐
  │   Overview Camera        │         │  Team Main Controller │
  │   (above arena)          │         │  (laptop/phone)       │
  │                          │         │                       │
  │   Sees IR LEDs on all    │────────▶│  Runs Python script   │
  │   bots, provides god-    │  video  │  (programmatic or     │
  │   view position data     │  feed   │   LLM-based triggers) │
  └──────────────────────────┘         └───────────┬───────────┘
                                                   │ WiFi (hackable)
                              ┌─────────────────────┼─────────────────────┐
                              │                     │                     │
                              ▼                     ▼                     ▼
                    ┌──────────────┐      ┌──────────────┐      ┌──────────────┐
                    │   Node 1     │      │   Node 2     │      │   Node 30    │
                    │ ┌──────────┐ │      │ ┌──────────┐ │      │ ┌──────────┐ │
                    │ │  Phone   │ │      │ │  Phone   │ │      │ │  Phone   │ │
                    │ │  Python  │ │      │ │  Python  │ │      │ │  Python  │ │
                    │ │  camera  │ │      │ │  camera  │ │      │ │  camera  │ │
                    │ │  WiFi    │ │      │ │  WiFi    │ │      │ │  WiFi    │ │
                    │ └────┬─────┘ │      │ └────┬─────┘ │      │ └────┬─────┘ │
                    │      │ UART   │      │      │ UART   │      │      │ UART   │
                    │ ┌────▼─────┐ │      │ ┌────▼─────┐ │      │ ┌────▼─────┐ │
                    │ │  ESP32   │ │      │ │  ESP32   │ │      │ │  ESP32   │ │
                    │ │  I2C/SPI │ │      │ │  I2C/SPI │ │      │ │  I2C/SPI │ │
                    │ │  GPIO    │ │      │ │  GPIO    │ │      │ │  GPIO    │ │
                    │ └──┬───┬───┘ │      │ └──┬───┬───┘ │      │ └──┬───┬───┘ │
                    │    │   │      │      │    │   │      │      │    │   │      │
                    │ motors IR LED │      │ motors IR LED │      │ motors IR LED │
                    │ sensors      │      │ sensors      │      │ sensors      │
                    └──────────────┘      └──────────────┘      └──────────────┘
```

**Each node = phone + ESP32:**
- **Phone:** Runs local Python logic, POV camera, WiFi to team controller. This is where local processing happens.
- **ESP32:** Connected to phone via UART (USB-OTG serial). Bridges to low-level hardware: I2C/SPI sensors, GPIO for motors, IR LED control.

**Communication flow during match:**
- Team controller → node phones: formation commands, target assignments (WiFi, hackable)
- Node phones → team controller: sensor telemetry, status reports (WiFi, hackable)
- Overview cam → team controller: all bot positions via IR LED tracking (wired/dedicated link)
- Phone → ESP32: motor commands, LED control (UART, local, unhackable)
- ESP32 → phone: sensor readings, battery status (UART, local, unhackable)

See [ARCHITECTURE.md](ARCHITECTURE.md) for protocol details (UART, command formats).

---

## What Gets Captured (The Product)

Every match generates a dataset:

```
timestamp,event_type,executed_by,data
0,match_start,system,red_vs_blue
100,controller_cmd,red_controller,node_05|move_forward|speed=80
100,node_telemetry,node_05,battery=92|enc_l=45|enc_r=42
250,overview_cam,system,node_05|x=1.2|y=0.8
500,wifi_disruption,blue_hacker,target=red_controller|method=deauth
510,node_fallback,node_05,lost_controller|executing_local_behavior
...
90000,match_end,system,winner=red|score=18-12
```

**Plus per-node logs** downloaded from ESP32 storage after match (every motor command, every sensor reading).

This data — especially the human-AI collaboration during script preparation and the centralized-vs-distributed decision patterns — is the commercial product.

---

## Why Sponsors Care

**60 camera angles per match.** Every bot has a phone with a camera. One match produces more raw content than a traditional production crew. 90-second format is native to TikTok/Reels/Shorts. Every pilot shares their POV clips organically — a distributed micro-influencer network comes built in.

**Real STEM engagement.** This isn't a staged demo. Teams use AI tools to write real code under competitive pressure. Schools, hackathons, corporate team-building — all generate authentic content with sponsor branding on the arena and bots.

**Traditional content production costs €5k-20k per video.** One Robot Arena sponsorship generates unlimited clips across 60 angles. Cost per impression crushes paid media.

---

## Business Model

**Three products:**

1. **Match datasets** — licensed to AI/robotics companies (preparation logs + match logs + per-node logs). Academic: free. Commercial: €50k-500k/year.
2. **Content** — 60 camera angles per match from bot phones + overview cam. Sponsors pay for content library access (€50k-200k/year).
3. **Hardware rental & resale** — rent bots, arenas, and all materials (€2k/weekend competition packages, €500/semester school packages, €1.4k/day corporate events). Sell your own bots into the rental pool — they get rented and resold to new users. Two-way marketplace.

**Entry is low-friction:** show up, rent bots for €50-100, compete same day. Build your own fleet and sell it back when you're done. Or 3D print from open-source designs. This scales.

**Revenue details:** See [BUSINESS-ECONOMICS.md](BUSINESS-ECONOMICS.md)

---

## Project Structure

| Directory | Purpose |
|-----------|---------|
| [01-knowledge-commons/](01-knowledge-commons/) | Open-source strategies, hardware designs, match datasets |
| [02-logistics-operations/](02-logistics-operations/) | Fleet manufacturing, rental, shipping |
| [03-league-management/](03-league-management/) | Event governance, tech tree, guild structure |
| [04-virtual-arena-simulator/](04-virtual-arena-simulator/) | Offline simulator for testing and dataset validation |
| [05-firmware/](05-firmware/) | ESP32 + Arduino firmware for physical bots |

---

## Reference Docs

- [ARCHITECTURE.md](ARCHITECTURE.md) — Hardware stack, protocols, communication formats
- [BOT-SPECIFICATIONS.md](BOT-SPECIFICATIONS.md) — Starter (20cm) and Maintenance (60cm) class specs
- [TIMELINE-ARCHITECTURE.md](TIMELINE-ARCHITECTURE.md) — Event storage format
- [THE-BOARD.md](THE-BOARD.md) — Guild marketplace system
