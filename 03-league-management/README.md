# League Management

**Purpose:** Autonomous sports league that governs itself through LLM-based decision-making, where the competitive meta evolves organically from match data.

---

## Core Concept: Self-Governing League

No commissioners, no manual approvals. The system reads match data, detects patterns, and grows the tech tree autonomously.

**Three-Layer Decision System:**
1. **Algorithmic (Deterministic):** XP calculation, leaderboard updates, skill gate checks
2. **Precog Meeting (90% of decisions):** 3 randomly selected LLMs vote, majority wins
3. **Community Voting (10% edge cases):** Tie votes, rule changes, disputed merges

---

## The Precog Meeting

Every governance decision summons three LLMs from a pool of five (different temperatures). Each gets a random prompt from a pool of 20 (strict, lenient, data-driven, community-aligned, balanced). Majority wins.

**Prompt Evolution:** One prompt replaced per month. Worst-performing prompt (by community agreement rate) gets split-tested against an experiment. Winner survives.

**Watchdog System:** Weekly health check monitors community override rate, decision reversals, confidence levels. If metrics drift too far, auto-reset to last stable snapshot. Target: 1-2 resets per quarter.

---

## The Living Tech Tree

**How Skills Emerge:**
1. Match UART logs uploaded to Knowledge Commons
2. Pattern detection finds convergent evolution (3+ pilots independently discover similar strategy)
3. LLM proposes new branch with prerequisites and XP value
4. Branch auto-merges, creators credited

**Branch Lifecycle:**
- **Emerging:** 1.5x XP (encourage early adoption), needs 10 unlocks in 30 days
- **Growing:** 1.25x XP, needs >40% win rate
- **Mature:** 1.0x XP, stable meta
- **Declining:** 2.0x XP revival bonus, 90 days to recover
- **Archived:** No usage for 60 days, preserved in git

---

## Skill Gates (5 Tiers)

Unlocked by proving technique usage in winning matches, not manual approval.

| Tier | XP Range | Requirements |
|------|----------|--------------|
| Apprentice | 0-2,500 | Complete first match |
| Journeyman | 2,500-10,000 | 3 wins using Apprentice techniques |
| Expert | 10,000-30,000 | 10 wins using Journeyman techniques |
| Master | 30,000-100,000 | 20 wins + 1 original technique |
| Grandmaster | 100,000+ | 50 wins + 5 original techniques |

---

## Bounty System

Bounties = challenges to unlock tech tree branches. Each tests specific strategy execution under competitive conditions.

**Prerequisites strictly enforced:** Can't attempt tech_112 (Deauth Defense) without first unlocking tech_087 (Adaptive Channel Selection).

**Verification:** Automatic via UART log analysis post-match. No human review.

**Creator Royalties:** Original discoverers earn 10 XP every time someone unlocks their branch.

---

## Discord Agents

Three autonomous agents handle operations:

**Bounty Agent:** Shows available bounties, guides creation of new ones, validates prerequisites

**Event Agent:** Match scheduling, registration, payment processing

**Sales Agent:** Fleet rentals, dataset licensing, sponsorship inquiries

---

## XP Attribution

- **Teacher Credit:** Declare a mentor, they earn 50% of your unlock XP
- **Creator Royalties:** 10 XP per branch unlock (passive income)
- **Blueprint Sharing:** Export winning strategy as shareable code, earn 25 XP per usage

---

## Competition Format

2v2 Teams: Each team has 1 Pilot (30 bots) + 1 Hacker (WiFi attacks)
- 60 total bots on 3x3m arena
- 90-second rounds
- Victory: Most bots in goal circles when time expires

---

## The Four Guilds

Tournament entry filters use guild ratings. Pilots can join multiple guilds.

| Guild | Focus | Rating Based On |
|-------|-------|-----------------|
| **Skills** (Bronze) | Tech tree progression | XP + techniques unlocked |
| **Challenges** (Silver) | Bounty completion | Bounties solved + difficulty |
| **Hardware** (Gold) | Robot resurrection | Resurrections + remixes |
| **Sponsorship** (Platinum) | Team funding | Win rate + sponsor ROI |

---

## Guild Structure

**Initiates:** Compete, earn XP, contribute to Knowledge Commons

**Mechanists:** Host events (12-60 participants), earn 20% on module sales + 30% ticket revenue. Must compete with one bot to qualify.

**Archons:** Regional coordinators, 5% override on sales, must train 3+ Mechanists

**70% Retail Rule:** Mechanists must earn 70% from end-users (not recruitment) to prevent pyramid dynamics.

---

## Revenue Streams

1. Awakening Module sales (guild distribution)
2. Franchise fees (10% of local sponsor revenue)
3. Rental packages (€2000/weekend)
4. Sponsor packages (€50k-200k/year)
5. Workshop licensing
6. Championship events
7. Dataset licensing
8. Educational programs
9. Virtual competitions

---

## Success Metrics

- 90% governance decisions by LLM (no manual approvals)
- 3+ convergent evolution detections per month
- Pattern detection accuracy >80%
- Discord agent response <30 seconds
- 500+ active pilots Year 1

---

For technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For dataset integration, see [Knowledge Commons README](../01-knowledge-commons/README.md).
