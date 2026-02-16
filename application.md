# MECARENA: Distributed Robotics Infrastructure for European Industrial Resilience

## 1. Excellence

### 1.1 Clarity and relevance of the innovation idea

Europe faces a structural disadvantage in hardware innovation. While Shenzhen's ecosystem enables companies like DJI and Bambu Lab to iterate through thousands of informal testers with immediate feedback loops, European hardware startups suffer from slow validation cycles and fragmented manufacturing capacity. Simultaneously, every European nation faces an infrastructure maintenance crisis—bridges, pipes, cables, HVAC systems, drainage networks—with backlogs measured in decades and budgets that cannot scale to meet demand through traditional methods.

**The training data problem**: Consider Prusa and Bambu Lab. Their 3D printers are nearly identical in hardware capability—same motors, same hotends, same basic architecture. The difference is software and ML model quality, and that difference comes from training data volume. Bambu ships millions of units; each print generates telemetry that improves their models. Prusa ships hundreds of thousands; their models never catch up. European hardware products consistently lose not because they're worse engineered but because they never reach the production volumes needed to train competitive software. This is the core problem mecharena addresses: how do you generate Shenzhen-scale training data for European robotics when European products don't ship in Shenzhen-scale quantities?

mecharena addresses both problems through a single mechanism: a competition-based distributed robotics development system that produces validated small-scale maintenance robots and the workforce capable of building and operating them.

**The core innovation** is a pipeline connecting three stages: ML-based behavioral simulation, physical robot validation through competition, and income-generating infrastructure maintenance deployment. Participants train robotic behaviors in simulation, then 3D print and modify 50cm-scale robots to match simulated performance. Competition validates designs under stress. Validated robots and operators then perform actual infrastructure maintenance work, creating economic returns that sustain the ecosystem without permanent subsidy.

**The problem scale**: Infrastructure maintenance represents a bottomless, government-funded market. The American Society of Civil Engineers estimates $2.6 trillion in US infrastructure maintenance backlog alone; European figures are proportionally similar. Current approaches using large crews and heavy equipment cannot economically address the long tail of small-scale maintenance tasks. A 50cm robot that can inspect pipes, clean drainage systems, or assess structural cracks fills a gap no current solution addresses.

**Current status**: TRL 3. We have validated the competition format through robotics courses at Narva College with ESP32-based systems, pneumatic actuators, and 3D-printed components under €300 budget constraints. Students successfully built functional robotic systems demonstrating that amateur manufacturing with consumer-grade tools produces viable hardware. The simulation layer exists as proof-of-concept using standard ML frameworks. Phase 1 target: TRL 5 (validated in relevant environment through multi-site competition). Phase 2 target: TRL 7 (system prototype demonstration in operational environment through paid maintenance contracts).

**Current practice and its limits**: Traditional robotics education separates simulation from physical builds, and both from economic application. Students learn theory, build projects that get discarded, and never experience the feedback loop of real-world deployment. Industrial robotics companies develop proprietary systems too expensive for distributed manufacturing. The result: Europe produces robotics researchers but not garage engineers, academic papers but not deployable products, prototypes but not production capacity.

### 1.2 Breakthrough nature and novelty and suitability of use case

**How the technology works**:

The system operates as three integrated layers:

*Simulation layer*: Participants develop robot behaviors using ML models in a standardized simulation environment. The environment models 50cm-scale robots performing infrastructure maintenance tasks—navigation through confined spaces, manipulation of common infrastructure components, sensor-based inspection routines. Models are trained and validated in simulation before any physical build.

*Physical validation layer*: Competition challenges are 90-second arena runs designed for social media shareability. Each challenge focuses on edge-case problems drawn from real maintenance work: a window-washing robot stuck in a corner, a pipe inspector that needs to climb over an unexpected obstacle, a drainage bot navigating debris. Basic qualification requires completing the arena in under 30 seconds without collisions—but meaningful validation requires at least 30 different robots achieving this threshold, proving the design is reproducible rather than a one-off success. Participants 3D print robots constrained to €300 budgets and modify designs to match simulated behaviors. Every competition generates failure mode data, component reliability statistics, and sim-to-real calibration information. Hundreds of teams running similar challenges produce the testing density that Shenzhen achieves through industrial clustering.

*Bounty board layer*: Operators already using robots in the field post bounties for unsolved problems—behaviors their current designs cannot handle, edge cases that block deployment, performance improvements needed for specific contracts. Teams wishing to attempt a bounty pay a participation fee that adds to the prize pool; if they abandon the challenge, the bounty grows larger. This creates an economic ratchet: hard problems accumulate funding until someone solves them. Teams can also attract direct sponsors, connecting corporate R&D budgets to distributed problem-solving capacity.

*Deployment layer*: Validated robot designs and trained operators can accept infrastructure maintenance contracts. The competition establishes capability credentials; the physical robots become income-generating tools. Revenue flows to garage engineers, making the path economically attractive and self-sustaining.

**The deeper function—gamification as alignment**:

The bounty board mechanism serves a purpose beyond funding: it connects engineers to business reality through game mechanics rather than forcing them into traditional business roles. Engineers optimize for bounties the way they might tune hyperparameters—the economic signal is clear, the feedback loop is fast, the goal is well-defined. This is analogous to weight adjustment in LLM fine-tuning: you're not changing what engineers fundamentally are, you're adjusting which behaviors get reinforced. The result is engineers who participate in the business world by solving problems the market actually values, without requiring them to become salespeople or managers. The gamification layer translates market needs into engineering challenges.

**What is breakthrough**:

First, we treat competition as distributed R&D infrastructure rather than educational activity. Every team that builds and breaks a robot generates data that would cost millions to produce through traditional testing.

Second, the €300 budget constraint isn't limitation but feature. It forces the resourcefulness that makes distributed manufacturing resilient. Ukraine's Brave 1 program demonstrated that hundreds of independent teams with 3D printers and minimal budgets can produce effective robotic systems under extreme conditions—faster and more adaptively than centralized procurement. mecharena builds this capacity before crisis demands it.

Third, the 50cm scale hits a specific market gap. Large enough for real infrastructure work, small enough for garage manufacturing. No current solution addresses the long tail of small-scale maintenance tasks because traditional robotics economics don't work at that scale. Distributed manufacturing economics do.

Fourth, the simulation-to-income pipeline creates natural selection pressure toward actually useful designs. Robots that win competitions but can't do real work get filtered out when operators try to generate income with them.

**Why it will succeed**:

The Brave 1 existence proof: Ukraine's distributed defense manufacturing network demonstrated that motivated amateurs with consumer tools can outproduce traditional systems under the worst possible conditions. mecharena asks what happens when you build this capacity deliberately, in peacetime, with proper training infrastructure.

The prize money status signal: €50,000 in prizes makes garage engineering visible and attractive. Competition creates heroes, heroes create culture, culture creates workforce pipeline. Europe stopped producing garage engineers when that path stopped looking viable; we're restoring the signal that it works.

The bottomless market: Infrastructure maintenance demand cannot be satisfied through current approaches. Any system that produces deployable capacity at lower cost finds immediate application.

**Use cases**:

Primary use case: Drainage and pipe inspection/maintenance in municipal infrastructure. Robots navigate confined spaces, perform visual inspection, clear minor blockages, apply sensor-based diagnostics. Validated through competition challenges simulating real municipal maintenance scenarios, then deployed through contracts with municipal authorities.

Secondary use case: Structural inspection for bridges, buildings, and industrial facilities. Robots access difficult-to-reach locations, perform standardized inspection protocols, generate documentation. Lower liability threshold than repair work while building operational track record.

Letters of intent substantiation: [To be completed with specific municipal partners and industrial facilities willing to provide test environments and initial contracts]

Infrastructure access: Narva College provides fabrication facilities, testing space, and student population. TalTech accelerator network provides access to industrial partners. Estonian municipal authorities provide access to actual infrastructure for validation testing. [Specific commitments to be documented]

### 1.3 Expected performance improvements

**Quantitative targets**:

- Iteration speed: Reduce hardware validation cycle from months (traditional European approach) to weeks (matching Shenzhen ecosystem pace) through parallel testing across competition network
- Cost per validated design: €5,000 in prize money and infrastructure produces testing equivalent to €500,000+ in traditional R&D through distributed parallel validation
- Workforce development: 500+ trained garage engineers with demonstrated robotics capabilities within 24 months
- Deployment readiness: 50+ validated robot designs suitable for infrastructure maintenance by end of Phase 2
- Revenue generation: First paying maintenance contracts secured by month 18, demonstrating economic sustainability

**Qualitative improvements**:

- Sim-to-real transfer accuracy: Competition provides massive calibration dataset improving model reliability
- Design robustness: Budget constraints force designs that work with available components, improving supply chain resilience
- Operator capability: Competition pressure develops troubleshooting skills that classroom instruction cannot replicate
- Network density: Any location with 3D printer becomes potential manufacturing node

**Development challenges and risks**:

*Technical risk - sim-to-real gap (Low likelihood, Medium severity)*: The standard approach in procedural simulation is well-established: build a simplified model, tune parameters against real-world observations, then run complex behaviors on the calibrated model. mecharena follows this pattern but skips intermediate conversion steps by going directly from simplified simulation to physical validation. The competition generates the calibration data at scale—hundreds of teams building similar robots provides the parameter-tuning dataset that traditional approaches require expensive dedicated testing to produce. Mitigation is built into the structure: competition results continuously feed back to improve simulation fidelity.

*Market risk - target audience accessibility (Low likelihood, Medium severity)*: The target participants aren't students or hobbyists but existing small-scale service providers: 3D print shops, shoe repair businesses, one-person entrepreneurs in supermarkets—people who already have tools, skills, and physical locations but have lost access to viable markets as their traditional trades decline. These are people who know how to work with their hands and run small operations but need new revenue streams. Risk is that this population doesn't engage with competition format. Mitigation: Prize money and bounty income speak directly to their economic situation; competition format is simpler than traditional business development; success stories from early adopters demonstrate viability to peers.

*Ecosystem risk - insufficient participation (Low likelihood, High severity)*: Competition fails to attract enough participants to generate meaningful testing density. Mitigation: Prize money provides strong initial incentive; partnership with universities provides baseline participation; success stories from early cohorts drive organic growth.

*Regulatory risk - robot operation restrictions (Medium likelihood, Medium severity)*: Infrastructure maintenance robots may face regulatory barriers in some jurisdictions. Mitigation: Begin in permissive jurisdictions (Estonia, other Baltic states); inspection-only tasks have lower regulatory burden than manipulation tasks; build compliance expertise as network matures.

---

## 2. Impact

### 2.1 Potential to develop new markets

**What success means**:

During project: 500+ active participants across 10+ countries, validated robot designs performing real infrastructure maintenance tasks, first revenue-generating contracts demonstrating economic sustainability.

After project: Self-sustaining network of garage engineers serving infrastructure maintenance market, design repository enabling rapid deployment of new nodes, simulation-to-deployment pipeline operating continuously.

**Who cares and why**:

*European competitiveness*: The innovation gap with Asia stems partly from testing infrastructure density. mecharena creates comparable validation capacity through distributed network rather than geographic clustering. Europe gains the iteration speed advantage that currently belongs to Shenzhen.

*Industrial resilience*: Ukraine demonstrated that distributed manufacturing networks provide resilience centralized production cannot match. mecharena builds this capacity for robotics before crisis demands it, with trained workforce and validated designs ready for rapid scaling.

*Infrastructure authorities*: Every European municipality faces maintenance backlogs they cannot address with current budgets. Small-scale robots filling the gap between what's economically viable and what needs doing represents genuine new capability.

*Workforce development*: The target isn't students or hobbyists but existing small-scale service providers losing their traditional markets: 3D print shops with expensive equipment and declining orders, shoe repair businesses watching foot traffic disappear, one-person service kiosks in supermarkets with tools and skills but no viable products. These people already know how to work with their hands, already run small operations, already have physical locations. They need new revenue streams, not training. Prize money signals opportunity; bounty income provides it.

*The engineer-business gap*: Traditional approaches force engineers to become businesspeople or remain disconnected from market needs. The bounty board mechanism creates a third path—engineers participate in the business world through game mechanics that translate market needs into engineering challenges. This is alignment through incentive design, similar to how fine-tuning adjusts model weights: you're not changing what engineers fundamentally are, you're reinforcing behaviors that create economic value. The result is engineers who solve problems the market actually values without requiring them to become salespeople.

*The training data solution*: mecharena generates the behavioral data and design validation that European robotics companies cannot get through normal sales volumes. Every competition run produces sim-to-real calibration data. Every bounty solution produces validated behavioral models. The competition becomes the training data factory that European hardware companies lack.

**Market transformation potential**:

The infrastructure maintenance market exists but is served by legacy approaches—large crews, heavy equipment, reactive rather than preventive intervention. A distributed network of garage engineers with small-scale robots transforms the economics: lower mobilization costs enable addressing smaller tasks, subscription-based continuous monitoring replaces periodic inspection, local operators reduce travel overhead.

Conservative estimate: 1% of European infrastructure maintenance market represents €10B+ annually. Distributed small-robot approach is not competing for entire market but addressing the long tail currently unserved.

**Scale-up path**:

Phase 1: Estonia and Baltic states as initial deployment zone, 50 active garage engineers, 10 paying contracts
Phase 2: Expansion to Nordic countries and Poland, 200 active garage engineers, 100+ paying contracts
Post-project: Network effects drive organic expansion, new regions join as success stories spread, platform becomes self-sustaining

### 2.2 Attractiveness to investors, industry and public sector

**Unique selling point**:

For investors: Platform play with network effects in validated market. Each garage engineer added increases design library and geographic coverage. Infrastructure maintenance market is recession-proof (maintenance doesn't stop when economy contracts) and government-funded (payment reliability).

For industry: Access to distributed testing capacity and validated designs without building internal capability. Component manufacturers get real-world reliability data at fraction of traditional testing cost. Robotics companies get sim-to-real calibration data improving their own products.

For public sector: Addresses infrastructure maintenance backlog with lower cost structure. Creates local employment (garage engineers work where they live). Builds strategic manufacturing capacity with dual-use potential (demonstrated by Ukraine's Brave 1 success).

**Engagement strategy**:

Municipal authorities: Partner with Estonian municipal association for initial validation contracts; success stories open doors to other jurisdictions; build standardized contracting templates reducing procurement friction.

Industrial facilities: Target manufacturing plants with ongoing maintenance needs and tolerance for innovation; food processing and pharmaceutical facilities have high cleanliness requirements making small-robot inspection attractive.

Component suppliers: Offer reliability testing data in exchange for sponsored components; creates ecosystem of preferred suppliers with proven track records.

University network: Leverage existing TalTech accelerator relationships and Narva College student base; expand to partner universities through joint competition events.

**Post-Phase 2 financing**:

The system is designed for self-sustainability. Revenue from infrastructure maintenance contracts flows to garage engineers; platform takes percentage to fund ongoing operations. Investment needed only for geographic expansion, which follows predictable playbook once model is validated.

Additional financing paths: Component manufacturer sponsorships (they get testing data), municipal subscriptions (guaranteed maintenance capacity), industrial maintenance service partnerships (they get workforce and technology, we get market access).

### 2.3 Potential commercial impact

**After Phase 1**:

- Validated competition format with 100+ participants
- 10+ validated robot designs with published specifications
- First 5 paying maintenance contracts demonstrating market acceptance
- Simulation platform with 1000+ hours of training data
- Network of 50 garage engineers with demonstrated capability

**After Phase 2**:

- 500+ active participants across multiple countries
- 50+ validated designs covering range of maintenance applications
- 100+ active maintenance contracts with combined annual revenue €500K+
- Self-sustaining platform operations without continued grant funding
- Design repository enabling new entrants to reach deployment in weeks rather than months
- Component reliability database used by broader robotics industry
- Behavioral model training dataset: 10,000+ hours of sim-to-real calibration data available to European robotics companies—the equivalent of what Bambu generates through millions of shipped units, produced instead through distributed competition
- Workforce available for rapid scaling if demand surge occurs (Ukrainian scenario demonstrates value)

---

## 3. Quality and efficiency of the implementation

**Patents**: None currently filed. Strategy is open-source designs for network effects; value captured through platform operation and maintenance contracts rather than IP licensing.

### 3.1 Work plan and resources

**Overall structure**:

The project runs 24 months in two phases:

Phase 1 (months 1-12): Foundation—simulation platform development, first competition cycle, initial maintenance contract pilots
Phase 2 (months 13-24): Scale—multi-country expansion, continuous competition operation, economic sustainability demonstration

Work is organized in five work packages tracking the pipeline stages: simulation development, competition infrastructure, physical validation, deployment preparation, and project coordination.

---

**Table 3.1a: List of work packages and effort**

| Work Package | Title | Person-Months | Start | End |
|--------------|-------|---------------|-------|-----|
| WP1 | Simulation Platform | 12 | M1 | M12 |
| WP2 | Competition Infrastructure | 11 | M1 | M24 |
| WP3 | Physical Validation | 14 | M3 | M24 |
| WP4 | Deployment & Commercialization | 8 | M6 | M24 |
| WP5 | Coordination & Portfolio | 4 | M1 | M24 |
| **Total** | | **49** | | |

---

**Table 3.1b: Work package descriptions**

**WP1: Simulation Platform**

*Objectives*: Develop and deploy ML-based simulation environment for 50cm robot behavior training; create standardized challenge scenarios based on real infrastructure maintenance tasks; establish sim-to-real validation protocols.

*Description of work*:

Task 1.1 (M1-M4): Simulation environment architecture. Define physics engine requirements, sensor simulation fidelity, behavior representation format. Select and configure base platform (likely Isaac Sim or similar). Deliverable: Technical specification and development environment. Resources: 3 PM software development, cloud computing for simulation runs.

Task 1.2 (M3-M8): Infrastructure maintenance scenario library. Work with municipal partners to document real maintenance tasks—pipe inspection protocols, drainage clearing procedures, structural assessment routines. Translate into simulation challenges with scoring criteria. Deliverable: 20 validated challenge scenarios. Resources: 4 PM domain expertise and scenario development, site visits to infrastructure facilities.

Task 1.3 (M6-M12): Behavior training pipeline. Implement ML training infrastructure allowing participants to develop and validate robot behaviors in simulation. Create standardized interfaces for behavior submission and evaluation. Deliverable: Functional training platform with documentation. Resources: 5 PM ML engineering, GPU compute for training runs.

---

**WP2: Competition Infrastructure**

*Objectives*: Establish competition rules, judging criteria, and event infrastructure; run competition cycles generating validation data; operate bounty board connecting field operators to engineering teams; manage prize distribution and participant engagement.

*Description of work*:

Task 2.1 (M1-M3): Competition framework design. Define budget constraints (€300), 90-second arena challenge format, scoring methodology, safety requirements. Design challenges around edge-case problems: corner navigation, obstacle climbing, debris avoidance. Establish 30-robot reproducibility threshold for design validation. Deliverable: Competition rulebook and judging guide. Resources: 2 PM competition design, legal review.

Task 2.2 (M3-M6): Bounty board platform development. Build system allowing field operators to post bounties for unsolved problems. Implement participation fee mechanism where abandoned attempts increase bounty value. Create sponsor matching system connecting teams with corporate R&D budgets. Deliverable: Functional bounty board platform. Resources: 3 PM platform development.

Task 2.3 (M4-M24): Competition operations. Run quarterly competition events—online simulation rounds and physical 90-second arena validation. Format optimized for social media capture and sharing. Manage registration, submissions, judging, prize distribution. Deliverable: 8 competition cycles with full documentation and social media content. Resources: 4 PM ongoing operations, event venue costs, prize pool (€50,000 total).

Task 2.4 (M6-M24): Community management. Build and maintain participant community—forums, documentation, design sharing, troubleshooting support. Create success stories and promotional content from 90-second competition clips. Deliverable: Active community platform with 500+ members. Resources: 2 PM community management, platform hosting.

---

**WP3: Physical Validation**

*Objectives*: Establish fabrication and testing protocols; validate sim-to-real transfer; generate component reliability data; iterate designs based on real-world performance.

*Description of work*:

Task 3.1 (M3-M6): Fabrication protocol development. Document 3D printing specifications, assembly procedures, testing protocols ensuring builds are comparable across participants. Create bill-of-materials templates for €300 budget compliance. Deliverable: Fabrication guide and compliance verification process. Resources: 2 PM technical documentation, test prints.

Task 3.2 (M4-M24): Sim-to-real validation testing. Structured comparison of simulated versus physical robot performance across competition challenges. Quantify transfer gaps and feed back to simulation improvement. Deliverable: Validation reports for each competition cycle with calibration recommendations. Resources: 8 PM testing and analysis, testing equipment and consumables.

Task 3.3 (M6-M24): Component reliability database. Aggregate failure mode data across competition participants. Document which components survive stress, which fail, under what conditions. Deliverable: Public reliability database covering 100+ components. Resources: 4 PM data collection and analysis.

---

**WP4: Deployment & Commercialization**

*Objectives*: Establish pathway from competition success to revenue-generating maintenance work; secure initial contracts; demonstrate economic sustainability.

*Description of work*:

Task 4.1 (M6-M12): Market development. Engage municipal authorities and industrial facilities as customers. Document maintenance needs suitable for small-robot approach. Negotiate pilot contracts. Deliverable: 5 signed pilot contracts. Resources: 3 PM business development, travel for customer meetings.

Task 4.2 (M10-M24): Deployment operations. Support garage engineers in executing maintenance contracts. Establish quality standards, safety protocols, reporting templates. Collect performance data for continuous improvement. Deliverable: Operational framework and 10 completed contracts. Resources: 4 PM operational support, insurance and liability costs.

Task 4.3 (M18-M24): Sustainability planning. Document business model and unit economics. Prepare platform for self-sustaining operation post-grant. Identify financing needs and sources for geographic expansion. Deliverable: Business plan with 3-year projections. Resources: 1 PM financial modeling.

---

**WP5: Coordination & Portfolio**

*Objectives*: Project management, reporting, portfolio activities, dissemination.

*Description of work*:

Task 5.1 (M1-M24): Project management. Coordination across work packages, risk monitoring, progress reporting, budget management. Resources: 3 PM project management.

Task 5.2 (M1-M24): Portfolio activities. Participation in EIC portfolio events, collaboration with related projects, policy engagement. Deliverable: Portfolio activity reports. Resources: 1 PM as specified in call requirements.

---

**Table 3.1c: List of deliverables**

| No. | Name | Description | WP | Type | Dissem. | Month |
|-----|------|-------------|----|----- |---------|-------|
| 1.1 | Simulation Technical Spec | Architecture and requirements | WP1 | R | PU | M4 |
| 1.2 | Challenge Scenario Library | 20 validated maintenance scenarios | WP1 | OTHER | PU | M8 |
| 1.3 | Training Platform | Functional ML training system | WP1 | OTHER | PU | M12 |
| 2.1 | Competition Rulebook | Rules, judging, safety requirements | WP2 | R | PU | M3 |
| 2.2 | Bounty Board Platform | Functional bounty and sponsor system | WP2 | OTHER | PU | M6 |
| 2.3 | Competition Reports | Results from 8 competition cycles | WP2 | R | PU | M24 |
| 3.1 | Fabrication Guide | 3D printing and assembly protocols | WP3 | R | PU | M6 |
| 3.2 | Sim-to-Real Validation Reports | Transfer accuracy analysis | WP3 | R | PU | M24 |
| 3.3 | Component Reliability Database | Failure modes and performance data | WP3 | DATA | PU | M24 |
| 4.1 | Pilot Contract Portfolio | 5 signed maintenance agreements | WP4 | R | SEN | M12 |
| 4.2 | Operational Framework | Deployment standards and protocols | WP4 | R | PU | M18 |
| 4.3 | Business Plan & Roadmap | Sustainability model and projections | WP4 | R | SEN | M24 |
| 4.4 | Performance Assessment | Benchmark results against objectives | WP4 | R | PU | M24 |

---

**Table 3.1d: Key Performance Indicators and Milestones**

| No. | Name | WP | Month | Means of Verification (KPI) |
|-----|------|----|-------|----------------------------|
| M1 | Simulation platform operational | WP1 | M6 | Platform accepts behavior submissions, runs training cycles |
| M2 | Bounty board live | WP2 | M6 | Platform operational with 5+ bounties posted by field operators |
| M3 | First competition completed | WP2 | M6 | 50+ participants, 20+ physical builds submitted, 90-sec clips shared |
| M4 | Sim-to-real baseline established | WP3 | M9 | Transfer accuracy quantified across 10+ designs |
| M5 | Reproducibility threshold met | WP3 | M12 | At least one design validated by 30+ independent builds |
| M6 | First maintenance contracts signed | WP4 | M12 | 5 contracts with combined value €20K+ |
| M7 | Competition at scale | WP2 | M15 | 200+ cumulative participants, 4 competition cycles completed |
| M8 | Geographic expansion | WP2 | M18 | Participants from 5+ countries |
| M9 | Revenue operations demonstrated | WP4 | M21 | 10 completed contracts, €50K+ cumulative revenue |
| M10 | Sustainability validated | WP4 | M24 | Platform operational costs covered by revenue; business plan for expansion |

---

### 3.2 Applicant description

[To be completed with specific team details]

The project lead brings direct experience in the intersection of robotics education, embedded systems development, and startup scaling:

**Technical expertise**: 15+ years in embedded systems development including ESP32-based IoT systems, industrial automation (UR5 robot integration), LED control systems for cinema production (Digital Sputnik, systems used on Star Wars, Dune, The Batman). Deep understanding of the gap between prototype and production, having navigated Chinese manufacturing relationships and component sourcing challenges.

**Educational delivery**: Current position as university assistant professor teaching robotics at Narva College, developing curricula that combine hardware prototyping, embedded systems, and industrial automation. Proven methodology of Tartu University competition-based learning that produces practical skills rather than theoretical knowledge. Direct experience with student teams building functional robotic systems under €300 budget constraints.

**Startup ecosystem**: Mentor at TalTech accelerator with experience guiding hardware startups through technical and commercial development. Understanding of investor requirements and commercialization pathways for hardware products.

**Geographic and geopolitical context**: Based in Estonia near Russian border, with direct observation of Ukrainian distributed manufacturing success and European security concerns driving interest in manufacturing resilience. Personal history informing understanding of how societies respond to resource constraints and systemic challenges.

**Affiliated entities**: [To be added—university partnership, municipal partners, industrial validation sites]

The team's unique qualification is the combination of technical depth (systems actually built and deployed), educational methodology (students who actually learn), and commercial experience (startups actually funded and products actually manufactured). This is not a research proposal from academics theorizing about distributed manufacturing; it's an operational plan from practitioners who have built the pieces and understand how they connect.