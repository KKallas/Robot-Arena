# Robot Arena
Business infrastructure for engineers

## What Is Robot Arena?

**Robot Arena is a competitive robotics sport where pilots command 30-bot swarms in 90-second matches.**

Think chess + esports + industrial automation. Two teams face off: each has a Pilot (controlling their swarm via AI-assisted coding) and a Hacker (disrupting the opponent's WiFi). The team with more bots in goal circles when time expires wins.

**Why 90 seconds?** Forces pilots to use AI copilots (Claude, ChatGPT) to manage 30 bots. Manual control is impossible. The sport captures human-AI collaboration under extreme time pressure—data that doesn't exist anywhere else.

**The actual product:** Match data. Every 90-second match generates:
- Complete timeline of pilot-AI conversation (commands, responses, latency)
- All bot positions and movements (10Hz sampling)
- WiFi attack patterns (hackers disrupting communications)
- Match outcome tied to strategies used

This data trains the next generation of AI systems for physical-world automation.

---

## How It Works: The Sport

### The Match (90 Seconds)

**Arena:** 3m × 3m floor with goal circles at each end

**Teams:** Team Red vs Team Blue
- 1 Pilot per team (commands 30-bot swarm)
- 1 Hacker per team (attacks opponent's WiFi)
- 60 total bots on field

**Victory condition:** Most bots in opponent's goal circle when timer hits zero

**The Bots:** €50 open-source SMARS robots (3D-printable) running MicroPython on ESP32
- M5 Atom controller + M5Stack Camera
- WiFi-only communication (no mesh, no LoRa)
- Pilots modify firmware, hardware, sensors within spec limits

### Why This Format Is Unique

**Impossible to control manually:** 30 bots in 90 seconds = ~3 seconds per bot. Pilots MUST use AI copilots to generate swarm commands, upload scripts, coordinate formations.

**Real physical consequences:** If AI response is slow or wrong, bots crash into each other. If WiFi defense fails, hacker takes over your swarm. Pressure is real.

**Captures human-AI trust patterns:**
- When does pilot wait for AI vs override manually?
- What prompts generate reliable swarm code?
- How do pilots recover when AI fails?

**This behavioral data under time pressure is worth €50k-500k/year to companies building AI copilots.**

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

Single CSV file per match with millisecond timestamps:
```
timestamp,event_type,executed_by,data
0,match_start,system,red_vs_blue
1234,pilot_input,user,surround the goal
2891,ai_response,ai,Uploading formation_surround.py to bots 1-30
2891,bot_position,bot_01,x=0.5|y=1.2|vx=0.0|vy=0.0
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
Physical Matches → Timeline Events → Train Simulator → Sim Matches → Compare to Physical → Publish Accuracy Metrics
```

**What it is (feasible for one person):**
- Mac Mini M4 running Python game engine (60 bots @ 4Hz physics)
- Writes identical events.csv format as physical matches
- Same MicroPython code runs in simulator as on ESP32s
- ML collision model trained offline on per-drone logs
- Unreal Engine 5 interpolates positions to 60fps for smooth rendering
- 2 video streams (top-down + bot POV)

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

## Orders System (Progression Tracks)

**⟡ Order of the Fractured Gear**
- Entry: Compete with rental bot
- Philosophy: "Imperfection is the beginning of rebirth"
- XP: bout +1, win +3, knowledge contribution +2

**⟡ Order of the Ascendant Coil**
- Entry: Modify SMARS bot OR resurrect obsolete hardware
- Philosophy: "Resurrection through transformation"
- XP: bout +1, win +3, knowledge contribution +4

**⟡ Order of the Twin Sparks**
- Entry: Win Ascendant competition OR 100+ remixes of your contribution
- Philosophy: "Unity between old hardware and new intelligence"
- XP: bout +1, win +5, knowledge contribution +4

**⟡ Order of the Zero-State Eye**
- Entry: Stop or take over 10 enemy units in single match (hacker track)
- Philosophy: "Awareness emerging from nothing"
- XP: bout +1, win +2, knowledge contribution +10

**All Orders compete together.** No skill-based divisions, just different approaches to the sport.

---

## Core Philosophy

"What is broken can be reborn. What is obsolete can evolve."

**The Ise Shrine Model:** Since 690 CE, Japan's Ise Grand Shrine has been rebuilt every 20 years to preserve knowledge through the act of rebuilding. Robot Arena applies this to engineering: every Roomba retrofitted, every SMARS bot modified, every swarm strategy documented. The machines evolve. The skills persist.

**Education masquerading as entertainment.** Questions first, solutions second. Engineers avoid financial and social problems. We solve business, marketing, and monetization so engineers can focus on building and optimizing.

---

For detailed technical architecture, see [ARCHITECTURE.md](ARCHITECTURE.md).

For timeline event storage specification, see [TIMELINE-ARCHITECTURE.md](TIMELINE-ARCHITECTURE.md).

For autonomous governance system, see [03-league-management/README.md](03-league-management/README.md).
