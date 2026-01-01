# League Management

**Purpose:** The sports league infrastructure that standardizes 2v2 swarm robotics competition, enabling dataset comparability and franchise growth.

## What This Is

Event sanctioning, media generation, sponsor relationships, rule sets, and educational programs. The organizational layer that makes Robot Arena a legitimate sport with consistent formats across all sanctioned events.

## Competition Format (Standardized Across All Events)

### 2v2 Team Swarm Competition

**Team Structure (4 Participants Total):**

**Team Red:**
- 1 Pilot: Commands 30-bot swarm via AI-assisted live coding
- 1 Hacker: Attempts to disrupt Team Blue's swarm via WiFi attacks

**Team Blue:**
- 1 Pilot: Commands 30-bot swarm via AI-assisted live coding
- 1 Hacker: Attempts to disrupt Team Red's swarm via WiFi attacks

**Match Details:**
- 60 total bots (30 per team)
- 90-second rounds
- 3x3m arena with goal circles
- Victory: Team whose pilot has more bots in goal circles when time expires

**Why This Format:**
- **Dataset Comparability:** Standardized format enables cross-event performance analysis
- **Research Value:** Multi-agent coordination + adversarial attacks + human-AI collaboration
- **Industry Relevance:** Swarm strategies transfer to warehouse logistics, inspection, security
- **Educational Depth:** Pilots learn coordination, hackers learn IoT security

## Why League Structure Matters

Without standardization:
- Every event reinvents judging criteria
- Teams can't compare performance across events
- Dataset becomes incomparable (kills commercial value)
- Sponsors deal with fragmented, inconsistent branding
- Media quality varies wildly
- Knowledge capture is haphazard

With league structure:
- 2v2 format replicates reliably worldwide
- Rankings and progression become meaningful
- Dataset remains comparable (essential for licensing)
- Sponsors get consistent, professional exposure
- Media templates ensure quality (60-camera YouTube uploads)
- Documentation standards enable Knowledge Commons growth

## Core Components

### `/events/`
Event sanctioning and franchise management:
- **Sanctioning criteria:** What makes an official Robot Arena event
- **Franchise agreements:** Revenue splits, quality standards, branding requirements
- **Event calendar:** Coordination to avoid conflicts, build toward championships
- **Judging standards:** Training materials, certification for judges
- **Challenge scenarios:** Warehouse logistics, infrastructure inspection, swarm coordination, disaster response analogs

### `/media/`
The content engine that funds everything:
- **Media templates:** Graphics, video formats, social media standards
- **Hashtag architecture:** How content gets discovered and aggregated
- **Broadcast standards:** Livestreaming requirements, camera placements
- **Content licensing:** How sponsors can repost participant content
- **Highlight production:** Post-event content packages

### `/sponsors/`
Sponsor relationships and value delivery:
- **Sponsor tiers:** What each level gets (reposting rights, talent access, branding)
- **Pitch materials:** How to sell sponsorship value
- **Sponsor onboarding:** Integration into events and content
- **ROI reporting:** Demonstrating value to retain sponsors
- **Industry targeting:** Logistics, manufacturing, automation companies who benefit from talent pipeline

### `/rulesets/`

Competition rules and technical standards for 2v2 swarm format:

**Platform Specifications (SMARS Base, Phase 1)**

**Required Components:**
- **Chassis:** SMARS-compatible footprint (fits in 10cm cube when idle)
- **Controller:** M5 Atom or equivalent ESP32 running MicroPython
- **Camera:** M5Stack Camera or equivalent 640x480@30fps
- **Power:** Self-contained battery, no tethers
- **Communication:** WiFi only (no Bluetooth, LoRa, etc.)
- **Weight:** Maximum 200g per bot
- **Cost:** ~€50/bot from standard suppliers (AliExpress, Mouser)

**Modifications Permitted:**
- ✅ Motor upgrades (stronger, faster, within weight limit)
- ✅ Wheel/track changes (better traction, maneuverability)
- ✅ Sensor additions (IR, ultrasonic, IMU—must stay under 200g)
- ✅ Custom 3D printed parts (structure, mounts, armor)
- ✅ Firmware modifications (custom triggers, optimized code)
- ✅ Power distribution tweaks (voltage regulation, efficiency)

**Modifications Prohibited:**
- ❌ Non-WiFi communication (defeats hacker role security research)
- ❌ Non-ESP32 controllers (must run MicroPython for compatibility)
- ❌ Offensive mechanisms (no weapons, pushing/blocking only)
- ❌ Exceeding weight/size limits (unfair advantage)

**Documentation Requirement:**
- All modifications must be uploaded to Knowledge Commons within 1 week of competition
- CAD files, BOM changes, firmware diffs required for sanctioned events
- Successful mods may be integrated into rental fleet designs (credited)

**Competition Divisions (By Arena Scenario, Not Skill Level)**

Divisions are based on arena scenarios, not participant skill. All participants (from Order of Fractured Gear beginners to Order of Twin Sparks advanced) can compete in any division. Divisions test different aspects of swarm coordination.

**Division 1: Open Arena**
- **Arena:** Flat 3x3m surface, two goal circles (1.5m diameter each)
- **Objective:** Maximum bots in your team's goal circle at 90 seconds
- **Bots:** Standard SMARS, custom modifications, OR resurrected robots (Roomba, RC car, etc.)
- **Research Value:** Pure coordination strategies, formation optimization
- **Industry Analog:** Warehouse floor space optimization
- **Order Participation:** All Orders welcome (Fractured Gear to Twin Sparks)

**Division 2: Obstacle Course**
- **Arena:** 3x3m with barriers, ramps, narrow passages
- **Objective:** Navigate obstacles to reach goal circles
- **Bots:** Requires mobility upgrades (better motors, tracks) - resurrected Roombas often excel here
- **Research Value:** Pathfinding, collision avoidance, adaptive formation
- **Industry Analog:** Infrastructure inspection (pipes, tunnels, debris)
- **Order Participation:** Ascendant Coil and above recommended (requires custom mods)

**Division 3: Multi-Level Arena**
- **Arena:** 3x3m with elevated platforms, ramps between levels
- **Objective:** Control high-ground positions (worth 2x per bot)
- **Bots:** Requires climbing capability, IMU sensors for stability (Advanced Awakening Module)
- **Research Value:** Vertical coordination, risk/reward strategy
- **Industry Analog:** Multi-floor warehouse logistics, construction site coordination
- **Order Participation:** Ascendant Coil and above (technical modifications required)

**Division 4: Dynamic Environment**
- **Arena:** 3x3m with moving obstacles, changing terrain (controlled by arena)
- **Objective:** Adapt to unpredictable conditions in real-time
- **Bots:** Requires advanced sensors, robust firmware
- **Research Value:** Real-time adaptation, sensor fusion
- **Industry Analog:** Disaster response, agricultural field navigation
- **Order Participation:** Twin Sparks recommended (cutting-edge strategies)

**Hacker Division (Consistent Across All Arena Divisions):**
- **Order:** Zero-State Eye (dedicated hacker track)
- **Role:** Attack opposing team's swarm during all matches
- **Ranking:** Based on effectiveness across all division levels
- **Purpose:** IoT security research, improve swarm resilience
- **Prize Pool:** €2500 + cybersecurity industry placement assistance
- **Recognition:** Most effective attacks documented in Knowledge Commons
- **Sigil:** Horizontal oval eye with single pixel center (awareness emerging from nothing)

**Safety Requirements:**
- No sharp edges or projectiles
- Emergency stop capability (all bots must respond to arena kill switch)
- Battery safety (LiPo bags required for charging)
- Arena containment (bots must not escape 3x3m boundary)

### `/education-programs/`

The educational scaffold that creates genuine learning through collaborative discovery in 2v2 swarm robotics:

**The Core Shift: Fellow Searchers, Not Answer-Dispensers**

Nobody knows the optimal swarm strategy in advance. Teachers aren't experts dispensing knowledge—they're fellow searchers exploring alongside students. This fundamentally changes classroom dynamics from "guess what I'm thinking" to "let's figure this out together."

**The Critical Skill: Navigating Uncertainty with AI**

In the modern world, the essential capability is critical thinking in domains where you're not an expert. LLMs confidently hallucinate. Videos present opinions as facts. Forums mix insight with nonsense. The person who can't distinguish between these loses days chasing false leads—something a 15-second verification could have prevented.

Robot Arena develops this skill through physical feedback: the swarm either coordinates or it doesn't. No amount of confident AI explanation changes whether 30 bots reach the goal. Students learn to:
- Cross-reference AI code suggestions against physical robot behavior
- Verify claims before deploying to entire swarm
- Recognize when they're lost and need to step back
- Document what actually worked vs. what "should have" worked
- Use AI as a coding partner (not oracle) during 90-second rounds

**Learning Pathways**

**Pathway 1: Pilot Training (Swarm Coordination)**
- **Phase 1:** Control 1 bot via button interface (forward, turn, stop)
- **Phase 2:** Control 3 bots simultaneously (formation basics)
- **Phase 3:** Control 10 bots with AI-assisted coding (Claude Code, ChatGPT)
- **Phase 4:** Control 30 bots in 90-second competitive rounds
- **Skills:** Multi-agent coordination, real-time adaptation, AI collaboration
- **Outcome:** Participants can pilot full swarms in competition

**Pathway 2: Hacker Training (IoT Security)**
- **Phase 1:** WiFi basics (monitor mode, packet capture)
- **Phase 2:** Deauth attacks (disrupt bot communication)
- **Phase 3:** Packet injection (send fake commands)
- **Phase 4:** Protocol exploitation (find vulnerabilities in swarm coordination)
- **Skills:** Network security, ethical hacking, defense strategy
- **Outcome:** Participants can attack/defend swarms, contribute to security research

**Pathway 3: Builder Training (SMARS Customization)**
- **Phase 1:** Assemble stock SMARS bot from kit
- **Phase 2:** Modify one subsystem (motors, wheels, sensors)
- **Phase 3:** Design custom 3D printed parts (armor, mounts, structures)
- **Phase 4:** Optimize firmware (faster response, better triggers)
- **Skills:** Mechanical design, electrical integration, firmware development
- **Outcome:** Participants can build custom fleets, contribute mods to Knowledge Commons

**School Programs**

**Middle School (Ages 11-14):**
- **Format:** 6-week club using rental bots (3 bots per team)
- **Focus:** Pilot Pathway Phase 1-2 (button control, basic formations)
- **Outcome:** School tournament with 6-bot matches (3v3)
- **Cost:** €200/school (rental + instructor guide)
- **Revenue:** Funded by local sponsors + Knowledge Commons contribution credit

**High School (Ages 14-18):**
- **Format:** Semester-long course, hybrid rental + build approach
- **Focus:** All three pathways (pilot, hacker, builder)
- **Outcome:** Regional competition with full 60-bot 2v2 matches
- **Cost:** €500/school (rental fleet + build kits for 6 students)
- **Revenue:** Funded by industry sponsors (talent pipeline access)

**University Programs:**
- **Format:** Semester course with research component
- **Focus:** Advanced strategies, custom firmware, novel attack vectors
- **Outcome:** Academic paper + Knowledge Commons contribution (free dataset access)
- **Cost:** Free (sponsored by research grants + licensing revenue)
- **Revenue:** Dataset licensing to industry, academic citations

**Corporate Workshops**

**Team Building (3-4 hours):**
- **Format:** Teams of 4 (2 pilots + 2 hackers) compete in novel arenas
- **Equipment:** Rental fleet + custom arena scenario
- **Outcome:** Content generation (photos, videos, testimonials)
- **Cost:** €2000-5000 depending on customization
- **Revenue:** Direct corporate sales

**Industry Training (2-day intensive):**
- **Format:** Warehouse logistics, inspection swarm, security scenarios
- **Equipment:** Custom arena matching industry application
- **Outcome:** Proof-of-concept strategies for real deployment
- **Cost:** €10k-20k (custom arena + consultation)
- **Revenue:** Direct B2B sales + potential dataset licensing

**Online Courses (Free, Sponsor-Supported)**

**Pilot Course:**
- **Duration:** 8 weeks, self-paced
- **Format:** Video tutorials + AI-guided coding exercises + simulator
- **Requirements:** No physical robots needed (simulation-based)
- **Sponsor Benefits:** Branding + talent pipeline access
- **Outcome:** Certificate + entry to online competition leaderboard

**Hacker Course:**
- **Duration:** 6 weeks, self-paced
- **Format:** WiFi security fundamentals + simulated attack scenarios
- **Requirements:** Laptop with WiFi adapter
- **Sponsor Benefits:** Cybersecurity industry branding + recruitment access
- **Outcome:** Certificate + contribution to security research documentation

**Builder Course:**
- **Duration:** 10 weeks, requires hardware
- **Format:** SMARS assembly guide + modification tutorials
- **Requirements:** SMARS kit (€50) or rental bot access
- **Sponsor Benefits:** Manufacturing/logistics industry branding
- **Outcome:** Custom bot design + Knowledge Commons contribution

**Learning Resources Repository**

**Video Library (YouTube, Free Forever):**
- Competition highlights (60-camera multi-view)
- Tutorial series (assembly, coding, hacking)
- Strategy breakdowns (what worked, what failed)
- Industry application case studies

**AI Tutor Integration:**
- Claude Code / ChatGPT integration guides
- Prompt templates for swarm coordination
- Common pitfalls and verification steps
- Real match transcripts (human-AI collaboration examples)

**Knowledge Commons Access:**
- Student tier: Free access to sanitized datasets
- Educator tier: Curriculum resources + assessment rubrics
- Researcher tier: Full datasets for academic use

## The Guild Structure: Decentralized Expansion

Robot Arena operates as a guild, not a traditional company. Event organizers (Mechanists and Archons) earn commissions by hosting competitions and selling Awakening Modules.

### Guild Ranks

**Initiates** (Individual Competitors)
- Purchase Awakening Modules or compete with rental/custom bots
- Contribute to Knowledge Commons (match data, resurrection guides, mods)
- Receive sigil tokens based on achievements (see Sigil System below)

**Mechanists** (Event Organizers)
- Host local Arena events (12-60 participants)
- Earn 20% commission on Awakening Module sales + 30% of ticket revenue
- Must successfully resurrect/compete with one robot to qualify
- Organize Ritual of Reassembly workshops for new participants

**Archons** (Regional Coordinators)
- Support Mechanists across geographic region
- Earn 5% override on regional module sales + volume bonuses
- Must organize 5+ events and train 3+ Mechanists to qualify
- Enforce safety standards and upload match data

**70% Retail Rule (Anti-Pyramid Safeguard):**
- Mechanists must earn 70% of income from sales to end-users (spectators, schools)
- Prevents garage-stockpiling and pure recruitment schemes
- Transparent income disclosure published annually (no hype, no "get rich" claims)

### The Sigil System

Orders represent different **approaches** to competitive swarm robotics, not skill levels. All Orders can compete in all divisions.

**⟡ Order of the Fractured Gear**
- **Approach:** Accept imperfection, learn through rental bots or first resurrection
- **Sigil:** Broken gear with seven fragments
- **Recognition:** Metal token after first successful match

**⟡ Order of the Ascendant Coil**
- **Approach:** Transform through modification (SMARS customs or successful resurrections)
- **Sigil:** Vertical coil rising through upward triangle
- **Recognition:** Knowledge Commons contributor access

**⟡ Order of the Twin Sparks**
- **Approach:** Unite old hardware with new intelligence (50cm custom platforms, major innovations)
- **Sigil:** Two dots connected by lightning
- **Recognition:** Priority dataset access

**⟡ Order of the Zero-State Eye**
- **Approach:** Hacker track, IoT security research
- **Sigil:** Horizontal oval eye with single pixel center
- **Recognition:** Cybersecurity industry placement assistance

## Revenue Streams

1. **Awakening Module sales:** €25k-500k/year (Year 1-3+, Guild distribution model)
2. **Franchise fees:** Percentage of local sponsorship from sanctioned events (10% of sponsor revenue)
3. **Rental packages:** €2000/weekend for 60-bot fleet + arena (15 events/year = €30k/fleet)
4. **Sponsor packages:** Industry access to content, talent pipeline, branding across all events (€50k-200k/year)
5. **Workshop licensing:** Corporate team building and industry training (€2k-20k per event)
6. **Championship events:** Major competitions with prize pools and YouTube streaming revenue
7. **Dataset licensing:** Knowledge Commons commercial tiers (revenue-threshold model)
8. **Educational programs:** School program fees (€200-500/school, sponsor-supported)
9. **Sigil merchandise:** Metal tokens, patches (€5k-15k/year at scale)

## Prize Structure Philosophy

**Multiple Recognition Paths (Not Winner-Takes-All):**

**Pilot Prizes (Per Division):**
- 1st Place: €1000 + commercial dataset access (1 year)
- 2nd Place: €500 + academic dataset access (1 year)
- 3rd Place: €250 + student dataset access (1 year)
- Best Formation: €200 (most innovative coordination strategy)
- Best Adaptation: €200 (fastest response to hacker attacks)

**Hacker Prizes (Across All Divisions):**
- Most Effective Attack: €1000 + cybersecurity industry placement assistance
- Most Creative Exploit: €500 + security research documentation credit
- Best Defense Contribution: €250 (findings that improve swarm resilience)

**Builder Prizes (Modification Competition):**
- Best Mobility Mod: €500 (fastest, most maneuverable)
- Best Sensor Integration: €500 (most effective additional sensing)
- Best Firmware Innovation: €500 (novel triggers, optimization)
- Community Choice: €250 (voted by other participants)

**Team Prizes (Combined Performance):**
- Championship Team (Best Pilot + Hacker Combo): €2500 split
- Rising Stars (Best New Team): €1000 split
- Knowledge Commons Hero: €500 (best documentation contribution)

**Why This Structure:**
- Teams can win without being overall champions (keeps engagement high)
- Diverse solution space (coordination vs. speed vs. resilience)
- Documentation incentivized (prizes for contributions)
- Hacker role valued equally (security research gets recognition)
- Builder innovation rewarded (successful mods get integrated)
