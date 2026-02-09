# Bounty Board: Skill Progression & Passive Income System

## What It Is

**Visual tech tree showing unlockable skills, discovered by the community, not designed by developers.**

Each bounty = challenge to prove you can execute a specific swarm robotics technique in competitive matches. When you unlock a bounty, you earn XP. When others unlock bounties you created, you earn passive royalties.

---

## How It Works

### Bounties Are Discovered, Not Designed

**Traditional game:** Developers create skill tree before launch.

**Robot Arena:** Skills emerge from actual match data.

**Discovery process:**
1. Alice (Berlin) wins a match using adaptive WiFi channel switching
2. Bob (Munich) independently discovers same technique
3. Charlie (Hamburg) also discovers it independently
4. LLM analyzes match logs, detects convergent evolution: "3 pilots found the same strategy"
5. System auto-creates bounty: `tech_087: Adaptive Channel Selection`
6. Alice, Bob, Charlie become "creators" (earn royalties forever)

### Bounty Structure

```yaml
id: tech_087
name: Adaptive Channel Selection
description: >
  Win a match where your swarm switches WiFi channels at least 5 times
  in response to packet loss or interference, maintaining >80% bot
  connectivity throughout the match.

prerequisites:
  - tech_031  # Basic Channel Hopping (must unlock this first)

xp_value: 500
attempts_allowed: 3
verification: automatic  # UART logs checked post-match

creators:
  - alice_berlin
  - bob_munich
  - charlie_hamburg

created: 2025-11-04
status: growing  # lifecycle state (affects XP multiplier)
unlock_count: 47  # 47 pilots have unlocked this so far
```

### Prerequisites Enforce Learning Path

**You can't skip steps:**

```
tech_001: Basic Bot Control (100 XP)
  ↓ (unlocking tech_001 makes tech_031 available)
tech_031: Basic Channel Hopping (250 XP)
  ↓ (unlocking tech_031 makes tech_087 available)
tech_087: Adaptive Channel Selection (500 XP)
  ↓ (unlocking tech_087 makes tech_112 available)
tech_112: Deauth Attack Defense (750 XP)
  ↓ (unlocking tech_112 makes tech_134 available)
tech_134: Signal Strength Optimization (1000 XP)
```

**Why this matters:**
- Forces fundamentals before advanced techniques
- Can't attempt tech_087 unless you've proven you can do tech_031
- Creates natural skill progression
- Pilots improve systematically, not randomly

---

## Three Ways to Earn XP

### 1. Unlock Bounties (Active Income)

**How it works:**
- You compete in a match
- You successfully use tech_087 technique
- Post-match: LLM analyzes your UART logs
- Verification: "Yes, you switched channels 5+ times and maintained 80% connectivity"
- Award: 500 XP + tech_087 unlocked
- Result: tech_112 now available to attempt

**Multipliers based on lifecycle:**
- Emerging (0-30 days old): 1.5x XP (500 × 1.5 = 750 XP)
- Growing (30-90 days old): 1.25x XP (500 × 1.25 = 625 XP)
- Mature (90+ days old): 1.0x XP (500 × 1.0 = 500 XP)
- Declining (<35% win rate): 2.0x XP (500 × 2.0 = 1000 XP!)

**Why multipliers:**
- Early adopters get bonus (encourages trying new techniques)
- Declining techniques get revival bonus (encourages counter-meta innovation)
- Mature techniques = standard value (proven, stable)

### 2. Creator Royalties (Passive Income)

**How it works:**
- You discovered tech_087 (you're a creator)
- Every time someone else unlocks it → you earn 10 XP automatically
- Works even if you stop competing

**Example:**
```
Month 1: Alice creates tech_087, earns 500 XP from unlocking it herself
Month 2: 15 pilots unlock tech_087 → Alice earns 150 XP passively
Month 3: 23 pilots unlock tech_087 → Alice earns 230 XP passively
Month 6: 47 pilots unlock tech_087 → Alice earns 470 XP passively
Month 12: 120 pilots unlock tech_087 → Alice earns 1,200 XP passively

Total passive XP from one bounty: 2,050 XP
(equivalent to unlocking 4 Expert-tier bounties through competition)
```

**Why this matters:**
- Rewards innovation (discovering techniques is more valuable than just using them)
- Creates passive income (you earn XP even when not competing)
- Compounds over time (popular techniques earn royalties for years)
- Encourages sharing (more people learning your technique = more royalties)

### 3. Teacher Credits (Mentorship Income)

**How it works:**
- You help Bob learn tech_087
- Bob declares you as his teacher (via `@BountyAgent teacher alice_berlin`)
- Bob unlocks tech_087 → earns 500 XP
- You automatically earn 50% of Bob's XP = 250 XP
- Works for every bounty your students unlock

**Example:**
```
Alice teaches 5 students
Each student unlocks average 3 bounties (500 XP each)

Calculation:
5 students × 3 bounties × 500 XP × 50% = 3,750 XP for Alice

That's enough XP to progress from Apprentice (0-2,500 XP)
to Journeyman (2,500-10,000 XP) just from teaching.
```

**Why this matters:**
- Rewards mentorship (teaching is valuable)
- Creates social bonds (students loyal to teachers)
- Scales exponentially (your students teach others, you still get credited)
- Multiple income streams (compete + create + teach = 3 ways to earn)

---

## Bounty Lifecycle States

**Bounties evolve through 5 states based on usage and effectiveness:**

### 1. Emerging (0-30 days old, <10 unlocks)
- **XP Multiplier:** 1.5x
- **Survival Rule:** Get 10 unlocks in 30 days OR get archived
- **Purpose:** Early adopter bonus, test if technique is viable

**Example:**
```
tech_187: Frequency Hopping Spread Spectrum
Created: 2025-12-01
Status: Emerging
XP Value: 600 × 1.5 = 900 XP
Unlocks so far: 3
Time remaining: 22 days to hit 10 unlocks
```

### 2. Growing (30-90 days old, 10-50 unlocks)
- **XP Multiplier:** 1.25x
- **Survival Rule:** Maintain >40% win rate OR move to Declining
- **Purpose:** Technique is spreading, still rewarding to unlock

**Example:**
```
tech_087: Adaptive Channel Selection
Created: 2025-11-04
Status: Growing
XP Value: 500 × 1.25 = 625 XP
Unlocks: 47
Win rate when used: 52% (healthy)
```

### 3. Mature (90+ days old, 50+ unlocks)
- **XP Multiplier:** 1.0x
- **Survival Rule:** Maintain >35% win rate OR move to Declining
- **Purpose:** Proven, stable meta strategy

**Example:**
```
tech_031: Basic Channel Hopping
Created: 2025-09-15
Status: Mature
XP Value: 250 × 1.0 = 250 XP
Unlocks: 178
Win rate when used: 48% (stable)
```

### 4. Declining (<35% win rate for 60 days)
- **XP Multiplier:** 2.0x (revival bonus!)
- **Survival Rule:** Return to >40% win rate in 90 days OR get archived
- **Purpose:** Encourage counter-meta innovation

**Example:**
```
tech_042: Collision Recovery Patterns
Created: 2025-08-20
Status: Declining
XP Value: 300 × 2.0 = 600 XP (revival bonus!)
Unlocks: 89 total, but only 3 in last 60 days
Win rate: 28% (meta shifted, technique no longer effective)

Revival opportunity: Find new way to use this technique,
earn 2x XP for solving the puzzle.
```

### 5. Archived (0 usage for 60 days)
- **XP Multiplier:** N/A (cannot attempt)
- **Survival Rule:** Community vote to revive (requires proof of viability)
- **Purpose:** Preserve history without cluttering active tree

**Example:**
```
tech_023: Static Channel Assignment
Archived: 2025-10-15
Reason: Superseded by tech_031 (dynamic channel hopping)
Unlocks: 45 total, 0 in last 60 days
Status: Preserved in git history, removed from active bounty board

Can be revived if someone proves it works in modern meta.
```

---

## Skill Gates (Progression Tiers)

**Five tiers unlock as you accumulate XP:**

### Apprentice (0-2,500 XP)
- **Unlocks:** tech_001-025
- **Badge:** Bronze gear sigil
- **Focus:** Basic bot control, simple formations, goal-seeking
- **Entry:** Complete first match (win or lose)

### Journeyman (2,500-10,000 XP)
- **Unlocks:** tech_026-075
- **Badge:** Silver coil sigil
- **Focus:** Channel hopping, collision recovery, multi-channel coordination
- **Entry:** 2,500 XP + 3 wins using Apprentice techniques

### Expert (10,000-30,000 XP)
- **Unlocks:** tech_076-150
- **Badge:** Gold sparks sigil
- **Focus:** Adaptive channel selection, deauth defense, signal optimization
- **Entry:** 10,000 XP + 10 wins using Journeyman techniques

### Master (30,000-100,000 XP)
- **Unlocks:** tech_151-250
- **Badge:** Platinum eye sigil
- **Focus:** Advanced jamming resistance, protocol exploitation, swarm resilience
- **Entry:** 30,000 XP + 20 wins + 1 original technique contribution

### Grandmaster (100,000+ XP)
- **Unlocks:** tech_251+
- **Badge:** Diamond fractal sigil
- **Focus:** Cutting-edge experimental strategies (pre-publication research)
- **Entry:** 100,000 XP + 50 wins + 5 original technique contributions

**Why gates matter:**
- You can only attempt bounties in unlocked tiers
- Can't skip to Master-level techniques without fundamentals
- Creates clear progression path
- Grandmaster = proven innovator (5 techniques discovered)

---

## Bounty Board UI

### Discord Interface

**Command:** `@BountyAgent available`

**Response:**
```
You have 12 bounties available based on your tech tree:

🎯 RECOMMENDED (Best XP/Difficulty):

tech_087: Adaptive Channel Selection
├─ XP Value: 500 (1.25x Growing = 625 XP)
├─ Difficulty: Medium
├─ Win Rate: 52% (slightly favors skilled pilots)
├─ Prerequisites: ✅ tech_031 (you have this)
├─ Created by: alice_berlin, bob_munich, charlie_hamburg
├─ Unlocks: 47 pilots so far (you'd be #48)
└─ Attempts remaining: 3

tech_098: Jamming Pattern Recognition
├─ XP Value: 600 (1.5x Emerging = 900 XP!)
├─ Difficulty: Hard
├─ Win Rate: 41% (very challenging)
├─ Prerequisites: ✅ tech_031 (you have this)
├─ Created by: david_prague
├─ Unlocks: 8 pilots so far (early adopter bonus!)
└─ Attempts remaining: 3

🔥 REVIVAL BONUS (2x XP):

tech_042: Collision Recovery Patterns
├─ XP Value: 300 (2.0x Declining = 600 XP!)
├─ Difficulty: Easy
├─ Win Rate: 28% (meta shifted, needs innovation)
├─ Prerequisites: ✅ tech_015 (you have this)
├─ Created by: eve_tallinn
├─ Unlocks: 3 in last 60 days (help revive this!)
└─ Attempts remaining: 3

Type "@BountyAgent attempt tech_087" to try in your next match.
```

### Web Interface

**Visual Tech Tree:**
```
[Interactive node graph]

Node colors:
- Green = available (you can attempt now)
- Yellow = almost ready (1 prerequisite away)
- Red = locked (need multiple prerequisites)
- Gray = archived (cannot attempt)
- Purple = declining (2x XP revival bonus!)

Hover on node → tooltip shows:
- Bounty name
- XP value (with multiplier)
- Prerequisites (✅ unlocked / 🔒 locked)
- Difficulty rating
- Win rate when used
- Creator names
- Unlock count
- Your attempts remaining

Click node → detailed view:
- Full description
- Strategy guide (from creators)
- Winning examples (match replays)
- Blueprint library (exportable code)
- Discussion thread (ask questions)
```

**Your Profile:**
```
Total XP: 12,750
Rank: Expert (10,000-30,000 XP)
Progress to Master: 17,250 XP remaining

Unlocked Bounties: 23
Available Bounties: 18
Locked Bounties: 34

Creator Stats:
├─ Bounties created: 2 (tech_087, tech_134)
├─ Total unlocks by others: 94
└─ Passive XP earned: 940 (94 × 10)

Teacher Stats:
├─ Students taught: 7
├─ Student unlocks: 31
└─ Teaching XP earned: 3,875 (31 × 250 × 50%)

Blueprint Stats:
├─ Blueprints shared: 5
├─ Times used by others: 38
└─ Blueprint XP earned: 950 (38 × 25)

Total passive income: 5,765 XP (45% of your total XP!)
```

---

## Blueprint System (Strategy Sharing)

### Exporting Blueprints

**After winning a match using a bounty:**
1. Go to match replay
2. Click "Export Blueprint" button
3. System extracts your code from UART logs
4. Generates shareable blueprint string

**Blueprint format:**
```
blueprint://eyJpZCI6ICJicF80NTYiLCAiYm91bnR5IjogInRlY2hfMDg3IiwgImNyZWF0b3IiOiAiYWxpY2VfYmVybGluIiwgImNvZGUiOiAiZGVmIGFkYXB0aXZlX2NoYW5uZWxfc3dpdGNoKCk6XG4gICAgaWYgcGFja2V0X2xvc3MgPiAwLjI6XG4gICAgICAgIHN3aXRjaF9jaGFubmVsKCkiLCAiY3JlYXRlZCI6ICIyMDI1LTExLTA0VDEyOjM0OjU2WiIsICJmb3JrX2NvdW50IjogMTIsICJhdHRyaWJ1dGlvbiI6IHsidGVhY2hlciI6ICJib2JfbXVuaWNoIiwgImJyYW5jaF9jcmVhdG9ycyI6IFsiYWxpY2VfYmVybGluIiwgImJvYl9tdW5pY2giLCAiY2hhcmxpZV9oYW1idXJnIl19fQ==
```

**Contains:**
- Bounty ID (tech_087)
- Your code implementation
- Attribution chain (you, your teacher, bounty creators)
- Timestamp
- Fork count (how many people have used this)

### Importing Blueprints

**Someone shares a blueprint link:**
1. Click link or paste into import box
2. System shows preview:
   - Code implementation
   - Which bounty it's for
   - Creator name
   - How many times it's been forked
3. Click "Import" → code loads into your editor
4. Modify if needed, use in your next match

**Royalty tracking:**
- When you use imported blueprint in a match → original creator earns 25 XP
- Works even if you modify the code (tracked by blueprint ID)
- Attribution is permanent (can't steal credit)

### Blueprint Library

**Browse by:**
- Bounty (all blueprints for tech_087)
- Creator (all blueprints by alice_berlin)
- Popularity (most forked blueprints)
- Recent (newest blueprints)
- Rated (community upvotes best implementations)

**Example library entry:**
```
tech_087: Adaptive Channel Selection

Blueprint #bp_456 by alice_berlin
├─ Forks: 38
├─ Rating: 4.7/5 (24 ratings)
├─ Created: 2025-11-04
├─ Description: "Switches channels when packet loss >20%, uses exponential backoff"
├─ Code preview: [expandable]
└─ Your royalties if you use this: alice_berlin earns 25 XP

Blueprint #bp_512 by bob_munich
├─ Forks: 19
├─ Rating: 4.2/5 (11 ratings)
├─ Created: 2025-11-08
├─ Description: "More aggressive switching at >15% loss, faster but riskier"
├─ Code preview: [expandable]
└─ Your royalties if you use this: bob_munich earns 25 XP
```

---

## Revenue Model

**Bounty Board doesn't charge fees—it creates value through retention.**

### Direct Revenue: None

Platform doesn't take cut of XP or charge for unlocking bounties.

### Indirect Revenue: Massive

**1. Dataset Value Increases**
- Tech tree = structured knowledge layer on top of raw match data
- Dataset buyers pay premium for "UART logs + bounty taxonomy"
- Academic tier: €5k/year (logs only) vs €8k/year (logs + bounties)
- Commercial tier: €50k/year (logs only) vs €100k/year (logs + bounties)

**2. Retention Increases**
- Passive income keeps pilots engaged even when not competing
- More pilots = more matches = more dataset volume
- Long-term pilots = higher skill = better match quality = higher sponsor value

**3. Betting Interest Increases**
- Bounty board reveals which techniques pilots might use
- Bettors analyze tech trees: "Alice just unlocked tech_134, she'll probably use it"
- More strategic betting = higher betting volume = more commission

**4. Sponsor Value Increases**
- Tech tree = proof of skill progression (XP visible on profiles)
- Sponsors can target teams by XP tier (Expert vs Grandmaster)
- Creator royalties = pilots have incentive to stay engaged long-term
- Stable community = predictable sponsor ROI

**Example value calculation:**
```
Without Bounty Board:
- Pilot competes for 6 months
- Earns XP only from wins
- Stops competing → earns nothing → loses interest
- Churn rate: 70% per year

With Bounty Board:
- Pilot competes for 6 months
- Earns XP from wins + creates 1 bounty
- Stops competing → still earns passive royalties
- Passive income keeps them engaged
- Returns to compete 6 months later (didn't churn)
- Churn rate: 30% per year

Impact:
- 70% churn → 30 pilots stay after Year 1 (out of 100)
- 30% churn → 70 pilots stay after Year 1 (out of 100)
- 2.3x more pilots = 2.3x more matches = 2.3x more dataset value
- 2.3x multiplier on all revenue streams
```

---

## Example Scenarios

### Scenario 1: New Pilot Progression

**Week 1:**
- Alex joins Robot Arena, competes in first match
- Unlocks tech_001: Basic Bot Control (100 XP)
- Rank: Apprentice (0-2,500 XP)

**Week 4:**
- Alex unlocks 5 more Apprentice bounties
- Total XP: 1,200
- Still Apprentice, but 12 more bounties now available

**Week 12:**
- Alex unlocks tech_031: Basic Channel Hopping (250 XP)
- Total XP: 2,750
- Rank: Journeyman (2,500-10,000 XP)
- 25 new bounties unlocked (Journeyman tier)

**Week 24:**
- Alex creates first original technique (convergent evolution detected)
- Becomes creator of tech_198: Mesh Network Fallback
- Earns 800 XP from unlocking it
- Total XP: 8,500

**Week 52 (1 year):**
- Alex's tech_198 has been unlocked by 47 pilots
- Passive royalties: 470 XP (47 × 10)
- Alex taught 3 students, earning 1,500 XP from teacher credits
- Total XP: 15,000
- Rank: Expert (10,000-30,000 XP)

### Scenario 2: Veteran Creates Popular Bounty

**Month 1:**
- Diana (Grandmaster, 120,000 XP) discovers new technique
- LLM creates tech_245: Predictive Channel Allocation
- Diana is sole creator

**Month 2-12:**
- 200 pilots unlock tech_245 (high-value technique)
- Diana earns: 200 × 10 = 2,000 XP passively
- Equivalent to unlocking 4 Expert-tier bounties just from royalties

**Year 2:**
- Another 300 pilots unlock tech_245
- Diana earns: 300 × 10 = 3,000 XP passively
- Total passive income from this one bounty: 5,000 XP

**Year 3:**
- Diana takes 6-month break (job, family)
- Still earning royalties (150 more unlocks)
- Earns 1,500 XP without competing
- Returns with higher XP than when she left

### Scenario 3: Teacher Builds Network

**Month 1:**
- Marcus (Expert, 18,000 XP) starts mentoring
- Takes on 5 students (all Apprentices)

**Month 3:**
- Students collectively unlock 20 bounties (average 4 each)
- Marcus earns: 20 × 250 (avg XP) × 50% = 2,500 XP
- Enough to progress from Expert to near-Master rank

**Month 6:**
- Marcus's students teach their own students
- Marcus still credited as "grandteacher" (10% royalty)
- Second-generation students unlock 30 bounties
- Marcus earns: 30 × 250 × 10% = 750 XP

**Year 1:**
- Marcus's teaching network: 5 direct students, 12 second-gen students
- Total unlocks by network: 85 bounties
- Marcus earned: 6,000 XP from teaching (30% of his total XP)
- Becomes known as top mentor → attracts more students → compounds

---

## Why This Works

### For Pilots

**Multiple income streams:**
- Compete actively (unlock bounties)
- Create passively (earn royalties)
- Teach others (earn teacher credits)
- Share blueprints (earn usage royalties)

**Permanent progress:**
- XP never decays
- Can take breaks without losing value
- Passive income continues even when inactive

**Portable credentials:**
- XP shows on LinkedIn/resume
- Proves expertise in swarm robotics, IoT security, AI-assisted coding
- Converts to dataset access (research/commercial value)

### For Platform

**Retention:**
- 70% less churn (passive income keeps pilots engaged)
- Longer engagement = more matches = more dataset volume
- Veterans stay as mentors even when not competing

**Dataset value:**
- Tech tree = structured knowledge layer (worth 2x premium)
- Bounty taxonomy makes data searchable, usable
- Buyers pay for "documented strategies" not just "raw logs"

**Network effects:**
- More pilots = more bounties discovered
- More bounties = richer meta
- Richer meta = more betting interest, sponsor value
- Higher sponsor value = bigger prize pools
- Bigger prizes = attracts better pilots
- Loop accelerates

### For Ecosystem

**Knowledge compounds:**
- Every match adds to collective intelligence
- Techniques documented automatically (no manual curation)
- Tech tree grows organically (living system, not static design)

**Fair attribution:**
- Creators credited permanently
- Royalties ensure innovators benefit from adoption
- Teachers compensated for mentorship
- Blueprint authors earn from sharing

**Anti-winner-takes-all:**
- Mid-tier pilots earn meaningful value (not just top 1%)
- Multiple paths to success (compete, create, teach, curate)
- Passive income democratizes earnings

---

For league governance, see [README.md](README.md).

For sponsor matching, see [SPONSOR-BOARD.md](SPONSOR-BOARD.md).

For dataset economics, see [../01-knowledge-commons/README.md](../01-knowledge-commons/README.md).
