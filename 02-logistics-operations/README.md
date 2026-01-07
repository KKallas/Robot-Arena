# Logistics Operations

**Purpose:** Build, rent, ship, and receive everything needed to run Robot Arena swarm competitions anywhere.

## What This Is

The hardware arm that enables the franchise model and funds the ecosystem. Any organization that wants to host a sanctioned 2v2 swarm competition shouldn't need to invest €30k+ in building 60-bot fleets and arena infrastructure from scratch. They rent it, run the event, generate dataset, return the equipment.

**The Business Model Sweet Spot:**
- **Pilots:** Can build own custom SMARS bots (€50 each) OR rent from event OR resurrect obsolete robots with Awakening Modules (€50)
- **Schools/Events:** Rent complete competition packages, focus on running great events
- **Rental Revenue + Module Sales:** Funds manufacturing next generation of fleets + operational sustainability
- **Dataset:** All matches (rental, owned, or resurrected bots) contribute to Knowledge Commons
- **Sustainability Narrative:** Resurrection path transforms e-waste into competitive advantage

---

## Core Functions

### Build
- Manufacture 60-bot SMARS swarm fleets (Phase 1, Years 1-2)
- Manufacture 60-bot custom platform fleets (Phase 2, Years 3+)
- **Produce Awakening Modules** (ESP32 retrofit kits for obsolete robot resurrection)
- Produce modular 3x3m arena systems with camera infrastructure
- Assemble pilot interface kits (screens, input devices, AI integration)
- Build hacker station packages (network monitoring, attack tooling)
- Maintain quality standards across all hardware

### Rent
- **Competition Packages:** Complete 60-bot fleet + arena for tournaments (€2k/weekend)
- **School Training Packages:** 12-24 bot fleets for semester-long programs (€500/semester, subsidized)
- **Corporate Workshop Kits:** Turnkey team-building experiences (€5k/day, includes facilitation)
- **Research Lab Packages:** Controlled experimentation setups (custom pricing)

### Ship
- Logistics coordination for event hardware (domestic and international)
- Modular packaging for bot fleets (pelican cases, charging infrastructure)
- Arena component shipping (lightweight, flat-pack design)
- Tracking and scheduling systems (avoid double-booking, optimize routes)
- Customs documentation for cross-border movement (EU expansion Year 2+)

### Receive
- Post-event equipment return processing
- Damage assessment and repair (bots get damaged, plan for 10-15% attrition)
- Battery maintenance and replacement
- Firmware updates and calibration
- Inventory reconciliation
- Refurbishment pipeline (integrate successful custom mods into rental fleets)

---

## Components

### `/fleet-designs/`

**Phase 1: SMARS Swarm Fleets (Years 1-2)**
- **60-bot competition fleet:** Complete SMARS builds with M5Stack Camera + M5 Atom
- **Cost per fleet:** €3k hardware + €1k labor/assembly = €4k total
- **Rental rate:** €2k/weekend → breakeven at 2 events, profit after
- **Spares inventory:** 20% spare bots (12 extra) for quick replacement
- **Charging infrastructure:** 60-bot charging station, 2-hour full charge cycle
- **Transport cases:** Stackable pelican cases, each holds 10 bots

**Phase 2: Custom Platform Fleets (Years 3+)**
- **60-bot competition fleet:** 50cm weatherproof platforms with modular attachments
- **Cost per fleet:** €18k hardware + €3k labor/assembly = €21k total
- **Rental rate:** €3-4k/weekend → breakeven at 6-7 events
- **Outdoor capability:** Enables Year 3+ industry-relevant scenarios
- **Modular tooling:** Grippers, sensors, cleaning attachments for specific challenges

### `/awakening-modules/`

**Philosophy:** "What is broken can be reborn. What is obsolete can evolve."

The Awakening Module product line enables participants to resurrect obsolete robots (Roomba 500 series, RC cars, broken toys, failed kickstarter robots) and compete alongside SMARS fleets. This creates a sustainability narrative, lowers entry barriers, and generates viral content ("saving robots from e-waste").

**Base Module (€50 retail, €30 COGS, €20 margin):**
- **Components:**
  - ESP32 dev board (M5 Atom or equivalent)
  - M5Stack Camera module (640x480@30fps)
  - Power distribution board (voltage regulation, battery management)
  - MicroPython firmware pre-loaded (HTTP API compatible with arena system)
- **Packaging:**
  - Quick-start guide with photos for 5 common obsolete robots (Roomba, RC car, robotic vacuum, toy tank, broken drone)
  - Wiring diagram card (laminated, waterproof)
  - QR code linking to Knowledge Commons Resurrection Archive
  - Metal sticker: "Reawakened by Robot Arena"
- **Use Cases:**
  - Individual pilots resurrecting home robots for practice
  - Schools using e-waste for educational sustainability projects
  - Events offering "Resurrection Workshops" (bring broken robot, leave with competitor)

**Advanced Module (€120 retail, €75 COGS, €45 margin):**
- **Everything in Base Module plus:**
  - IMU sensor (gyroscope + accelerometer for multi-level arenas)
  - Ultrasonic sensors (obstacle detection, collision avoidance)
  - Upgraded motors (if original robot motors insufficient)
  - Advanced mesh networking firmware (resilient to hacker attacks)
- **Use Cases:**
  - Serious competitors optimizing resurrected robots for advanced divisions
  - Research labs testing swarm coordination on heterogeneous platforms
  - Corporate workshops demonstrating IoT retrofit capabilities

**School Kit (€300 retail, €180 COGS, €120 margin):**
- **Components:**
  - 6× Base Awakening Modules
  - 8-week classroom curriculum (lesson plans, assessment rubrics, video tutorials)
  - Online instructor training (2-hour webinar, certification)
  - Optional: 6× SMARS chassis kits (if school doesn't have obsolete robots)
- **Use Cases:**
  - Middle schools (ages 11-14) running robotics clubs
  - High schools integrating into STEM curriculum
  - Makerspaces offering community workshops

**Guild Distribution Model:**
- **Direct Sales:** Available on website, shipped within EU
- **Mechanist Sales:** Event organizers earn 20% commission (€10 per Base Module sold at their events)
- **Archon Overrides:** Regional coordinators earn 5% on all module sales in their region (passive income for supporting local Mechanists)
- **70% Retail Rule:** Mechanists must earn 70% of income from sales to end-users (spectators, schools) before qualifying for recruitment bonuses

**Manufacturing:**
- **Assembly:** In-house (Tallinn facility) or contract manufacturer
- **Components:** Bulk purchase from AliExpress, Mouser (M5Stack official distributor)
- **Lead Time:** 2-week production run for 500 units
- **Inventory:** Keep 200 units in stock (fulfill within 48 hours), manufacture in batches of 500

**Marketing & Viral Potential:**
- **Before/After Videos:** "This Roomba was headed for the trash. Now it's an Arena champion."
- **Resurrection Challenges:** Quarterly competitions targeting specific obsolete platforms (prizes for successful conversions)
- **YouTube Series:** "Resurrecting Dead Robots" (step-by-step guides, failures, successes)
- **Sustainability Angle:** "E-waste to competitive advantage" (appeals to environmentally-conscious participants)

### `/arena-systems/`

**3x3m Modular Arena (Phase 1)**
- Lightweight aluminum frame (flat-pack for shipping)
- Overhead camera mount (captures all 60 bots)
- Goal circle markers (LED-lit, color-coded)
- Safety barriers (prevent bot escape)
- Assembly time: 2 hours by 2 people
- Disassembly time: 1 hour
- **Cost:** €2k per arena system
- **Rental:** Included in competition package

**Scenario-Specific Arenas (Phase 2, Years 3+)**
- Cave system mockup (GPS-denied navigation challenge)
- Warehouse layout (capture the flag with obstacles)
- Territory control grid (hold position challenge)
- Sequential cooperation course (button-pushing gates)
- **Cost:** €5-8k per specialized arena
- **Rental:** €500-1k additional fee beyond base package

### `/pilot-interfaces/`

**Pilot Station Package:**
- 32" monitor (arena overhead view + bot status)
- Input device (keyboard/mouse or custom controller)
- AI assistant integration kit (API tokens, local compute if needed)
- Pre-configured laptop with pilot software
- **Cost:** €1.5k per station (2 needed per event)
- **Rental:** Included in competition package

**Hacker Station Package:**
- Laptop with Wireshark, Aircrack-ng, Metasploit pre-installed
- WiFi adapter for packet capture
- Network traffic visualization display
- Attack script library (legally compliant, education-focused)
- **Cost:** €800 per station
- **Rental:** Included in competition package

### `/inventory/`

**Asset Tracking:**
- Each bot has unique ID (QR code, tracked in database)
- Fleet utilization metrics (how many events per year per fleet)
- Damage logs (which bots break most often, why)
- Battery cycle counts (replace after 200 charge cycles)
- Firmware versions (ensure all bots run same code for fairness)

**Maintenance Schedule:**
- **After every event:**
  - Visual inspection, charge all batteries
  - Verify UART logs uploaded to Knowledge Commons (automatic via WiFi)
  - Firmware update check (Arduino, M5 Atom, M5 Camera)
  - Clear SD card space on M5 Camera modules (logs auto-upload, then purge)
- **Monthly:** Deep clean, motor bearing check, sensor calibration
- **Quarterly:** Replace worn components (wheels, sensors), battery health test
- **Annually:** Full refurbishment, integrate successful custom mods from pilots

**Depreciation Planning:**
- SMARS fleets: 3-year lifespan (replaced by Phase 2 custom platform)
- Custom platform fleets: 5-year lifespan
- Arena systems: 5-year lifespan (minimal wear)
- Pilot/hacker interfaces: 3-year lifespan (technology refresh)

### `/shipping/`

**Carrier Relationships:**
- Domestic (Estonia): Omniva, DPD for within-country shipping
- EU: DHL, DB Schenker for cross-border events
- Volume discounts negotiated based on annual shipment count

**Packaging Specifications:**
- **Bot fleets:** Pelican cases (10 bots per case), stackable, TSA-approved locks
- **Arena systems:** Flat-pack boxes, lightweight aluminum, hand-carry poles/cables
- **Interface kits:** Backpack-style cases for laptops/monitors

**International Logistics:**
- EU customs: Carnet for temporary exports (avoid VAT on rentals)
- Insurance: Full replacement value coverage
- Tracking: Real-time GPS on high-value shipments (60-bot fleets)

### `/bounty-verification/`

**Purpose:** Arena-based verification for Knowledge Commons bounty marketplace submissions. Logistics Operations provides the physical testing infrastructure that ensures bounty submissions actually work under real competition conditions.

**The Two-Stage Verification Model:**

**Stage 1: Automated Validation (Distributed)**
- Bounty submissions include 3D printable test objects
- Anyone can verify: Download STL, print test object, run submission against it
- Example: Glass-washing bounty includes 1m² acrylic sheet + dirt pattern spray mask
- Submitter films their module cleaning the test object in required time
- GitHub PR with video evidence + reproducible setup

**Stage 2: Arena Demonstration (Centralized)**

Top 3 submissions from Stage 1 advance to Arena demonstration at next sanctioned event. This is where Logistics Operations is critical.

**Arena Verification Process:**

**Pre-Event Coordination (2 weeks before):**
- Archons contact top 3 submitters, confirm attendance
- Submitters ship modules to event location (or arrive with them)
- Logistics team prepares verification scenario (arena floor, obstacles, test conditions)
- Public announcement on YouTube: "Bounty demonstration at [event name], live judging"

**Day-of-Event Setup:**
- **Test Fleet:** 10 rental bots equipped with submitted modules
- **Test Scenario:** Arena floor configured to match bounty requirements
  - Example: Glass-washing bounty → 3m² acrylic panels in arena
  - Example: Stair-climbing bounty → modular ramp system in arena
  - Example: Mesh protocol bounty → active hacker attempting disruption
- **Judging Panel:** 3 judges (1 Archon, 1 technical expert, 1 industry sponsor)
- **Public Attendance:** Open to spectators, livestreamed on YouTube

**Demonstration Format (30 minutes per submission):**
1. **Assembly (10 min):** Submitter installs modules on 10 rental bots (tests ease of installation)
2. **Calibration (5 min):** Submitter runs calibration routine (tests setup complexity)
3. **Performance Test (10 min):** Bots execute bounty requirement (reliability, effectiveness)
4. **Judging (5 min):** Judges score on standardized rubric

**Judging Rubric (100 points total):**
- **Effectiveness (40 pts):** Does it accomplish the stated goal? (e.g., cleans glass to spec)
- **Reliability (30 pts):** What % of 10 bots successfully complete task?
- **Cost (15 pts):** Actual BOM vs. budget constraint (under = bonus, over = penalty)
- **Robustness (15 pts):** Works on multiple floor types / conditions tested on the spot

**Winner Announcement:**
- Scores tallied publicly, winner announced same day
- Prize pool distributed (70% first, 20% second, 10% third)
- All CAD files, assembly instructions, test results enter Knowledge Commons
- YouTube video: Full demonstration + judging commentary + winner interview

**Equipment Provided by Logistics:**
- 10 rental bots (standardized test platform)
- Arena with required test scenario setup
- Livestream infrastructure (cameras, encoding, upload)
- Judging materials (rubric sheets, stopwatches, measurement tools)
- Spare parts (in case of assembly issues)

**Revenue Model:**
- 5% commission from bounty pool covers verification costs
- Example: €12.5k bounty → €625 retained by Institute → covers:
  - Arena setup labor (4 hours × 2 people × €25/hr = €200)
  - Equipment transport to event (€100)
  - Livestream production (€200)
  - Judge compensation (€125, or waived if Archon volunteers)

**Why This Works:**

**For Submitters:**
- Fair, public evaluation (no behind-closed-doors decisions)
- Standardized test conditions (everyone uses same rental bots)
- Portfolio benefit (YouTube demonstration visible to industry)
- Even losers get exposure (2nd and 3rd place still get prizes + credit)

**For Funders:**
- Proof that solutions work in real conditions (not just lab demos)
- Public validation (can't fake Arena demonstration)
- Industry-relevant testing (competition pressure analogous to deployment stress)

**For Ecosystem:**
- Viral content: Arena demonstrations are exciting to watch
- Dataset contribution: Bounty tests generate new match data
- Knowledge validation: Failures documented (why didn't it work?)
- Integration pathway: Winning modules may be added to rental fleets

**Integration with Event Calendar:**

Bounty demonstrations are scheduled as special sessions at major sanctioned events:
- **Q1 Championship:** Resurrection Challenge demonstrations (Roomba 500, RC cars)
- **Q2 Regional Events:** Hardware module bounties (cleaning, mobility, sensors)
- **Q3 Championship:** Firmware and AI bounties (coordination, security, prompts)
- **Q4 Championship:** Year-end "best of" bounty showcase (previous winners compete again)

This creates recurring content for YouTube, adds variety to event programming, and ensures bounty marketplace stays active (regular demonstration dates = submission deadlines).

**Logistics Checklist for Bounty Verification Event:**

**2 Weeks Before:**
- [ ] Contact top 3 submitters, confirm attendance
- [ ] Review bounty requirements, design Arena test scenario
- [ ] Prepare 10 rental bots (freshly calibrated, fully charged)
- [ ] Ship any specialized equipment to event location
- [ ] Announce demonstration on YouTube, social media

**1 Week Before:**
- [ ] Receive submitted modules (or confirm submitters bringing them)
- [ ] Print any required test objects (if not already available)
- [ ] Confirm judging panel availability
- [ ] Prepare judging rubric sheets (printed, 3 copies)

**Day of Event:**
- [ ] Set up Arena test scenario (2 hours before demonstration)
- [ ] Test livestream infrastructure (30 min before)
- [ ] Brief judges on rubric, timing, scoring process
- [ ] Run demonstrations (30 min each, 90 min total)
- [ ] Tally scores, announce winner publicly
- [ ] Collect all documentation for Knowledge Commons upload

**Post-Event:**
- [ ] Upload full demonstration videos to YouTube (1 per submission)
- [ ] Coordinate prize distribution (bank transfers within 1 week)
- [ ] Upload CAD files, test results to Knowledge Commons
- [ ] Solicit feedback from submitters (improve process for next bounty)

---

## Revenue Model

### Awakening Module Sales (New Revenue Stream)

**Year 1 Projections (10 Mechanists):**
- 10 Mechanists × 50 modules/year = 500 units
- €50/unit × 500 = €25k revenue
- Margin after commissions: €10k (€5/unit retained by Institute)

**Year 2 Projections (30 Mechanists):**
- 30 Mechanists × 75 modules/year = 2,250 units
- €50/unit × 2,250 = €112k revenue
- Margin: €45k

**Year 3+ Projections (100 Mechanists):**
- 100 Mechanists × 100 modules/year = 10,000 units
- €50/unit × 10,000 = €500k revenue
- Margin: €200k

**Guild Compensation:**
- Mechanist: 20% commission (€10/unit)
- Archon: 5% override (€2.50/unit)
- Institute: 25% retained (€5/unit for operations)
- Remaining 50% (€10/unit) covers COGS (€30)

### Event Rentals (Primary Revenue Driver)

**Competition Package (€2k/weekend):**
- 60-bot SMARS fleet (or custom platform Year 3+)
- 3x3m arena system
- 2× pilot stations + 1× hacker station
- Technical support (remote during event)
- Dataset upload included (automatic from arena system)
- **Add-on:** Resurrection Workshop (bring broken robots, leave with Awakening Modules) +€500

**Economics:**
- Fleet cost: €4k (SMARS) or €21k (custom)
- Breakeven: 2 events (SMARS) or 7 events (custom)
- Utilization target: 15 events/year per fleet
- Profit per fleet per year: €26k (SMARS) or €24k (custom)

**School Training Package (€500/semester, subsidized):**
- 12-bot training fleet (smaller, 4v4 practice)
- 2x2m compact arena
- Educational curriculum access
- Semester = 4 months
- **Subsidy source:** Corporate sponsors (talent pipeline investment)
- **Purpose:** Funnel students into pilot competition pipeline

**Corporate Workshop Package (€5k/day):**
- Full 60-bot competition setup
- On-site facilitator
- Custom team-building scenarios
- Video production (highlight reel for company)
- Dataset access for company (limited use)
- **Profit margin:** 60% (€3k profit per workshop)

### Component Sales (At-Cost, Ecosystem Growth)

**SMARS Build Kits:**
- Complete BOM for 1 bot (€50)
- Sold at cost (zero margin)
- **Purpose:** Enable pilots to build custom fleets, drives competition participation
- **Revenue impact:** More pilots → more events → more rental demand

**3D Print Files & Firmware:**
- Free download (CC-BY-SA license)
- **Purpose:** Maximize SMARS ecosystem adoption, not a revenue source

### Scaling Economics

**Year 1 (3 Fleets, SMARS):**
- **Investment:** €12k (3× €4k fleets)
- **Rental Revenue:** €40-60k (15 events/fleet × €2k × 3 fleets, conservative)
- **Profit:** €28-48k (funds 7-12 more fleets)

**Year 2 (10 Fleets, SMARS + EU Expansion):**
- **Investment:** €40k (10× €4k fleets, funded by Year 1 profit)
- **Rental Revenue:** €200-300k (20 events/fleet × €2k × 10 fleets)
- **Profit:** €160-260k (funds Phase 2 custom platform development)

**Year 3 (10 Custom Fleets + 20 SMARS Fleets for Schools):**
- **Investment:** €210k (10× €21k custom) + €80k (20× €4k SMARS)
- **Rental Revenue:** €600-800k (20 events/fleet × €3k × 10 custom + school rentals)
- **Profit:** €310-510k (funds geographic expansion, franchise model)

---

## Scaling Strategy

### Phase 1: Prove Rental Model (Months 1-12)

**Manufacture:**
- 3× 60-bot SMARS fleets (€12k investment)
- 3× arena systems (€6k)
- Pilot/hacker interfaces (€8k)
- **Total:** €26k capital investment (from €300k EIC Stage 1 grant)

**Test Events:**
- 2 events in Tallinn (prove local demand)
- 1 event in Tartu (prove regional scalability)
- 1 school pilot (prove educational model)
- 1 corporate workshop (prove commercial model)

**Validation Metrics:**
- All events fully booked? (demand signal)
- Equipment returned in good condition? (operational viability)
- Dataset upload successful? (technical validation)
- Participants want to compete again? (retention signal)

### Phase 2: Scale Within Estonia (Months 13-24)

**Manufacture:**
- 7 additional SMARS fleets (€28k, funded by Year 1 rental profit)
- 5 school training packages (€20k)
- **Total:** 10 competition fleets + 5 school fleets

**Geographic Coverage:**
- Tallinn (2 fleets, high demand)
- Tartu (2 fleets, university market)
- Pärnu, Narva, Rakvere (1 fleet each, franchise testing)

**Event Cadence:**
- 20-30 sanctioned events across Estonia
- 10 school programs
- 5 corporate workshops
- **Revenue:** €200-300k rental + €50-100k sponsorship

### Phase 3: European Expansion (Months 25-48, Stage 2 EIC)

**Manufacture:**
- 10× custom platform fleets (€210k, funded by Stage 2 EIC grant)
- 10× specialized arenas for Year 3 scenarios (€60k)
- **Total:** Major capital investment unlocked by Stage 2 success

**Geographic Hubs:**
- **Nordic Hub (Helsinki):** 2 custom fleets, serves Finland/Sweden
- **Baltic Hub (Riga):** 2 custom fleets, serves Latvia/Lithuania
- **Central Europe Hub (Warsaw):** 3 custom fleets, serves Poland/Germany
- **Southern Europe (TBD):** Partner with franchise, shared fleet model

**Franchise Model:**
- Regional partners manufacture additional fleets locally
- License Robot Arena brand + event formats
- Revenue share: 15% of rental fees to central organization
- Dataset contribution mandatory (maintains Knowledge Commons value)

### Phase 4: Self-Sustaining Network (Years 5-6+)

**Fleet Count:**
- 50+ competition fleets globally (mix custom platform + SMARS for schools)
- **Utilization:** 25-30 events/year per fleet (weekend saturation in major markets)
- **Rental Revenue:** €500k+/year (direct ownership) + €200k/year (franchise revenue share)

**Operational Maturity:**
- Regional repair centers (faster turnaround, lower shipping costs)
- Standardized training for event organizers (quality consistency)
- Automated dataset upload and validation (reduced manual overhead)
- Pilot certification programs (ensures skilled competition, drives dataset value)

---

## Why Rental Model Funds The Ecosystem

**The Flywheel:**

1. **Rental fees fund fleet manufacturing** (€2k rental → ½ new fleet after 2 events)
2. **More fleets → more events → more dataset growth**
3. **Better dataset → higher commercial licensing value**
4. **Licensing revenue → larger prize pools**
5. **Larger prizes → more pilots → more event demand**
6. **Repeat**

**Key Insight:**
Pilots who build custom SMARS bots drive innovation (custom mods, new strategies). But schools and casual participants renting bots drive volume (more matches, more data, more revenue). Both are essential.

**Rental is not competitor to custom builds—it's complementary:**
- Rentals lower barrier to entry (more total pilots)
- Custom builds push boundaries (better strategies, proven in competition)
- Successful custom mods get integrated into rental fleets (continuous improvement)
- Everyone contributes to dataset (rental or owned bots)

**Financial Sustainability:**
- **Years 1-2:** EIC grant funds initial fleets, rental revenue proves model
- **Years 3-4:** Rental profit funds fleet scaling + custom platform R&D
- **Years 5+:** Rental + dataset licensing + sponsorship = fully self-sustaining, no more grants needed

This model ensures Robot Arena doesn't depend on hardware sales margins (low profit, commoditized) but instead on **rental utilization + dataset value** (high margin, network effects).
