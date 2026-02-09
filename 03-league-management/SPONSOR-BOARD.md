# Sponsor Board: Team-Sponsor Matching Platform

## What It Is

**Reverse bounty board where teams post their needs and sponsors browse for opportunities.**

Teams list what they offer (skill level, content reach, event schedule). Sponsors pick teams that match their goals. Platform takes small fee for facilitating the match.

---

## How It Works

### Team Listings

Teams post their "sponsorship opportunity" on the board:

```
TEAM: Red Sparks (Berlin)
Pilot: alice_berlin (15,000 XP, Expert rank)
Hacker: bob_munich (8,000 XP, Journeyman rank)

ASKING: €2,000/season sponsorship

OFFERING:
- Logo on team jersey (visible in all match videos)
- 4 Instagram posts/month (Alice: 2.3k followers, Bob: 890 followers)
- Sponsor mention in post-match interviews
- Behind-the-scenes content access
- 6 matches scheduled next quarter (estimated 15k total views)

PAST PERFORMANCE:
- Season 2 record: 12 wins, 8 losses (60% win rate)
- Total video views: 47k
- Tech tree contributions: 2 bounties created (tech_087, tech_134)
- Betting interest: €15k total wagered on our matches

SPONSOR FIT:
- Looking for: Tech/Industrial, Education, Regional Development
- Not a fit for: Consumer brands (our content is too technical)
```

### Sponsor Browsing

Sponsors filter teams by:
- **XP range** (want established experts? or promising newcomers?)
- **Geographic region** (Berlin-based company wants Berlin team)
- **Content reach** (follower counts, video views)
- **Betting interest** (high betting volume = engaged audience)
- **Tech tree contributions** (innovative teams vs consistent performers)
- **Budget match** (€500/season vs €5,000/season teams)

### Deal Structure

**Two sponsorship models:**

#### Model 1: Content-Only Sponsorship (5% platform fee)

```
Deal: €2,000/season flat fee
Team provides: Logo placement, social media posts, content access
Sponsor gets: Brand visibility, association with team

Platform fee: 5% × €2,000 = €100
Team receives: €1,900
```

**Platform role:**
- Facilitate initial match
- Host team profile pages
- Track deliverables (did team post promised content?)
- Handle payment escrow (sponsor pays platform, platform pays team after season)
- Dispute resolution (sponsor claims team didn't deliver? platform reviews)

#### Model 2: Prize Pool Distribution (10% platform fee)

```
Deal: €5,000 season sponsorship + 45% of prize winnings (max)
Team wins: €3,000 in prize money

Season end calculation:
- Sponsor paid: €5,000 upfront
- Team won: €3,000 prizes
- Distribution: €3,000 × 45% = €1,350 to sponsor
- Net sponsor cost: €5,000 - €1,350 = €3,650
- Team earnings: €1,900 (from sponsorship after platform fee) + €1,650 (from prizes) = €3,550

Platform fees:
- 5% on sponsorship: €5,000 × 5% = €250
- 10% on prize distribution: €1,350 × 10% = €135
- Total platform revenue: €385
```

**Why 45% max on winnings?**
- Prevents sponsor from taking >50% (team must always get majority of prize)
- Cap protects teams from predatory deals
- Encourages sponsor to fund upfront (can't just take prize money)

**When this model makes sense:**
- Sponsor believes team will win big prizes
- Team needs cash now (upfront payment helps with travel, equipment)
- Sponsor gets upside if team performs well
- Team still keeps 55%+ of all prize money

---

## Platform Fees Explained

### 5% Content-Only Fee

**What platform provides:**
- Team profile hosting
- Sponsor discovery system
- Payment escrow (protects both parties)
- Deliverable tracking
- Dispute resolution
- Contract templates

**Example:**
```
Sponsor pays: €2,000
Platform keeps: €100 (5%)
Team receives: €1,900
```

### 10% Prize Distribution Fee

**What platform provides (additional services):**
- Prize money tracking across all events
- Automated distribution calculations
- Multi-party payment splitting (if multiple sponsors)
- Tax documentation (1099/invoices for prize income)
- Compliance with gambling/prize regulations

**Example:**
```
Team wins: €3,000 prize
Sponsor's share: €3,000 × 45% = €1,350
Platform fee: €1,350 × 10% = €135
Sponsor receives: €1,215
Team receives: €1,650 (remaining 55%)
```

**Why higher fee for prize distribution?**
- More complex (tracking multiple events, calculating percentages)
- More liability (prize money = tax implications)
- More value (sponsor gets financial upside, not just brand placement)

---

## Team Profile Page

**What sponsors see when browsing:**

### Basic Info
- Team name, location, members
- Total XP, ranks, skill gates unlocked
- Orders (Fractured Gear, Ascendant Coil, etc.)

### Performance Stats
- Win/loss record (last 20 matches)
- Avg bots in goal per match
- Tech tree contributions (bounties created)
- Teacher credits earned (mentor activity)
- Blueprint shares (community engagement)

### Audience Reach
- Combined social media followers
- Total video views (last quarter)
- Betting interest (total wagered on team's matches)
- Match attendance (in-person spectators)

### Content Portfolio
- Sample match videos
- Behind-the-scenes content
- Pilot interviews
- Hacker breakdown videos

### Sponsorship Ask
- Budget requested
- What they'll deliver (posts, logo placement, etc.)
- Prize distribution split (if applicable)
- Sponsor categories they're targeting

### Past Sponsors
- Previous deals (if any)
- Testimonials from sponsors
- Proof of deliverables (screenshot of posts, videos with logos)

---

## Sponsor Categories

**Different sponsor types want different things:**

### Tech/Industrial Sponsors (€5k-€50k/season)
**What they want:**
- Association with innovation (teams creating new bounties)
- Dataset access to see their sponsored team's strategies
- Recruitment pipeline (hire top pilots for engineering roles)
- B2B credibility (showing they support cutting-edge robotics)

**Best team fit:**
- High XP (Expert/Master tier)
- Multiple bounty creations
- Technical content (strategy breakdowns, code explanations)

### Regional Development Sponsors (€2k-€10k/season)
**What they want:**
- Local team promotion (Berlin city sponsoring Berlin team)
- Community engagement (workshops, school visits)
- Tourism tie-in (matches bring visitors to region)

**Best team fit:**
- Based in sponsor's region
- Active in local community
- Willing to do workshops/events

### Education Sponsors (€1k-€5k/season)
**What they want:**
- Student recruitment (universities sponsoring teams)
- STEM promotion (educational content creation)
- Internship pipeline (sponsor hires team members)

**Best team fit:**
- Strong teaching activity (teacher credits, mentorship)
- Educational content (tutorials, strategy guides)
- University-affiliated teams

### Consumer Brands (€10k-€100k/season)
**What they want:**
- Youth audience reach (energy drinks, gaming peripherals)
- Social media visibility (high follower counts)
- Viral potential (exciting matches, dramatic moments)

**Best team fit:**
- High social media reach (5k+ followers)
- Entertaining content style (not just technical)
- Consistent match schedule (regular content flow)

---

## Discovery Algorithm

**How platform matches teams to sponsors:**

### Sponsor Sets Criteria
```
Looking for:
- Region: Germany
- Budget: €2,000-€5,000
- XP range: 10,000-30,000 (Expert tier)
- Content reach: 2,000+ combined followers
- Category: Tech/Industrial
```

### Platform Ranks Teams
```
Scoring system:

1. Geographic match (40 points)
   - Same city: +40
   - Same country: +30
   - Same region: +20

2. Budget alignment (30 points)
   - Team asking exactly in range: +30
   - Team asking 20% above: +20
   - Team asking 50% above: +10

3. Audience fit (20 points)
   - Content reach exceeds requirement: +20
   - Content reach meets requirement: +15
   - Content reach 80% of requirement: +10

4. Performance (10 points)
   - Win rate >60%: +10
   - Win rate 50-60%: +7
   - Win rate 40-50%: +5
```

### Recommended Matches
```
Top 5 matches for your criteria:

1. Red Sparks (Berlin) - 97/100 match score
   Asking: €2,000/season
   XP: 15,000 (alice) + 8,000 (bob) = 23,000 avg
   Reach: 3,190 followers
   Why recommended: Perfect budget match, high engagement, 2 bounties created

2. Blue Thunder (Munich) - 89/100 match score
   Asking: €2,500/season
   XP: 18,000 (charlie) + 12,000 (david) = 30,000 avg
   Reach: 1,850 followers
   Why recommended: Higher skill, slightly above budget, strong tech content

[3 more teams...]
```

---

## Deal Lifecycle

### 1. Team Posts Sponsorship Opportunity
- Fills out profile
- Sets budget ask
- Chooses models (content-only vs prize distribution)
- Goes live on Sponsor Board

### 2. Sponsors Browse & Express Interest
- Filter by criteria
- Review team profiles
- Click "Interested" button
- Platform notifies team

### 3. Team Reviews Interested Sponsors
- Checks sponsor background
- Reviews sponsor's other teams (if any)
- Accepts or declines initial interest

### 4. Negotiation (Off-Platform)
- Platform provides contact info
- Team and sponsor negotiate details
- Can use platform contract template or their own

### 5. Deal Finalized (On-Platform)
- Both parties sign digital contract via platform
- Sponsor deposits funds into escrow
- Deal appears on team's profile page

### 6. Season Execution
- Team delivers content per contract
- Platform tracks deliverables (posts, logo placement)
- Sponsor can flag issues ("team didn't post this month")
- Platform mediates disputes

### 7. Season End Settlement
- If content-only: escrow releases funds to team (minus 5% fee)
- If prize distribution: platform calculates winnings, splits per contract, releases funds (minus 10% fee on prize portion)

### 8. Renewal or Parting
- Sponsor can renew for next season (discounted 3% platform fee for renewal)
- Team can seek new sponsors
- Past relationship appears on both profiles (reputation building)

---

## Revenue Model

**Platform earns from three sources:**

### 1. Sponsorship Facilitation (5% fee)
```
Year 1 target: 20 teams × €2,000 avg sponsorship = €40,000 volume
Platform revenue: €40,000 × 5% = €2,000
```

### 2. Prize Distribution (10% fee)
```
Year 1 target: 5 teams with prize distribution deals
Avg prize winnings: €2,000/team
Avg sponsor share: 45% × €2,000 = €900/team
Total distributed: €900 × 5 = €4,500
Platform revenue: €4,500 × 10% = €450
```

### 3. Premium Listings (€50/season)
```
Teams can pay to:
- Appear at top of sponsor searches
- Highlight profile with badge
- Get featured in monthly sponsor newsletter

Year 1 target: 10 teams pay for premium
Platform revenue: 10 × €50 = €500
```

**Total Year 1 platform revenue: €2,950**

**Year 3 target (100 teams, mature ecosystem):**
- Sponsorship facilitation: €10,000
- Prize distribution: €5,000
- Premium listings: €5,000
- **Total: €20,000/year**

---

## Example Scenarios

### Scenario 1: Rookie Team Seeks First Sponsor

**Team:** New Gears (Hamburg)
- Pilot: 3,000 XP (Apprentice)
- Hacker: 2,500 XP (Apprentice)
- Asking: €500/season
- Offering: 2 Instagram posts/month, logo on jersey, 4 scheduled matches

**Sponsor Match:** Local hackerspace (wants to promote STEM education)
- Budget: €500
- Goal: Community engagement, not brand visibility
- Deal: Content-only (5% platform fee)

**Outcome:**
- Hackerspace pays €500
- Platform keeps €25
- Team receives €475
- Team delivers social posts + brings sponsor banner to matches
- Hackerspace gets association with local robotics scene

### Scenario 2: Veteran Team with Prize Potential

**Team:** Iron Coil (Berlin)
- Pilot: 45,000 XP (Grandmaster)
- Hacker: 30,000 XP (Master)
- Asking: €10,000/season + 40% prize distribution
- Offering: Logo on all content, 8 Instagram posts/month, sponsor interviews, 12 scheduled matches (championship circuit)

**Sponsor Match:** Industrial automation company (Siemens, Bosch, etc.)
- Budget: €10,000
- Goal: Recruitment pipeline + brand association with top team
- Deal: Prize distribution model (5% on sponsorship + 10% on prizes)

**Season outcome:**
- Team wins €8,000 in prizes
- Sponsor receives: 40% × €8,000 = €3,200 (minus €320 platform fee = €2,880)
- Net sponsor cost: €10,000 - €2,880 = €7,120
- Team receives: €9,500 (sponsorship after fee) + €4,800 (prize money after split) = €14,300
- Platform earns: €500 (sponsorship fee) + €320 (prize distribution fee) = €820

### Scenario 3: Mid-Tier Team with Content Focus

**Team:** Signal Hackers (Munich)
- Pilot: 12,000 XP (Journeyman)
- Hacker: 18,000 XP (Expert)
- Asking: €3,000/season
- Offering: Weekly YouTube strategy breakdowns, 4 posts/month, logo placement, 8 scheduled matches, behind-the-scenes access

**Sponsor Match:** Tech education platform (wants content for their YouTube channel)
- Budget: €3,000
- Goal: Content licensing (sponsor can reuse team's videos on their channel)
- Deal: Content-only + licensing rights

**Outcome:**
- Sponsor pays €3,000
- Platform keeps €150 (5%)
- Team receives €2,850
- Team creates weekly strategy videos with sponsor branding
- Sponsor cross-posts videos to their 50k subscriber channel
- Team gets exposure, sponsor gets educational content

---

## Why This Works

### For Teams
- **Access to funding** without needing to cold-email sponsors
- **Fair platform fees** (5-10% vs typical agency 20-30%)
- **Protection from bad deals** (45% prize cap, escrow, dispute resolution)
- **Portfolio building** (past sponsors = social proof for future deals)

### For Sponsors
- **Efficient discovery** (filter teams by criteria, not manual research)
- **Risk reduction** (prize distribution model = only pay if team wins)
- **Verified metrics** (XP, win rate, betting interest = objective data)
- **Turnkey contracts** (platform provides templates, handles payments)

### For Platform (Robot Arena)
- **Revenue stream** without heavy lifting (just facilitate, don't create content)
- **Network effects** (more teams = more sponsors = more teams)
- **Data advantage** (platform knows which teams perform, which sponsors renew)
- **Ecosystem growth** (funded teams compete more = better matches = higher dataset value)

---

For team management, see [README.md](README.md).

For dataset economics, see [../01-knowledge-commons/README.md](../01-knowledge-commons/README.md).

For betting integration, see [../05-betting-integration/README.md](../05-betting-integration/README.md).
