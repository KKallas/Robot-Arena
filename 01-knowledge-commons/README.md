# Knowledge Commons

**Purpose:** The open-source repository that becomes global physical AI infrastructure.

## What This Is

GitHub + YouTube as the technical memory of the entire swarm robotics ecosystem. Every match recorded, every strategy documented, every modification shared. All matches livestreamed and archived publicly. Full sensor datasets available under revenue-threshold licensing (inspired by Epic Games / Unreal Engine model).

This creates something unprecedented: a searchable database of swarm coordination solutions under adversarial conditions, complete with multi-perspective video evidence and ground truth sensor data showing what worked and what failed.

## Why Pilots Contribute

- **Recognition:** Novel strategies named after discoverers ("Kaspar Snake", "Mumbai Flood Fill")
- **Leaderboard:** Rankings across all sanctioned events
- **Dataset Access:** Contributors get free academic-tier access to full dataset
- **AI Training:** Personal AI assistant improves from your historical match decisions
- **Learning:** Building on others' strategies accelerates everyone
- **Trust:** Knowledge remains genuinely open through YouTube + metadata, detailed data via fair licensing

**For Custom Modifications:**
- **Credit:** CAD improvements, firmware optimizations named after creators
- **Adoption:** Successful mods integrated into rental fleet designs (royalty-free, but credited)
- **Validation:** Dataset shows which modifications correlated with wins
- **Community:** Other pilots fork and improve your designs

The moment you try to capture proprietary advantage, the contribution dynamic breaks. But credit and recognition flow to those who share.

## Core Components

### `/platforms/`

**`/smars-base/`** - Phase 1 Competition Platform (Years 1-2)
- Official SMARS specification and reference design
- M5Stack Camera + M5 Atom integration guide
- MicroPython firmware repository
- Complete BOM with supplier links (€50/bot)
- 3D printable STL files (CC-BY-SA license)

**`/pilot-modifications/`** - Community Improvements
- Motor upgrades and alternative drive systems
- Sensor additions (IR, ultrasonic, IMU)
- Power optimization (better voltage regulation, efficiency)
- Structural improvements (rigidity, crash resistance)
- **All modifications documented:** CAD files, BOM diffs, performance impact, creator credited

**`/resurrection-archive/`** - Obsolete Robot Revival (New - Sustainability Track)
- **Purpose:** "What is broken can be reborn. What is obsolete can evolve."
- Database of successfully resurrected robots (Roomba 500 series, WowWee Robosapien, Anki Cozmo, RC cars, robotic vacuums)
- **Awakening Module** integration guides (ESP32 + M5Stack Camera retrofit instructions)
- Step-by-step photo/video documentation (wiring diagrams, code, troubleshooting)
- Failure logs (what didn't work—equally valuable for research)
- BOM for each resurrection (often €20-40 in parts vs €50 for new SMARS)
- Performance comparison (resurrected Roomba vs stock SMARS in specific scenarios)
- **Quarterly Resurrection Challenges:** Target specific obsolete platforms, prizes for successful conversions
- **Viral Content Potential:** Before/after videos, "saving robots from e-waste" narrative

**`/custom-platform/`** - Phase 2 Platform (Years 3+)
- 50cm weatherproof chassis design
- Modular attachment system for industry tools
- Enhanced compute platform (Raspberry Pi 4/5)
- Outdoor operation specs

### `/firmware/`

**`/official-micropython/`** - Base Trigger System
- HTTP API specification (how bots receive commands)
- Trigger queue implementation
- Camera stream server (640x480@30fps)
- Basic navigation (go straight until timer/obstacle)

**`/pilot-forks/`** - Custom Firmware (Must Remain Compatible)
- Optimized motion control algorithms
- Enhanced sensor processing
- Custom trigger logic
- **Requirement:** Must respond to same HTTP API for fair competition

### `/strategies/`

**`/formations/`** - Documented Swarm Behaviors
- Snake formation (leader-follower chain)
- Flood fill (maximize area coverage)
- Sacrificial decoy (split force to distract)
- Network resilience (maintain mesh under jamming)
- **Each includes:** Video examples, trigger code, when to use, counter-strategies

**`/ai-prompts/`** - Effective LLM Interactions
- Claude Code prompt patterns that generate working swarm code
- ChatGPT strategies for defensive formations
- Common failure modes and how to avoid them
- **Anonymized but categorized:** Winning vs. losing prompt patterns

**`/button-configs/`** - Pre-Made Strategy Libraries
- Novice division approved button sets
- Intermediate division optimized configurations
- Advanced division experimental strategies
- **Performance data:** Win rates by scenario type

### `/hacker-tools/`

**`/attack-scripts/`** - Network Disruption Methods
- Wireshark capture configurations for bot traffic analysis
- Aircrack-ng jamming scripts (legal use only, education/competition)
- Message injection examples (Python + scapy)
- **Ethics note:** Responsible disclosure, competition use only

**`/defense-patterns/`** - Encryption & Authentication Tested
- Lightweight encryption schemes (ESP32 resource constraints)
- Message authentication approaches
- Mesh networking protocols
- **Performance data:** Security vs. latency trade-offs, which survived 90-second attacks

### `/ml-datasets/`

**The training data goldmine.** Thousands of hours of 60-bot multi-agent behavior under adversarial conditions, with complete hardware/software documentation.

**`/match-replays/`** - Full Sensor Logs (Licensed)
- 60× robot position/velocity trajectories (10Hz sampling)
- 60× camera feeds (saved separately, referenced in metadata)
- Network traffic captures (pcap format, includes hacker attacks)
- Pilot input logs (button presses vs. AI prompts, timestamps)
- Match outcomes (scores, formations used, winner)

**`/youtube-archive/`** - Public Video Dataset (Free)
- All matches livestreamed and permanently archived
- 60-camera multiview in UHD quality (overhead + 60 bot-mounted cameras)
- Video descriptions include:
  - Match metadata (pilots, final score, formations observed)
  - Link to sanitized dataset excerpt (formation labels, outcome)
  - Link to dataset licensing page (per-match €50 or revenue-threshold model)
- **Purpose:** Advertising for full dataset, educational content, community engagement
- **Revenue:** YouTube ads (€50-100k/year at scale) + drives dataset sales

**`/labeled-behaviors/`** - Annotated Strategy Examples
- Successful formations (what triggers were used, how many bots, outcome)
- Failed coordination attempts (what went wrong, why)
- Effective hacker attacks (which vulnerabilities exploited)
- Defensive responses (how pilots adapted to ongoing attacks)
- **Resurrection performance data:** How resurrected robots performed vs SMARS baseline (mobility, durability, coordination effectiveness)

**`/transfer-learning/`** - Sim-to-Real Validation
- Simulation equivalents of physical matches (Gazebo, Webots, custom)
- Domain randomization parameters that worked
- Physical calibration data (motor response curves, sensor noise profiles)
- **Research value:** Closing sim-to-real gap for industrial deployments

**`/tool-selection/`** - Human-AI Collaboration Data
- When pilots chose buttons vs. AI code generation
- AI prompt text + generated code + execution outcome (worked/failed)
- Correlation between tool choice and match outcome
- Trust calibration over multiple matches (did pilots learn when to use AI?)

### `/bounty-marketplace/`

**Purpose:** Distributed R&D funding for capabilities nobody has built yet. Pooled challenges where multiple parties fund solutions to shared problems, with winning designs entering the commons.

**The Core Mechanism:**

When someone needs a capability that doesn't exist yet (glass-washing module, stair-climbing mechanism, mesh protocol resistant to specific attack), they post a bounty. Others with similar needs add to the prize pool. The winning solution enters Knowledge Commons—everyone who funded it can use it, and so can everyone else.

**Example Flow: Bus Stop Glass-Washing Module**

**Initial Seed (€10k):**
- London bus company needs glass-washing for 30-bot inspection swarm
- Posts bounty: "Develop glass-washing attachment for SMARS platform, must clean 1m² in 90 seconds, €300 budget per module"
- Seeds pool with €10k

**Pool Growth (€12.5k total):**
- Window cleaning company adds €2k (they also need this capability)
- Greenhouse operator adds €500 (automated glass maintenance)
- Hobbyist who wants to solve it adds €50 (entry fee to participate in challenge)
- **Total pool:** €12,550

**Submission Requirements:**
- 3D printable CAD files (standardized format, max €300 BOM from listed suppliers)
- Assembly instructions with photos
- Test object: 1m² acrylic sheet with standardized dirt pattern (3D printable spray mask)
- Video demonstration: Module cleaning test object in 90 seconds
- Arena demonstration: 10-bot swarm with modules coordinating to clean 3m² arena floor

**Verification Process (Two-Stage):**

**Stage 1: Automated Validation (Anyone can verify)**
- Download test object STL, 3D print acrylic spray mask
- Apply dirt pattern, run cleaning module per instructions
- Film 90-second cleaning attempt
- Upload video + timestamp to GitHub PR

**Stage 2: Arena Demonstration (At next sanctioned event)**
- Top 3 submissions from Stage 1 invited to Arena event
- Public demonstration: 10-bot swarm cleaning arena floor
- Judges evaluate: reliability (% of bots that complete task), cost (actual BOM), robustness (works on multiple floor types)
- Winner announced, prize pool distributed (70% first place, 20% second, 10% third)

**Knowledge Release:**
- All CAD files, code, assembly instructions enter `/pilot-modifications/glass-washing/`
- Credited to creator team
- Anyone can now build glass-washing robots (including London competitor who didn't fund bounty)
- Funders have first-mover advantage in their markets

**Why This Works:**

**For Funders:**
- Subsidized R&D: €10k funder only paid 80% of total (others contributed €2.5k)
- First-mover advantage: Understand implementation deeply, deploy while competitors tool up
- Operational moat: Your advantage is expertise, not hardware secrecy
- Validation: Arena testing proves capability works under competition pressure

**For Solvers:**
- Clear requirements: 3D printable test objects eliminate ambiguity
- Fair judging: Public demonstration, standardized criteria
- Portfolio building: Winning solutions are credited, visible to industry
- Learning: Even failed attempts documented (failure logs valuable for future attempts)

**For Ecosystem:**
- Knowledge accumulation: All solutions (winning and losing) documented
- Capability expansion: Each bounty adds new module to platform
- Industry adoption: Proven capabilities transfer to commercial deployments
- Viral content: Before/after videos, Arena demonstrations drive awareness

**Integration with Quarterly Resurrection Challenges:**

Resurrection Challenges are a special category of bounty where the target is a specific obsolete robot platform:

**Q1 2025: Roomba 500 Series**
- Prize pool: €5k (Robot Arena seed) + community additions
- Challenge: Retrofit Roomba 500 with Awakening Module, compete in Division 2 (Obstacle Course)
- Success criteria: Place in top 50% of Division 2 matches at sanctioned event
- Knowledge release: Wiring diagrams, firmware, performance analysis enters `/resurrection-archive/roomba-500/`

**Q2 2025: RC Car Platforms**
- Prize pool: €3k + community
- Challenge: 4WD RC car base with Awakening Module, compete in Division 1 (Open Arena)
- Success criteria: Match or exceed stock SMARS speed and coordination
- Knowledge release: Compatible models list, retrofit guide, failure modes

**Bounty Categories:**

**Hardware Modules (€2k - €50k pools):**
- Attachments: Cleaning, lifting, grasping, sensing
- Mobility: Stairs, uneven terrain, vertical surfaces
- Power: Solar integration, wireless charging, extended runtime
- Communication: Mesh protocols, long-range coordination

**Firmware Capabilities (€1k - €20k pools):**
- Coordination algorithms: Novel formation strategies
- Security: Attack-resistant protocols, encryption within ESP32 constraints
- Autonomy: Computer vision for navigation, obstacle avoidance
- Optimization: Faster trigger response, lower latency

**Resurrection Targets (€3k - €10k pools, quarterly):**
- Specific obsolete robot platforms
- Must document 80% or more of process (photos, wiring, code)
- Failure logs equally valuable (what didn't work)

**AI Integration (€5k - €30k pools):**
- Prompt patterns for reliable swarm code generation
- On-device ML models for coordination (ESP32 resource constraints)
- Real-time strategy adaptation (human-AI collaboration during 90-second rounds)

**Posting a Bounty:**

**Requirements:**
- Minimum seed: €500 (shows seriousness)
- Clear success criteria (measurable, verifiable)
- 3D printable test objects where applicable (ensures anyone can verify)
- Deadline for submissions (typically 3-6 months)
- Arena demonstration commitment (at which sanctioned event?)

**Process:**
1. Submit bounty proposal to `/bounty-marketplace/proposals/`
2. Community feedback period (2 weeks, GitHub discussions)
3. Approval by Archons (ensures criteria are fair, testable, aligned with platform specs)
4. Bounty goes live, others can add to prize pool
5. Submission period opens (GitHub PRs with required documentation)
6. Stage 1 verification (automated, anyone can reproduce)
7. Stage 2 Arena demonstration (top 3 submissions)
8. Winner announced, knowledge released, prize distributed

**Revenue Model:**

- **Bounty Commission:** 5% of total prize pool retained by Robot Arena
- **Purpose:** Fund bounty infrastructure (test object design, verification tools, Arena demonstration logistics)
- **Example:** €12.5k glass-washing bounty → €625 commission → €11,875 to winners
- **Transparency:** All fees disclosed upfront, no hidden charges

**Link to Business Economics:**

For detailed explanation of why this model doesn't extract value (unlike traditional bug bounties or MLM schemes), see [BUSINESS-ECONOMICS.md](../BUSINESS-ECONOMICS.md).

**TL;DR:** Knowledge enters commons, funders get first-mover advantage, solvers get portfolio + prizes, ecosystem gets capabilities. Your moat is operational expertise, not hardware secrecy.

---

### `/community/`

**Contribution Guidelines:**
- How to document custom modifications (CAD export formats, BOM structure)
- Match data upload requirements for sanctioned events (automatic from arena system)
- Code of conduct (credit others, no plagiarism, responsible security disclosure)
- Recognition systems (leaderboard, strategy naming rights, dataset contributor badges)
- Bounty marketplace rules (fair verification, standardized test objects, transparent prize distribution)

**How Solutions Get Discovered:**
- GitHub topics and tags (formation type, platform, complexity, bounty category)
- YouTube playlists (by pilot, by strategy, by season, by bounty challenge)
- Dataset search API (query by formations used, hacker attacks, time period)
- Bounty marketplace (active challenges, funded pools, winning solutions)

---

## Dataset Licensing Model

**Philosophy:** Inspired by Epic Games / Unreal Engine model. **Free until you make money**, then pay proportional to revenue generated. Maximizes adoption by startups and researchers while capturing value from successful commercial deployments.

---

### Tier 1: Public Access (Free, Always)

**YouTube Match Videos:**
- All 60-camera perspectives, UHD quality
- Livestreamed during events, archived permanently
- Video descriptions include match metadata and formation analysis
- Links to full dataset licensing options in description
- **Revenue Model:** YouTube ad revenue (€50-100k/year at scale) + advertising for deeper dataset access

**GitHub Metadata:**
- Match outcomes, final scores, formation types observed
- Pilot profiles (anonymized IDs, historical win rates, strategy evolution)
- Bot modification registry (what mods were used, credited to creators)
- Formation taxonomy (snake, flood fill, decoy, etc. with examples)
- **Purpose:** Transparency, community engagement, academic validation, SEO for dataset discovery

---

### Tier 2: Academic & Research (Free with Attribution)

**Full Dataset Access:**
- Complete sensor logs from all matches (60-bot trajectories, motor commands, energy usage)
- Network traffic captures (pcap files including hacker attacks)
- Tool selection logs (pilot decisions: buttons vs. AI, exact prompts if AI-generated)
- Camera calibration data and arena configuration files

**Requirements:**
- Affiliation with academic/research institution OR personal research project
- Citation requirement in publications (`Robot Arena Dataset v2025.1, licensed under CC-BY-NC-SA-4.0`)
- Share trained models back to community (encouraged, not required)
- **No commercial revenue** generated from derivative works

**Use Cases:**
- PhD research on swarm coordination
- Undergraduate projects on IoT security
- Personal ML model training experiments
- Open-source algorithm development

---

### Tier 3: Commercial (Revenue Threshold Model)

**The Epic Games Approach:**

**Free Tier (€0/year):** Revenue < €100k/year
- Full dataset access, same as Academic tier
- Commercial deployment permitted
- No licensing fees until you cross revenue threshold
- Self-reported revenue (honor system, spot audits)

**Startup Tier (5% revenue, min €5k/year):** Revenue €100k - €1M/year
- 5% of gross revenue attributable to dataset-derived technology
- Minimum €5k annual fee
- Example: Warehouse robot startup makes €200k revenue → €10k licensing fee
- Quarterly revenue reporting
- Includes technical support and dataset API access

**Growth Tier (€20k/year base + 3% revenue):** Revenue €1M - €10M/year
- €20k base + 3% of gross revenue above €1M
- Example: Logistics company makes €3M from swarm inspection product → €20k + 3% × €2M = €80k total
- Early access to new datasets (1-month head start)
- Quarterly strategy briefings (what's emerging in competition)

**Enterprise Tier (€100k/year base + 2% revenue):** Revenue > €10M/year
- €100k base + 2% of revenue above €10M
- Example: Major automation vendor makes €50M from dataset-derived products → €100k + 2% × €40M = €900k
- Custom competition scenarios (we test your specific industrial use cases)
- Dedicated dataset formats and API endpoints
- Priority support and co-marketing opportunities
- Defense/military customers: Custom pricing (typically €500k+ fixed fee, no revenue share)

**Attribution Requirement (All Commercial Tiers):**
- Product must credit "Robot Arena Physical AI Dataset" in documentation
- Logo usage permitted (and encouraged) in marketing materials
- Case study participation (for companies making >€10M with our data)

---

### Tier 4: Per-Match Purchase (€50/match)

**Individual Match Deep Dive:**
- Full sensor logs from one specific match (all 60 bots)
- Network captures (pcap files), pilot decisions, camera feeds
- No ongoing license, one-time purchase
- Can be used commercially if your total revenue stays under €100k/year threshold
- Otherwise, must upgrade to appropriate commercial tier

**Use Cases:**
- Pilot buying their own match data for training analysis
- Researcher needing specific adversarial scenario example
- Consultant demonstrating swarm concepts to potential client
- Student thesis focused on single match formation analysis

---

### Tier 5: Sponsor Packages (€100k+/year)

**Sponsorship includes Commercial Enterprise Tier license:**
- Full dataset access with unlimited deployment rights (no revenue share above base €100k)
- Branding at all sanctioned events (logo, demos, talent recruitment booth)
- Talent pipeline access (recruit top pilots, hire competition winners)
- Custom workshop hosting (use dataset in client workshops, co-branded)
- Product placement (your robots can be rental fleet, credited)

**Use Cases:**
- Major logistics companies (DHL, DB Schenker) recruiting automation engineers
- Automation vendors (ABB, KUKA) demonstrating swarm capabilities to clients
- Cloud providers (AWS, Azure, Google Cloud) showcasing edge AI on our dataset
- Defense contractors (Anduril, Palantir) validating autonomous systems

**ROI for Sponsors:**
- Dataset license alone worth €100k+ (Enterprise tier)
- Talent recruitment saves €50k+ per hire (direct access to vetted pilots)
- Marketing reach through YouTube (hundreds of thousands of views)
- Product validation through competition (real-world adversarial testing)

---

## Revenue Enforcement & Verification

**Self-Reporting (Primary):**
- Annual revenue declaration required for commercial users
- Honor system for small companies (audit burden not worth it)
- Public dataset means violations easily spotted (competitors will report)

**Spot Audits (Selective):**
- Companies claiming <€100k revenue but clearly large-scale deployments
- Right to audit financials if suspicious (standard in licensing contracts)
- Penalties: 3× underpaid fees + removal from dataset access

**Network Effects Enforcement:**
- Pilots contribute match data → they have incentive to report violations (protects their contribution value)
- Academic community validates proper attribution (citations must be accurate)
- Industry competition means rivals report underpayment (free enforcement)

**Penalty for Violation:**
- First offense: Pay owed fees + 50% penalty, continue access
- Second offense: Pay owed fees + 200% penalty, 1-year suspension
- Third offense: Permanent ban, public disclosure, possible legal action

---

## Why This Model Works

**For Startups & Researchers:**
- Zero upfront cost removes barrier to entry
- Can build entire product on our dataset for free if bootstrapping
- Only pay when successful (aligned incentives)
- Makes dataset de facto industry standard (everyone uses it)

**For Large Enterprises:**
- Fairness: Large companies can afford to pay, should pay
- Predictability: Revenue-based pricing scales with their business
- Value: Dataset becomes more valuable as more companies contribute via competition
- Marketing: Sponsorship provides ROI beyond just data access

**For Robot Arena:**
- Maximizes dataset adoption (network effects)
- Revenue concentrates on successful deployments (proof of value)
- Sustainable: Big winners fund operations, enable continued free tier
- Aligned: We want companies to succeed using our data (makes dataset more valuable)

**The Flywheel:**
1. Free tier drives massive adoption
2. More users → more competition participants → better dataset
3. Better dataset → more commercial success stories
4. Successful companies pay revenue share → fund larger prize pools
5. Larger prizes → attract more pilots → even better dataset
6. Repeat

---

## Strategic Value

When a pilot in Mumbai discovers a 15-bot decoy formation that wins against jamming attacks → **documented, visualized on YouTube, full data available for €50/match or free if you're a startup making <€100k**.

When Brazil develops a mesh protocol that resists message injection → **firmware uploaded, attack data in dataset, credited to team, free for anyone to use commercially until they make real money**.

When Singapore finds an AI prompting pattern that generates reliable swarm code in 5 seconds → **prompt pattern anonymized but categorized, licensing reveals effectiveness, bootstrap startups get it free**.

**Estonian companies don't need to discover every strategy themselves.** They become expert at:
1. **Synthesis:** Combining global strategies from Knowledge Commons
2. **Application:** Adapting swarm coordination to Port of Tallinn ship hull inspection
3. **Validation:** Testing industrial deployments against competition-proven strategies
4. **Contribution:** Uploading industrial learnings back to dataset (under commercial terms)

**The sport becomes a massively distributed R&D operation for physical AI and IoT security.**

Dataset grows more valuable as:
- More matches recorded (statistical power)
- More diverse strategies (covers edge cases)
- More hacker attacks (security validation)
- More industrial applications (transfer learning proven)
- More revenue-paying companies (validates commercial value)

**Network effects:** More pilots → more matches → more valuable dataset → more commercial success → more licensing revenue → larger prizes → more pilots.
