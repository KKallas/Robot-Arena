# MechArena

**Auto chess meets robotics.** Two teams each prepare swarm scripts with AI copilots (Claude, ChatGPT, Ollama or any other LLM), then watch 30 bots fight autonomously for 90 seconds. Nobody touches anything once the match starts. The team with more bots in the opponent's goal circle wins.

Each bot has a phone on it — that's 60 cameras filming every match. 90-second clips from 60 angles, ready for TikTok/Reels/Shorts. Every pilot becomes a content creator.

**Built for ages 15-19** — the gap between ROS (too complex, academic) and bare-metal C/Python (too low-level, no structure). MechArena gives young engineers a real competition framework with Python scripts, AI copilots, and physical robots, without needing a university robotics lab.

**You don't start from zero.** Fork someone's strategy from the Knowledge Commons. Retrofit an old Roomba with a €50 phone + ESP32 kit. Use last season's winning script as your starting point. Or just rent everything — bots, arena, the whole setup. Built something good? Sell your bots back to the rental pool, where they get rented and resold to the next wave of competitors. New isn't always better — MechArena makes the complicated things systematic and easier to manage. The whole stack is open-source: hardware designs, firmware, strategies, and match data.

**The actual product is match data.** Every match captures the full AI-assisted development process: the prompts, iterations, debugging sessions, and the swarm behavior that resulted. This is the same format as chess game notation (PGN) — but for physical robotics with adversarial WiFi hacking. AI companies license this data to train the next generation of physical-world automation systems.

---

## Why This Exists

DJI drones didn't win because of better motors or sensors — those components are available to everyone. They won because tens of thousands of iterations gave them a data advantage nobody else has. When DJI got restricted in the US, it exposed the real problem: Europe and the West have no equivalent iteration pipeline for affordable robotics.

**Catching up requires more samples, faster.** To close the gap, we need to generate and validate millions of real-world interactions. That means we need a product people actually want to build, compete with, and collect data from at massive scale. That's the Arena — the competition creates demand for cheap robots, and cheap robots generate data.

**The sim-to-real problem is the same everywhere.** When you run a heat or static loading simulation in Fusion 360, you don't trust it blindly. You build a simplified physical model, measure it, tune the simulator inputs until the results match reality, then swap in the final design and simulate. MechArena does the same thing for robotics: if you know your current position, motion vector, and spin, an ML model should predict your next frame — accounting for collisions and boundaries. Run the exact same program in simulation and reality, compare the outputs, and fine-tune until they converge.

**Why ML instead of a physics engine?** The predictor doesn't simulate physics — it finds the closest matching paths from real recorded matches. Given your current state (position, motion vector, spin), the model returns the top 10-20 closest real-world trajectories and their percentage match. Your predicted next frame is a weighted blend of paths that actually happened. More recorded matches = better predictions. This is why the competition feeds the simulator — every match makes the model more accurate.

**Public benchmarking is built in.** Since we run the same program in both simulation and reality, and we can run both unlimited times, the arena itself is the benchmarking infrastructure. Every match publicly validates how good the model is — in front of an audience. The gap between predicted and actual outcomes is measurable, visible, and continuously shrinking as the dataset grows.

**This gives us validated simulation.** And validated simulation is what lets you start building actually useful robots — not bleeding-edge research platforms, but affordable machines for work that doesn't justify a human salary yet costs more when left undone. Infrastructure maintenance: bridges, pipes, rails, roads. Nobody has made general-purpose robots cheaper than humans yet. That's not the horse to bet on today. But narrow-task robots, validated against real-world data, running on repurposed hardware? That's achievable.

**Where this leads: embodied cognition.** A path-matching model is small and fast — no heavy physics simulation, just lookup and interpolation. That's the kind of model you can run on ultra-small hardware with an LLM for decision-making. Cheap, specific robots that understand their physical environment because they've seen thousands of real-world examples of it. The arena builds the dataset, the dataset builds the model, the model fits on the robot — and that robot goes out and does infrastructure maintenance.

**Green thinking only works when greed supports it.** Henry Ford didn't double his workers' wages out of generosity — he did it because trained workers kept leaving, training replacements was expensive, and every worker who left took their skills to a competitor. Paying more was the cheaper option. Same logic here: repurposing old phones as robot brains and retrofitting Roombas instead of buying new isn't idealism — it's the only way to get input costs low enough to compete. The reuse is a side effect of the economics, not the goal. If we can keep some public infrastructure maintained longer and extend its life along the way, we've done something worthwhile.

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

Each team uploads two repos: a **swarm script** (runs on the team controller, commands 30 bots) and a **hacking script** (WiFi disruption targeting the opponent's controller-to-node communication). 60 bots total on field. Nobody touches anything once the match starts.

**Challenge (1 team, Maintenance class):**

One team uploads a swarm script + up to 30 bots vs the clock. No hacking — no opponent to hack. The challenge is the task itself.

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

  ┌──────────────────────────┐          ┌───────────────────────┐
  │   Overview Camera        │          │  Team Main Controller │
  │   (above arena)          │          │  (laptop/phone)       │
  │                          │          │                       │
  │   Sees IR LEDs on all    │─────────▶│  Runs Python script   │
  │   bots, provides god-    │  video   │  (programmatic or     │
  │   view position data     │  feed    │   LLM-based triggers) │
  └──────────────────────────┘          └───────────┬───────────┘
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
                    │      │ UART  │      │      │ UART  │      │      │ UART  │
                    │ ┌────▼─────┐ │      │ ┌────▼─────┐ │      │ ┌────▼─────┐ │
                    │ │  ESP32   │ │      │ │  ESP32   │ │      │ │  ESP32   │ │
                    │ │  I2C/SPI │ │      │ │  I2C/SPI │ │      │ │  I2C/SPI │ │
                    │ │  GPIO    │ │      │ │  GPIO    │ │      │ │  GPIO    │ │
                    │ └──┬───┬───┘ │      │ └──┬───┬───┘ │      │ └──┬───┬───┘ │
                    │    │   │     │      │    │   │     │      │    │   │     │
                    │ motors IrLED │      │ motors IrLED │      │ motors IrLED │
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

**Traditional content production costs €5k-20k per video.** One MechArena sponsorship generates unlimited clips across 60 angles. Cost per impression crushes paid media.

---

## Business Model

**Three products:**

1. **Match datasets** — licensed to AI/robotics companies (preparation logs + match logs + per-node logs). Academic: free. Commercial: €50k-500k/year.
2. **Content & sponsorship** — event content creators are trained and quality-validated by MechArena (tutorials on YouTube) to produce sponsor-grade social media content from arena events. 60 camera angles per match + overview cam = massive raw footage. Sponsors pay to have branding in the arena and on bots, then repost the validated content to their own channels. Companies are buying a quality-controlled content pipeline, not ad space (€50k-200k/year).
3. **Hardware rental & resale** — rent bots, arenas, and all materials (€2k/weekend competition packages, €500/semester school packages, €1.4k/day corporate events). Sell your own bots into the rental pool — they get rented and resold to new users. Two-way marketplace.

**Entry is low-friction:** show up, rent bots for €50-100, compete same day. Build your own fleet and sell it back when you're done. Or 3D print from open-source designs. This scales.

**Revenue details:** See [BUSINESS-ECONOMICS.md](BUSINESS-ECONOMICS.md)

---

## Education

**People need questions before they can learn answers.** A teacher who has already solved the problem is useless for the learning process — because the main thing students need to learn is how to validate their own understanding. Going through the motions of a pre-solved exercise teaches compliance, not engineering. Students need to solve novel problems with instructions, not rehearse someone else's solution.

MechArena gives them that. Every match is a novel problem. The arena configuration changes, the opponent's strategy is unknown, and the 90-second clock doesn't care if you're confused. Instructions and course materials exist, but the problems are real and unsolved.

Schools and labs don't need to buy anything — rent the equipment for an event, run the competition, return it.

**Course materials are free.** Online courses covering how to build and modify the robots, write swarm scripts, and use LLMs as engineering copilots. Built from real classroom experience teaching 3D printing, signal analysis, and smart devices at Narva College Robotics (where students built accessories for Dobot MG400 industrial robots). Building arena bots is easier than that — cheaper hardware, simpler mechanics, more forgiving tolerances.

**Paid options for those who want them:**
- 1-on-1 mentoring sessions
- Live online classroom experience with instructor
- Teacher training courses (train-the-trainer, so schools can run events independently)

The goal: any teacher can pick up the free materials and run a competition. If they want hands-on support, it's available. If not, everything they need is in the course and the open-source repo.

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

---

## Why Cooperation Wins

MechArena is a proof of concept for rational cooperation in competitive environments.

In a prisoner's dilemma, the temptation is to hoard your best strategy. But in a 90-second match with open-source code, shared datasets, and a living tech tree — there's more to gain by sharing your solution with everybody than by hoping your secret sauce stays secret.

**A rising tide lifts all ships.** When you share a technique, the whole meta evolves. When you hoard it, you peak for one tournament and fall behind when others independently discover it anyway. Nobody peaks forever. In the long run, cooperation always wins.
