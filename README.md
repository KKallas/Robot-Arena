# Robot Arena
Business infrastructure for engineers

## What Is Robot Arena?

**Robot Arena is an autobattler sport where pilots upload swarm scripts, then watch 30 bots fight autonomously for 90 seconds.**

Think auto chess meets robotics. Two teams face off: each has a Pilot (who prepared swarm behavior scripts) and a Hacker (who prepared WiFi disruption scripts). Once the match starts, nobody touches anything—the bots execute their uploaded code autonomously. The team with more bots in goal circles when time expires wins.

**The autobattler format:** No real-time control. Pilots use AI copilots (Claude, ChatGPT) to write and test scripts *before* the match. During the 90-second match, they can only watch. This captures the full AI-assisted development process—the prompts, iterations, debugging—not just the final result.

**The actual product:** Match data. Every 90-second match generates:
- Complete development timeline (pilot-AI conversation during script preparation)
- All bot positions and movements (4Hz sampling from simulator, 10Hz from physical)
- WiFi attack patterns (pre-programmed hacker disruptions)
- Match outcome tied to strategies used

This data trains the next generation of AI systems for physical-world automation.

---

## How It Works: The Sport

### The Match Format (Autobattler)

**Preparation phase (unlimited time before match):**
- Pilots use AI copilots to write swarm behavior scripts
- Test in simulator (identical physics to physical arena)
- Iterate, debug, optimize
- Upload final scripts to bots

**Execution phase (90 seconds, no intervention):**
- Timer starts, bots execute uploaded scripts autonomously
- No pilot input allowed during match
- Hackers' pre-programmed WiFi attacks trigger automatically
- Everyone watches the outcome

**Arena:** 3m × 3m floor with goal circles at each end

**Teams:** Team Red vs Team Blue
- 1 Pilot per team (prepared 30-bot swarm scripts)
- 1 Hacker per team (prepared WiFi disruption scripts)
- 60 total bots on field

**Victory condition:** Most bots in opponent's goal circle when timer hits zero

**The Bots:** €50 open-source SMARS robots (3D-printable) running MicroPython on ESP32
- M5 Atom controller + M5Stack Camera
- WiFi-only communication (no mesh, no LoRa)
- Pilots modify firmware, hardware, sensors within spec limits

### Why Autobattler Format

**Captures the full development process:** Real-time control only shows the final commands. Autobattler captures the entire AI-assisted scripting process—every prompt, every iteration, every debugging session.

**Deterministic replays:** Same scripts + same initial conditions = same outcome. Anyone can verify results by re-running in simulator.

**Real physical consequences:** If the script has bugs, bots crash into each other. If WiFi defense scripts are weak, hacker takes over your swarm. The preparation matters.

**Captures human-AI collaboration patterns:**
- What prompts generate reliable swarm code?
- How do pilots iterate with AI feedback?
- When do they trust AI suggestions vs override?
- How do they debug unexpected behavior?

**This development process data is worth €50k-500k/year to companies building AI coding assistants.**

---

## The Business Model: Three Products

### Product 1: Social Media Content (Sponsors Pay)

**Every match generates unlimited promotional material:**
- 60 camera angles (every bot has a camera)
- 90-second format = perfect for TikTok/Reels/Shorts
- Real competition = authentic stories (not staged)
- Pilots share their POV clips organically

**Sponsor packages (€100k+/year):**
- Content library access (download any angle, any match, license for own channels)
- Logo placement on arena + bots (appears in all participant content)
- Distributed micro-influencer network (every pilot is a content creator)
- Authentic STEM/youth market engagement

**Why sponsors pay:** Traditional content production costs €5k-20k per video. Robot Arena generates unlimited clips from single sponsorship. Cost per impression crushes paid media.

### Product 2: Match Datasets (Researchers/Companies Buy)

**What gets captured (Timeline Event Storage):**

**Preparation phase log** (before match):
```
timestamp,event_type,executed_by,data
0,session_start,system,pilot=red_pilot
1234,pilot_prompt,user,write a script that makes bots surround the goal
2891,ai_response,ai,Here's formation_surround.py...
5000,pilot_prompt,user,the bots are bunching up, add spacing
6200,ai_response,ai,Updated with 0.3m minimum distance...
12000,test_run,simulator,formation_surround.py|result=success
...
```

**Match phase log** (during 90-second execution):
```
timestamp,event_type,executed_by,data
0,match_start,system,red_vs_blue
100,bot_position,bot_01,x=0.5|y=1.2|vx=0.1|vy=0.0
100,script_event,formation_surround.py,target_acquired|goal_circle
...
90000,match_end,system,winner=red|score=18-12
```

**Plus per-drone logs (downloaded after match from ESP32 storage):**
- Every motor command executed
- Every sensor reading
- WiFi packet counters
- Script execution traces

**Why valuable:** Same format as chess game logs (PGN files). AI companies can:
- Train models on real human-AI collaboration under pressure
- Test algorithms against adversarial WiFi attacks
- Validate swarm coordination strategies with physical outcomes

**Licensed access:**
- Academic: Free (with citation)
- Per-Match: €50
- Season: €10k/year
- Commercial: €50k-500k/year (includes simulator training rights)

### Product 3: Hardware Rental/Sales (Cash Flow)

**Rental model:**
- Schools: €500/semester (training fleet)
- Events: €2000/weekend (60-bot competition package + arena)
- Corporate: €1400/day (team building with custom scenarios)

**Sales model:**
- Awakening Modules: €50 (ESP32 retrofit kit for obsolete robots)
- SMARS kits: €50/bot (BOM cost, open-source design)
- School packages: €300 (6-bot starter kit + curriculum)

**Guild distribution (MLM-style but with safeguards):**
- Mechanists (event organizers): 20% module sales + 30% ticket revenue
- Archons (regional coordinators): 5% override + volume bonuses
- 70% retail rule: Must earn 70% from end-users, not recruitment
- Transparent income disclosure published annually

---

## How It's Operated: Decentralized + Open Source

### Manufacturing (Open Source Hardware)

**SMARS platform:** Fully open-source, 3D-printable robot chassis
- STL files on GitHub (free)
- Bill of Materials: €50 (AliExpress/Mouser)
- Assembly guide + firmware (MicroPython for ESP32)

**Anyone can manufacture:**
- Schools 3D print their own fleets
- Hobbyists build custom modifications
- Event organizers bulk-order for rentals
- Commercial partners produce at scale

**No licensing fees. No proprietary lock-in. Just open hardware specs.**

### Event Organization (Guild Structure)

**Initiates (Competitors):**
- Build or rent bots
- Compete in matches
- Upload strategies to Knowledge Commons (GitHub)
- Earn XP through tech tree progression

**Mechanists (Local Event Organizers):**
- Host tournaments (12-60 participants)
- Rent arena packages or build own
- Earn 20% on Awakening Module sales + 30% ticket revenue
- Must successfully compete with one robot to qualify

**Archons (Regional Coordinators):**
- Support 3+ Mechanists in region
- Enforce safety standards
- Upload match data to Knowledge Commons
- Earn 5% override on regional sales

**No central control.** Each event runs independently, uploads data to shared GitHub repository.

### Data Collection (Automated Pipeline)

**During match (live):**
- Pilot UI logs commands to events.csv
- AI copilot logs responses to events.csv
- Each bot reports position every 100ms to events.csv
- WiFi monitor logs attacks to events.csv
- All timestamped in milliseconds

**After match:**
- Script downloads internal logs from all 20 bots (ESP32 flash storage)
- Single git commit: events.csv + 20 per-drone logs + metadata + YouTube URL
- Push to match repository
- Public access (free) or licensed access (commercial)

**No manual curation needed.** System captures everything automatically.

---

## The Dataset Economy: Like Chess but for Robots

**Chess analogy:**
- Chess games recorded in PGN format (Portable Game Notation)
- Millions of games publicly available
- AI trained on decades of grandmaster matches
- Anyone can study Kasparov vs Deep Blue move-by-move

**Robot Arena equivalent:**
- Matches recorded in CSV timeline format
- Every pilot-AI interaction captured with millisecond timestamps
- AI trained on real physical swarm coordination under adversarial conditions
- Anyone can study how winning pilots use AI copilots

**Timeline Event Format (Universal):**

Four fields: `timestamp,event_type,executed_by,data`

- **timestamp:** Milliseconds since match start
- **event_type:** Category (pilot_input, ai_response, bot_position, wifi_event, match_event)
- **executed_by:** Who initiated (user, ai, script_name, system, bot_id)
- **data:** Event-specific info (pipe-separated values)

**The executed_by field is the key innovation:**
Tracks decision authority at every moment. Dataset buyers analyze:
- When pilots trust AI vs override manually
- AI response latency tolerance
- Automation handoff patterns
- Rejection behavior under pressure

**Playback system (like chess replay):**
- Flask + HTML browser loads events.csv
- Filter by timestamp (scrub timeline)
- Filter by event type (show only pilot commands, or only WiFi attacks)
- Sync with YouTube video of match
- Export filtered data for analysis

**Post-match access:**
- Live timeline (events.csv) available immediately
- Per-drone logs (downloaded from ESP32s) for deep debugging
- Simulator trained on per-drone logs validates dataset quality

---

## Virtual Arena Simulator: Dataset Quality Validation

**The value proposition:** Simulator trained on real matches predicts physical outcomes with 85%+ accuracy. This proves dataset captures real swarm physics, not noise.

**The validation loop:**
```
Physical Matches → Timeline Events → Build Collision LUT → Sim Matches → Compare to Physical → Publish Accuracy Metrics
```

**What it is (feasible for one person):**
- Mac Mini M4 running Python game server (60 bots @ 4Hz updates)
- **Blender** (offline rendering) - fully open source, scriptable
- **Autobattler format** - 90-second matches, no operator interference
- Writes identical events.csv format as physical matches
- Same MicroPython code runs in simulator as on ESP32s
- Collision LUT built from real recorded world data

**Game server architecture (no physics engine):**
- **Cluster detection:** identify bots that are close and need to react
- **Position prediction:** use current position + motion vectors
- **Collision LUT:** lookup similar path collections from recorded data

**Autobattler format:**
- 90-second matches with no operator interference during match
- LLM helps prepare Python package to upload and command drones
- Packages are signed and queued for batch processing
- Strategy generation "on the go" is future enhancement

**Why offline/batch processing:**
- Matches can be prepared, signed, and queued for non-realtime simulation
- Scalability for limited compute resources
- Multiple matches rendered sequentially on single machine
- Open source stack (Blender + Python) = anyone can audit or contribute

**Why it matters:**
- Online competitions (global participation, no hardware needed)
- Schools practice in simulator before renting physical fleet
- Dataset buyers see validation metrics before purchasing
- If simulator predicts accurately → dataset captures real physics

---

## Revenue Streams (Diversified)

1. **Sponsor packages:** €50k-200k/year (content library access, logo placement, talent pipeline)
2. **Dataset licensing:** €50k-500k/year (commercial AI training rights)
3. **Hardware rental:** €30k/year per fleet (15 events/year × €2000)
4. **Awakening Module sales:** €25k-500k/year (guild distribution model)
5. **Workshop licensing:** €2k-20k per corporate event
6. **Championship events:** Prize pools funded by sponsors, YouTube revenue
7. **Educational programs:** €200-500/school (sponsor-supported)
8. **Virtual competitions:** €10-20 entry fees, €10/month subscriptions

**Total addressable:** €200k-1.5M/year by Year 3 (Estonia pilot)

---

## Why Estonia?

**Estonia doesn't manufacture robots. Estonia synthesizes global knowledge and applies it locally.**

**Specific advantages:**
- Digital infrastructure + small population = need for automation
- E-residency + cybersecurity expertise = hacker role development
- Small scale = rapid municipal pilot deployment
- Automation pressure = economic need for swarm robotics solutions

**The strategy:**
When a pilot in Mumbai discovers a 15-bot decoy formation, or Brazil develops WiFi attack resistance, or Singapore finds AI prompting patterns that generate reliable swarm code—all flows into the Knowledge Commons. Estonian companies synthesize these strategies and apply them to Port of Tallinn inspections, rainwater pipe maintenance, bridge monitoring.

**The sport becomes massively distributed R&D for physical AI.**

---

## Three Pillars (Project Structure)

### 1. Knowledge Commons (`01-knowledge-commons/`)
Open-source repository for match data, strategies, hardware designs
- Public dataset preview (all matches on YouTube, sanitized logs)
- Resurrection Archive (obsolete robot retrofit guides)
- Bounty Marketplace (pooled funding for shared R&D problems)

### 2. Logistics Operations (`02-logistics-operations/`)
Hardware rental, manufacturing coordination, Awakening Module distribution
- Rental fleet management
- Guild commission structure
- School/event packages

### 3. League Management (`03-league-management/`)
Sports league infrastructure and media production engine
- Event production quality (lighting, cameras, arena aesthetics)
- Auto-editing highlights pipeline
- Sponsor relationship management
- Autonomous governance (LLM-based decision system)

---

## Competition Format Details

**Match Structure:**
- 90-second rounds
- 2v2 teams (Pilot + Hacker per team)
- 60 bots total (30 per team)
- 3m × 3m arena
- Goal: Most bots in opponent's circle when time expires

**The Platform:**
- SMARS chassis (open-source, 3D-printable)
- M5 Atom (ESP32) + M5Stack Camera
- WiFi-only communication
- MicroPython firmware
- €50/bot build cost

**Entry Pathways:**
1. **Rental:** Show up, pay €50-100, compete same day
2. **Builder:** 3D print fleet at home, customize within spec
3. **Resurrection:** Retrofit obsolete robots with €50 Awakening Module
4. **Hybrid:** Own some bots, rent the rest

**Why This Format:**
- Forces AI copilot use (30 bots in 90 seconds impossible manually)
- Captures human-AI collaboration under time pressure
- Adversarial WiFi attacks test real-world resilience
- Strategies transfer to warehouse logistics, inspection, security

---

## The Board: Four Guild Markets

**The Board is Robot Arena's unified crowdfunding platform with four specialized markets.** Think Kickstarter meets skill progression: post challenges, sponsor teams, share hardware designs, unlock techniques. Your rating on each guild determines tournament eligibility.

**⟡ Skills Guild (Bronze Fractured Gear)**
- Discover and unlock swarm robotics techniques
- Rating: Total XP + techniques unlocked
- Entry path: Compete with rental bot ("Imperfection is the beginning of mastery")

**⚡ Challenges Guild (Silver Lightning Bolt)**
- Fund specific technical problems (bounties)
- Rating: Bounties completed + difficulty solved
- Entry path: Hacker track, solving technical challenges ("Solutions emerge from pressure")

**⚙ Hardware Guild (Gold Ascending Coil)**
- Retrofit and customize obsolete robotics
- Rating: Resurrections completed + remix count
- Entry path: Modify SMARS or resurrect obsolete hardware ("Resurrection through transformation")

**⭐ Sponsorship Guild (Platinum Twin Sparks)**
- Match teams with funding
- Rating: Team win rate + sponsor ROI + content reach
- Entry path: Elite performance or 100+ remixes ("Unity between old hardware and new intelligence")

**All guilds compete together.** Most pilots are members of multiple guilds. Tournament filters use guild ratings (e.g., "Expert tier only" or "€2k+ backing required").

See [THE-BOARD.md](THE-BOARD.md) for complete details.

---

## Core Philosophy

"What is broken can be reborn. What is obsolete can evolve."

**The Ise Shrine Model:** Since 690 CE, Japan's Ise Grand Shrine has been rebuilt every 20 years to preserve knowledge through the act of rebuilding. Robot Arena applies this to engineering: every Roomba retrofitted, every SMARS bot modified, every swarm strategy documented. The machines evolve. The skills persist.

**Education masquerading as entertainment.** Questions first, solutions second. Engineers avoid financial and social problems. We solve business, marketing, and monetization so engineers can focus on building and optimizing.

---

For detailed technical architecture, see [ARCHITECTURE.md](ARCHITECTURE.md).

For timeline event storage specification, see [TIMELINE-ARCHITECTURE.md](TIMELINE-ARCHITECTURE.md).

For autonomous governance system, see [03-league-management/README.md](03-league-management/README.md).
