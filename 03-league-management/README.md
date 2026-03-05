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

## Game Formats

| Format | Class | Teams | Arena | Objective |
|--------|-------|-------|-------|-----------|
| **Sumo** | Starter (20cm) | 2 teams (Red vs Blue) | 3x3m fixed floor | Most bots in opponent's goal ring at 0:00 |
| **Process Validation** | Maintenance (60cm) | 1 team vs clock | Modular 1x1m modules | Complete task objective within time limit |

### Sumo

Two teams of 20cm Starter Class bots compete on a **3x3m fixed arena** for 90 seconds. Each team fields up to 30 bots (60 total on field). Nobody touches anything once the match starts.

**Winning condition:** The team with more bots inside the opponent's designated goal ring when the timer hits zero wins.

**Arena surface:** The 3x3m floor is covered with a grid of **10x10cm spigot holes**. These accept 3D-printed arena accessories — walls, push buttons, doors, traps, ramps — that can be swapped between matches to change the layout. Same floor, different configuration every time.

Each team uploads two repos before the match: a **swarm script** (commands up to 30 bots autonomously) and a **hacking script** (WiFi disruption targeting the opponent's controller-to-node communication). The strategic tension: centralized swarm coordination is powerful but vulnerable to hacking; distributed local behavior is resilient but uncoordinated.

### Process Validation

One team of 60cm Maintenance Class bots competes **against the clock** to fulfill a defined goal within the time limit. No opponent — the challenge is the task itself.

**Arena:** Built from **modular 1x1m floor modules**, each covered by the same 3D-printed panel system as Sumo (10x10cm spigot grid). Walls, obstacles, gates, ramps — all interchangeable. This means we can **simulate almost any real-life situation** and reproduce it identically across multiple arenas in different locations.

**Bots:** 60cm Maintenance Class with task-specific accessories mounted on standard attachment points — grippers, pushers, sensors, whatever the bounty requires.

**Why this matters for bounty validation:** A bounty can require the team to pass the same task across **3 different arena matches in different physical locations**. Because the modular panel system is standardized, the arena layout is identical everywhere. If your solution works in Tallinn, it works in Berlin — provably, not theoretically. This turns process validation into something reproducible and location-independent.

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
