# The Board: Four Guild Markets

**The Board is MechArena's unified crowdfunding platform with four specialized markets, each represented by a guild sigil.**

Think Kickstarter meets skill progression: anyone can post a challenge, opportunity, or need. Others back it with money or XP. When goals are met, rewards distribute automatically. Your rating on each board determines tournament eligibility.

---

## The Four Guilds (Board Types)

Each board type has a guild sigil used throughout the ecosystem:

### ⟡ Skills Guild (Bronze Fractured Gear)
**Discover and unlock swarm robotics techniques**
- Post: New technique discovered in matches
- Back: Attempt to unlock it (earn XP)
- Rating: Total XP + techniques unlocked
- **Tournament entry filter:** "Expert tier only (10k-30k XP)"

### ⚡ Challenges Guild (Silver Lightning Bolt)
**Fund specific technical problems**
- Post: €X bounty for solving Y problem
- Back: Add money to prize pool
- Rating: Bounties completed + difficulty solved
- **Tournament entry filter:** "Solved 5+ hard bounties required"

### ⚙ Hardware Guild (Gold Ascending Coil)
**Retrofit and customize obsolete robotics**
- Post: "I resurrected X robot with Y modifications"
- Back: Remix the design, contribute improvements
- Rating: Resurrections completed + remix count
- **Tournament entry filter:** "Custom hardware only"

### ⭐ Sponsorship Guild (Platinum Twin Sparks)
**Match teams with funding**
- Post: Team seeking €X for season
- Back: Sponsor pledges funding
- Rating: Team performance + sponsor ROI + content reach
- **Tournament entry filter:** "€2k+ backing required"

---

## How The Board Works (Like Kickstarter)

### Posting (Creating Campaigns)

**Anyone can post to any guild:**

```
CHALLENGE POST (⚡ Challenges Guild)

Title: Master WiFi Channel Hopping Under Jamming
Posted by: Siemens (sponsor)
Guild: ⚡ Challenges
Bounty: €5,000
Goal: 10 pilots complete this
Progress: 3/10 (30%)
Time remaining: 45 days

Requirements:
- Switch channels 5+ times during match under jamming
- Maintain 80% bot connectivity
- Win the match

Reward split: €500 per successful pilot + 1,000 XP
```

```
HARDWARE POST (⚙ Hardware Guild)

Title: Roomba 560 Resurrection with Phone + ESP32
Posted by: eve_tallinn
Guild: ⚙ Hardware
Design files: GitHub link
Cost: €50 retrofit (Awakening Module)
Remixes: 12 variants created
Upvotes: 87

Description: How to retrofit 2008 Roomba 560 with old phone + ESP32 over USB UART,
enable WiFi control, phone camera POV, compete in Arena matches.

Remix rewards: €5 per validated remix (funded by bot rental revenue)
```

```
SPONSORSHIP POST (⭐ Sponsorship Guild)

Title: Red Sparks Seeking Season 3 Backing
Posted by: Red Sparks (Berlin team)
Guild: ⭐ Sponsorship
Asking: €2,000
Goal: Fund full season (12 matches)
Progress: €1,200/€2,000 (60%)
Time remaining: 15 days

Offering:
- Logo on jersey (all match videos)
- 4 Instagram posts/month (3.2k followers)
- Behind-the-scenes content access
- Sponsor booth at Berlin championship

Backers: Siemens (€800), TU Berlin (€400)
```

```
SKILLS POST (⟡ Skills Guild)

Title: tech_087 - Adaptive Channel Selection
Posted by: System (auto-detected convergent evolution)
Guild: ⟡ Skills
Discovered by: alice_berlin, bob_munich, charlie_hamburg
XP Value: 500 (1.25x Growing = 625 XP)
Unlocked by: 47 pilots
Prerequisites: tech_031 (Basic Channel Hopping)

Description: Switch WiFi channels automatically when packet
loss exceeds 20%, maintain swarm connectivity.

Unlock: Complete in match → earn 625 XP
Creators earn: 10 XP per unlock (passive royalty)
```

### Backing (Funding Campaigns)

**Three ways to back:**

1. **Money (⚡ Challenges, ⭐ Sponsorship)**
   - Add to prize pool
   - Sponsor a team
   - Fund hardware bounty

2. **XP (⟡ Skills)**
   - Attempt to unlock technique
   - Earn XP if successful
   - Creators earn royalty

3. **Work (⚙ Hardware)**
   - Remix design
   - Contribute improvements
   - Earn € from remix pool

### Rewards (When Goals Met)

**Automatic distribution:**

```
CHALLENGES GUILD REWARD:
Goal reached: 10/10 pilots completed bounty
Prize pool: €5,000
Distribution: €500 per pilot (split equally)
Platform fee: €250 (5% of pool)
Siemens gets: Contact info of all 10 pilots (recruitment)
```

```
SKILLS GUILD REWARD:
You unlocked tech_087
You earn: 625 XP (500 base × 1.25 multiplier)
Creators earn: 10 XP each (alice, bob, charlie)
Tech tree updated: tech_112 now available to you
```

```
HARDWARE GUILD REWARD:
Your Roomba remix validated
You earn: €5 (from remix pool)
Original poster earns: €2 royalty
Design enters commons: Free for all to use
```

```
SPONSORSHIP GUILD REWARD:
Goal reached: €2,000 funded
Team receives: €1,900 (after 5% platform fee)
Season begins: 12 matches scheduled
Deliverables tracked: Instagram posts, content access
End of season: Sponsor reviews performance, decides on renewal
```

---

## Guild Ratings (Your Score on Each Board)

### ⟡ Skills Guild Rating

**Calculated from:**
- Total XP earned
- Techniques unlocked
- Creator royalties (techniques you discovered)
- Teacher credits (students you mentored)

**Rating tiers:**
```
Apprentice:   0-2,500 XP
Journeyman:   2,500-10,000 XP
Expert:       10,000-30,000 XP
Master:       30,000-100,000 XP
Grandmaster:  100,000+ XP
```

**Example profile:**
```
alice_berlin
⟡ Skills Rating: 18,500 XP (Expert tier)
├─ Techniques unlocked: 23
├─ Created: 2 (tech_087, tech_134)
├─ Passive royalties earned: 940 XP
└─ Students taught: 7
```

### ⚡ Challenges Guild Rating

**Calculated from:**
- Bounties completed
- Average difficulty solved
- Success rate
- Total prize money earned

**Rating tiers:**
```
Novice:       0-5 bounties
Solver:       5-15 bounties
Expert:       15-30 bounties
Master:       30-50 bounties
Legend:       50+ bounties
```

**Example profile:**
```
bob_munich
⚡ Challenges Rating: Expert (18 bounties completed)
├─ Easy bounties: 8 (€4,500 earned)
├─ Medium bounties: 7 (€12,000 earned)
├─ Hard bounties: 3 (€15,000 earned)
├─ Success rate: 72% (18/25 attempts)
└─ Total earned: €31,500
```

### ⚙ Hardware Guild Rating

**Calculated from:**
- Resurrections completed
- Remix count
- Community upvotes
- Validation quality

**Rating tiers:**
```
Tinkerer:     1-3 resurrections
Builder:      3-10 resurrections
Engineer:     10-20 resurrections
Architect:    20-50 resurrections
Master:       50+ resurrections
```

**Example profile:**
```
charlie_hamburg
⚙ Hardware Rating: Engineer (12 resurrections)
├─ Roomba series: 4 models
├─ Starter Class mods: 6 variants
├─ Custom builds: 2 designs
├─ Total remixes by others: 89
└─ Remix royalties earned: €445
```

### ⭐ Sponsorship Guild Rating

**Calculated from:**
- Team win rate
- Sponsor ROI (did they renew?)
- Content reach (followers, views)
- Betting interest (community engagement)

**Rating tiers:**
```
Amateur:      0-40% win rate
Semi-Pro:     40-55% win rate
Professional: 55-70% win rate
Elite:        70-85% win rate
Champion:     85%+ win rate
```

**Example profile:**
```
Red Sparks (Berlin)
⭐ Sponsorship Rating: Professional (62% win rate)
├─ Season record: 19 wins, 12 losses
├─ Sponsors: 3 active (€4,500 total)
├─ Content reach: 5.7k followers
├─ Betting interest: €18,500 wagered on team
├─ Sponsor renewals: 2/2 (100% retention)
└─ Average sponsor ROI: 3.2x (views per € spent)
```

---

## Tournament Entry Filters

**Tournaments check your guild ratings:**

### Single-Guild Tournaments

```
TOURNAMENT: Apprentice Cup
Entry requirements:
├─ ⟡ Skills: 500-2,500 XP only
└─ (No other guild requirements)

Prize: €500
Purpose: Beginner-friendly
```

```
TOURNAMENT: Master Solver Championship
Entry requirements:
├─ ⚡ Challenges: 30+ bounties completed
└─ (No other guild requirements)

Prize: €10,000
Purpose: Elite problem-solvers
```

```
TOURNAMENT: Hardware Innovators Cup
Entry requirements:
├─ ⚙ Hardware: 10+ resurrections
└─ Must compete with custom hardware
└─ (No other guild requirements)

Prize: €5,000 + coverage in Make Magazine
Purpose: Showcase unique builds
```

```
TOURNAMENT: Sponsored Team Championship
Entry requirements:
├─ ⭐ Sponsorship: €2,000+ active backing
└─ (No other guild requirements)

Prize: €20,000
Purpose: Professional circuit
```

### Multi-Guild Tournaments

```
TOURNAMENT: Berlin Grand Championship
Entry requirements (ALL must be met):
├─ ⟡ Skills: 15,000+ XP (Expert tier)
├─ ⚡ Challenges: 5+ bounties completed
├─ ⚙ Hardware: 3+ resurrections OR custom build
└─ ⭐ Sponsorship: €1,000+ backing OR 60%+ win rate

Prize: €25,000
Funded by: Siemens (€15k) + Community (€10k)
Purpose: Premier event, multi-guild excellence
```

```
TOURNAMENT: Rising Stars Cup
Entry requirements (ANY ONE met):
├─ ⟡ Skills: 5,000-15,000 XP (Journeyman to Expert)
├─ ⚡ Challenges: 3-10 bounties
├─ ⚙ Hardware: 1-5 resurrections
└─ ⭐ Sponsorship: First season with backing

Prize: €2,000
Purpose: Mid-tier showcase
```

---

## Guild Sigils (Visual Identity)

**Each guild has a sigil used throughout the ecosystem:**

### ⟡ Skills Guild
**Symbol:** Bronze Fractured Gear (7 fragments)
**Color:** Bronze/Copper (#CD7F32)
**Philosophy:** "Imperfection is the beginning of mastery"
**Usage:**
- Badge on pilot profiles
- Icon next to XP scores
- Tournament posters for skills-based events
- Discord role badge

### ⚡ Challenges Guild
**Symbol:** Silver Lightning Bolt (jagged, dynamic)
**Color:** Silver/Electric Blue (#C0C0C0, #00BFFF)
**Philosophy:** "Solutions emerge from pressure"
**Usage:**
- Badge on bounty posts
- Icon next to prize pools
- Tournament posters for solver events
- Discord role badge

### ⚙ Hardware Guild
**Symbol:** Gold Ascending Coil (spiral rising through triangle)
**Color:** Gold/Brass (#FFD700)
**Philosophy:** "Resurrection through transformation"
**Usage:**
- Badge on hardware posts
- Icon next to resurrection guides
- Tournament posters for custom hardware events
- Discord role badge

### ⭐ Sponsorship Guild
**Symbol:** Platinum Twin Sparks (two dots connected by lightning)
**Color:** Platinum/White (#E5E4E2)
**Philosophy:** "Unity between old hardware and new intelligence"
**Usage:**
- Badge on team profiles
- Icon next to sponsorship deals
- Tournament posters for sponsored events
- Discord role badge

**Guild combinations:**
- Pilots can be members of multiple guilds (most are)
- Profile shows all guild badges earned
- Tournament posters show required guild sigils
- Discord roles stack (e.g., @SkillsExpert @ChallengesSolver)

---

## Event Presentations by Guild

**At physical events, guild banners displayed prominently:**

### Tournament Entrance
```
┌─────────────────────────────────────────┐
│     BERLIN GRAND CHAMPIONSHIP 2026     │
│                                         │
│  Required Guilds:                       │
│  ⟡ Expert (15k+ XP)                    │
│  ⚡ Solver (5+ bounties)               │
│  ⚙ Engineer (3+ builds)                │
│  ⭐ Professional (€1k+ backing)         │
│                                         │
│  Prize Pool: €25,000                    │
│  Funded by: Siemens ⭐ + Community ⚡   │
└─────────────────────────────────────────┘
```

### Pilot Introductions
```
Announcer: "Competing for Team Red, alice_berlin!"

Display screen shows:
┌──────────────────────────────────────┐
│  ALICE_BERLIN                        │
│  ⟡ Expert (18,500 XP)               │
│  ⚡ Solver (12 bounties)            │
│  ⚙ Builder (4 resurrections)        │
│  ⭐ Professional (62% win rate)      │
│                                      │
│  Notable: Created tech_087, tech_134 │
│  Taught: 7 students                  │
└──────────────────────────────────────┘
```

### Guild-Specific Side Events

**Skills Guild Showcase:**
- Live tech tree visualization on screens
- Real-time XP updates during matches
- "Unlocked!" animations when pilot uses new technique
- Creator royalties tracker (see passive XP flowing)

**Challenges Guild Showcase:**
- Bounty board displayed on walls
- Live progress bars for active bounties
- Winner announcements when goals hit
- Prize distribution ceremonies

**Hardware Guild Showcase:**
- Physical display of resurrected robots
- QR codes linking to build guides
- Remix galleries (3D-printed parts, custom sensors)
- Live hardware hacking workshop area

**Sponsorship Guild Showcase:**
- Sponsor logos prominently displayed
- Team content feeds (Instagram walls)
- Live betting odds boards
- Sponsor ROI dashboards (views, engagement metrics)

---

## Platform Revenue Model

**The Board takes 5-10% commission on all transactions:**

### ⟡ Skills Guild Revenue
**No direct fees** - value created through retention and dataset quality
- Pilots stay engaged longer (passive XP income)
- Better pilots = better match data = higher dataset licensing prices
- Skills ratings used by sponsors to target teams

### ⚡ Challenges Guild Revenue
**10% commission on prize pools**

```
Example:
Siemens posts €10k bounty
Others add €2.5k
Total pool: €12.5k
Winners split: €11,250
Platform keeps: €1,250 (10%)
```

**Year 1 target:** 20 bounties × €5k average = €100k volume → €10k revenue

### ⚙ Hardware Guild Revenue
**5% of remix royalties + hardware rental cuts**

```
Example:
eve_tallinn posts Roomba resurrection
12 remixes created
Remix pool funded by rental revenue: €600
Remixers earn: €5 each = €60 total
Original creator: €2 × 12 = €24
Platform: €600 × 5% = €30
Remainder funds next remix pools
```

**Year 1 target:** 50 resurrections × €10 average = €500 volume → €25 revenue (plus rental income)

### ⭐ Sponsorship Guild Revenue
**5% facilitation fee + 10% on prize distribution**

```
Example:
Team gets €2k sponsorship (content-only)
Platform: €2k × 5% = €100

Team gets €5k sponsorship + 45% prize split
Team wins €3k in prizes
Sponsor's share: €3k × 45% = €1,350
Platform: €5k × 5% + €1,350 × 10% = €250 + €135 = €385
```

**Year 1 target:** 20 teams × €2k average = €40k volume → €2k revenue

**Total Year 1 Board Revenue:** €12,375
**Year 3 target (100 teams, mature ecosystem):** €60k/year

---

## How Guilds Interconnect

**Flywheel effects between guilds:**

### Skills → Sponsorship
- High XP pilots attract sponsors (proven skill)
- Sponsors filter teams by Skills Guild rating
- "Only sponsor Expert+ tier pilots"

### Challenges → Skills
- Solving bounties often creates new techniques
- New techniques become Skills Guild posts (convergent evolution)
- Challenge solvers become technique creators (passive XP income)

### Hardware → Challenges
- Unique hardware enables solving specific bounties
- "Lidar-based navigation bounty" requires Hardware Guild builds
- Hardware innovations unlock new challenge categories

### Sponsorship → Challenges
- Sponsors fund challenge bounties (recruitment tool)
- Teams competing for sponsorship solve visible bounties (proof of skill)
- Sponsor renewals depend on challenge performance

**Example complete loop:**
```
1. Siemens posts €10k bounty on ⚡ Challenges Guild
   "Develop swarm coordination for warehouse logistics"

2. alice_berlin (⟡ Expert, 18k XP) solves it
   Earns €10k prize + 1,500 XP

3. Solution becomes tech_189 on ⟡ Skills Guild
   alice_berlin now creator, earns 10 XP per unlock

4. alice_berlin's XP increases to 19,500
   ⭐ Sponsorship rating improves (solver credibility)

5. Siemens sponsors alice_berlin's team for €5k
   Wants access to her warehouse logistics technique

6. alice_berlin builds custom Lidar bot (⚙ Hardware Guild)
   Publishes resurrection guide, earns remix royalties

7. alice_berlin teaches technique to 5 students
   Earns 50% of their XP (teacher credits)

8. Students compete in tournaments using tech_189
   alice_berlin earns passive royalties (10 XP per unlock)

9. Siemens sees ROI (hired 3 students, deployed alice's technique)
   Renews sponsorship for Season 2 (€7.5k)

10. alice_berlin's ⭐ Sponsorship rating: 100% renewal rate
    Attracts more sponsors, posts higher on Sponsorship Guild board
```

---

## Technical Implementation

### Board Backend (Single Database)

**PostgreSQL schema:**

```sql
-- Unified posts table (all four guilds)
CREATE TABLE board_posts (
  id SERIAL PRIMARY KEY,
  guild_type VARCHAR(20), -- 'skills', 'challenges', 'hardware', 'sponsorship'
  title TEXT,
  posted_by VARCHAR(100),
  created_at TIMESTAMP,
  goal_type VARCHAR(20), -- 'xp', 'money', 'remixes', 'backing'
  goal_value DECIMAL,
  current_value DECIMAL,
  deadline TIMESTAMP,
  status VARCHAR(20), -- 'active', 'funded', 'completed', 'expired'
  metadata JSONB -- guild-specific fields
);

-- Backing/funding table
CREATE TABLE board_backs (
  id SERIAL PRIMARY KEY,
  post_id INTEGER REFERENCES board_posts(id),
  backer_id VARCHAR(100),
  amount DECIMAL, -- money or XP
  backed_at TIMESTAMP
);

-- Guild ratings table
CREATE TABLE guild_ratings (
  pilot_id VARCHAR(100) PRIMARY KEY,
  skills_xp INTEGER DEFAULT 0,
  challenges_completed INTEGER DEFAULT 0,
  challenges_earned DECIMAL DEFAULT 0,
  hardware_resurrections INTEGER DEFAULT 0,
  hardware_remixes INTEGER DEFAULT 0,
  sponsorship_win_rate DECIMAL DEFAULT 0,
  sponsorship_backing_total DECIMAL DEFAULT 0
);
```

### Board Frontend (Single Interface)

**Four-tab navigation:**

```
┌──────────────────────────────────────────────────────────────┐
│  THE BOARD                                                    │
├──────────────────────────────────────────────────────────────┤
│  ⟡ Skills  │  ⚡ Challenges  │  ⚙ Hardware  │  ⭐ Sponsorship │
└──────────────────────────────────────────────────────────────┘

Currently viewing: ⚡ Challenges Guild

Filter by:
[All] [Active] [Funded] [Completed]

Sort by:
[Prize value ▼] [Time remaining] [Difficulty] [Popularity]

┌─────────────────────────────────────────────────────────────┐
│ Master WiFi Channel Hopping Under Jamming                   │
│ ⚡ Challenge • Posted by Siemens • 45 days remaining        │
│                                                              │
│ ██████████░░░░░░░░░░░░░░░░░░░░ 30% (3/10 pilots)           │
│                                                              │
│ Prize: €5,000 (€500 per pilot)                              │
│ Requirements: Switch channels 5+ times under jamming        │
│                                                              │
│ [View Details] [Attempt Challenge] [Add to Prize Pool]      │
└─────────────────────────────────────────────────────────────┘

[12 more challenges...]
```

### Discord Integration

**Bot commands for each guild:**

```
@BoardBot skills available
→ Shows your unlockable techniques with XP values

@BoardBot challenges browse hard
→ Shows hard-difficulty bounties you're qualified for

@BoardBot hardware search roomba
→ Shows all Roomba resurrection guides

@BoardBot sponsorship teams berlin
→ Shows Berlin teams seeking backing
```

---

For technical architecture, see [ARCHITECTURE.md](ARCHITECTURE.md).

For timeline event storage, see [TIMELINE-ARCHITECTURE.md](TIMELINE-ARCHITECTURE.md).

For autonomous governance, see [03-league-management/README.md](03-league-management/README.md).
