# League Management

**Purpose:** Autonomous sports league infrastructure that evolves through LLM-based governance, creating a living competitive ecosystem where knowledge grows organically from match data.

## What This Is

League Management is Robot Arena's **self-organizing nervous system**—an autonomous governance layer where:
- Tech tree grows organically from UART log analysis (no centralized curation)
- Bounty system enforces skill prerequisites algorithmically
- Discord agents handle 90% of operational decisions
- LLM referee manages routine governance
- Community votes only on true edge cases

**The Core Innovation:** No league commissioners, no manual approvals, no centralized control. The system reads match data, detects patterns, and grows the competitive meta autonomously—like Factorio's tech tree meets competitive esports.

---

## Autonomous Governance Architecture

### Three-Layer Decision System

**Layer 1: Algorithmic (Deterministic)**
- XP calculation from match results
- Leaderboard updates
- Skill gate qualification checks
- Branch lifecycle state transitions

**Layer 2: Precog Meeting (90% of Human Decisions)**
- 3 randomly selected LLMs vote on each decision
- Each LLM gets random prompt from pool of 20
- Majority (2/3) wins
- System runs autonomously forever, no human needed

**Layer 3: Community Voting (10% Edge Cases)**
- Tie votes (1-1-1 three-way split)
- Low confidence unanimous votes (<50%)
- Major rule changes
- Watchdog reset approval

---

## The Precog Meeting: Radically Simple Autonomous Governance

**Inspired by Minority Report's three precogs, but for league governance instead of crime.**

### Core Mechanism

Every governance decision summons a "Precog Meeting":

```python
import random

def precog_meeting(governance_question):
    """
    The autonomous decision engine.
    Randomly selects 3 LLMs and 3 prompts from pools.
    """

    # Pool of 5 LLM judges (can be same model, different temps)
    LLM_POOL = [
        {"name": "Agatha", "model": "claude-sonnet-4-5", "temp": 0.7},
        {"name": "Arthur", "model": "claude-sonnet-4-5", "temp": 0.9},
        {"name": "Dash", "model": "claude-sonnet-4-5", "temp": 1.0},
        {"name": "Iris", "model": "claude-sonnet-4-5", "temp": 0.8},
        {"name": "Wally", "model": "claude-sonnet-4-5", "temp": 1.1}
    ]

    # Pool of 20 prompt variations
    PROMPT_POOL = load_prompt_pool()  # 20 variations of governance prompts

    # Randomly select 3 LLMs (no replacement)
    selected_llms = random.sample(LLM_POOL, 3)

    # Randomly select 3 prompts (with replacement - same prompt can be used twice)
    selected_prompts = [random.choice(PROMPT_POOL) for _ in range(3)]

    # Each LLM votes using their assigned prompt
    votes = []
    for llm, prompt in zip(selected_llms, selected_prompts):
        vote = llm.ask(prompt.format(question=governance_question))
        votes.append({
            'llm': llm['name'],
            'prompt_id': prompt['id'],
            'vote': vote['decision'],  # approve/reject
            'confidence': vote['confidence'],  # 0.0-1.0
            'reasoning': vote['reasoning']
        })

    # Majority wins (2 out of 3)
    approvals = sum(1 for v in votes if v['vote'] == 'approve')

    if approvals >= 2:
        outcome = 'approve'
    elif approvals == 1:
        outcome = 'reject'
    else:  # All three different or all reject
        outcome = 'reject'

    # Special case: Tie (1 approve, 1 reject, 1 abstain)
    if len(set(v['vote'] for v in votes)) == 3:
        outcome = 'community_vote'  # Escalate to humans

    # Log everything (transparency)
    log_precog_meeting({
        'question': governance_question,
        'llms': [v['llm'] for v in votes],
        'prompts': [v['prompt_id'] for v in votes],
        'votes': votes,
        'outcome': outcome
    })

    return outcome
```

**Example Precog Meeting:**
```
Question: "Should tech_187 (WiFi Frequency Hopping) be approved as new branch?"

Selected LLMs: Agatha, Dash, Wally
Selected Prompts: prompt_04, prompt_17, prompt_04 (note: prompt_04 used twice)

Vote 1 (Agatha + prompt_04):
  → approve (confidence: 0.72)
  → "Uses PRNG for hopping, distinct from reactive switching"

Vote 2 (Dash + prompt_17):
  → reject (confidence: 0.81)
  → "Insufficient evidence of measurable advantage"

Vote 3 (Wally + prompt_04):
  → approve (confidence: 0.68)
  → "Novel approach, worth testing in competition"

Majority: 2 approve, 1 reject → APPROVED
Logged: dec_5042 (Agatha, Dash, Wally | prompts 04, 17, 04)
```

### The 20-Prompt Pool

**Why 20 prompts instead of 15 specific ones?**
- Same decision can be evaluated from multiple angles
- Randomness prevents gaming (pilots can't optimize for specific prompt)
- Prompt evolution happens through survival (bad prompts get replaced)

**Prompt Categories (3-5 prompts each):**

**1. Strict Validation (4 prompts)**
- Require 3+ independent implementations
- Must show measurable win rate improvement
- Must differ >50% from existing strategies
- Focus on objective criteria

**2. Lenient Exploration (4 prompts)**
- Encourage experimental strategies
- Accept novelty even without proven results
- Lower bar for new ideas
- Focus on innovation potential

**3. Community-Aligned (4 prompts)**
- Prioritize community consensus
- Check for similar past approvals
- Consider pilot feedback heavily
- Focus on participant satisfaction

**4. Data-Driven (4 prompts)**
- Require statistical significance
- Demand UART log evidence
- Focus on measurable outcomes
- Ignore subjective opinions

**5. Hybrid Balanced (4 prompts)**
- Mix of strict + lenient criteria
- Weighted scoring across dimensions
- Contextual decision-making
- Balanced trade-offs

**Example Prompts from Pool:**

**Prompt #04 (Strict Validation):**
```
Evaluate if this technique deserves a new tech tree branch.

CRITERIA:
1. At least 3 pilots must have independently discovered it
2. Win rate improvement >10% when used
3. Implementation differs >50% from existing branches

VOTE: approve only if all 3 criteria met
OUTPUT: {"vote": "approve"/"reject", "confidence": 0.0-1.0, "reasoning": "..."}
```

**Prompt #17 (Lenient Exploration):**
```
Evaluate if this technique shows innovation potential.

CRITERIA:
1. Is the approach genuinely novel?
2. Could it lead to interesting meta developments?
3. Would other pilots want to learn this?

VOTE: approve if 2+ criteria met, encourage experimentation
OUTPUT: {"vote": "approve"/"reject", "confidence": 0.0-1.0, "reasoning": "..."}
```

**Why This Works:**
- 3 randomly selected prompts average out to balanced decisions
- Sometimes 2 strict + 1 lenient → conservative
- Sometimes 2 lenient + 1 strict → progressive
- Over time, distribution regresses to mean

### Controlled Prompt Evolution

**The Problem:**
If prompts evolve freely, system drifts unpredictably.

**The Solution: ONE PROMPT AT A TIME + SURVIVAL OF THE FITTEST**

**Evolution Rules:**

1. **Only modify 1 prompt per month** (out of 20 in pool)
2. **New prompt replaces worst-performing prompt**
3. **Performance = community agreement rate**
4. **Must show measurable improvement over replaced prompt**

**Monthly Evolution Process:**
```python
def evolve_prompt_pool():
    """Run once per month, replace worst prompt with experiment"""

    # Calculate performance for each prompt
    performance = {}
    for prompt_id in range(1, 21):
        decisions = get_decisions_using_prompt(prompt_id, days=30)
        agreement = calculate_community_agreement(decisions)
        performance[prompt_id] = {
            'usage_count': len(decisions),
            'agreement_rate': agreement,
            'avg_confidence': avg([d['confidence'] for d in decisions])
        }

    # Find worst-performing prompt (but used at least 10 times)
    eligible = {pid: perf for pid, perf in performance.items()
                if perf['usage_count'] >= 10}

    if not eligible:
        return "Not enough data, skip evolution this month"

    worst_prompt = min(eligible.items(), key=lambda x: x[1]['agreement_rate'])

    # Generate experimental replacement
    experiment = generate_prompt_variation(
        base=random.choice(range(1, 21)),  # Random prompt as inspiration
        target_weakness=worst_prompt[1]     # Try to fix weakness
    )

    # Run 30-day trial: worst prompt vs experiment
    # (50% of decisions use old, 50% use experiment)
    trial_results = run_split_test(
        prompt_a=worst_prompt[0],
        prompt_b=experiment,
        duration_days=30
    )

    # If experiment beats worst prompt, replace it
    if trial_results['experiment_agreement'] > trial_results['worst_agreement']:
        replace_prompt(worst_prompt[0], experiment)
        log_evolution(f"Replaced prompt #{worst_prompt[0]} with experiment")
    else:
        log_evolution(f"Experiment failed, keeping prompt #{worst_prompt[0]}")
```

**Example Evolution:**
```
Month 1: Baseline
  Prompt #12 performance: 68% community agreement (worst in pool)
  Average pool performance: 79% agreement

Month 2: Generate Experiment
  Inspiration: Prompt #04 (strict validation) scored 84% agreement
  Weakness in #12: "Too lenient, approves too many similar branches"
  Experiment: Add "must differ >40% from existing" clause

Month 3: Split Test
  Prompt #12 (original): 42 decisions, 67% agreement
  Experiment: 38 decisions, 76% agreement
  Result: Experiment wins (+9% agreement)
  Action: Replace prompt #12 with experiment

Month 4: Monitor
  New prompt #12: 51 decisions, 74% agreement (holding steady)
  New worst prompt: #07 at 71% agreement
```

**Key Constraint: Similar Changes Must Prove Merit**
```python
def generate_prompt_variation(base, target_weakness):
    """Create experiment that addresses weakness"""

    # Check if similar change has been tried before
    change_pattern = identify_change_pattern(target_weakness)

    past_experiments = find_experiments_by_pattern(change_pattern)

    if past_experiments:
        # Similar change tried before?
        successful = [e for e in past_experiments if e['outcome'] == 'promoted']

        if not successful:
            # This pattern failed before, try different approach
            return generate_different_variation(base, target_weakness)

    # Generate variation
    return create_experiment_prompt(base, change_pattern)
```

### Watchdog System: Self-Healing Reset

**The Problem:**
- System could drift over months/years
- Need automatic correction without human oversight

**The Solution: Statistical Watchdog**

**Monitors 5 Metrics Weekly:**
```python
class WatchdogMonitor:
    def __init__(self):
        self.thresholds = {
            'community_override_rate': 0.25,  # >25% = LLMs diverging from humans
            'decision_reversal_rate': 0.15,   # >15% = unstable decisions
            'avg_confidence': 0.60,            # <60% = prompts too vague
            'unanimous_rate': 0.30,            # <30% = prompts conflicting
            'tie_rate': 0.10                   # >10% = too many escalations
        }

    def weekly_health_check(self):
        """Runs every Monday, checks if reset needed"""

        metrics = calculate_last_7_days()

        # RED FLAGS (immediate reset)
        if metrics['community_override_rate'] > self.thresholds['community_override_rate']:
            return self.trigger_reset("LLMs diverging from community values")

        if metrics['decision_reversal_rate'] > self.thresholds['decision_reversal_rate']:
            return self.trigger_reset("Too many unstable decisions")

        if metrics['avg_confidence'] < self.thresholds['avg_confidence']:
            return self.trigger_reset("LLM confidence too low")

        # YELLOW FLAGS (track for 2 weeks)
        warnings = []
        if metrics['unanimous_rate'] < self.thresholds['unanimous_rate']:
            warnings.append("Low unanimity rate")

        if metrics['tie_rate'] > self.thresholds['tie_rate']:
            warnings.append("Too many tie votes")

        if warnings:
            return self.track_warning(warnings)

        # GREEN (healthy, create snapshot)
        return self.create_snapshot()

    def trigger_reset(self, reason):
        """Reset to last stable snapshot"""

        # Find most recent snapshot with good metrics
        snapshot = self.find_last_stable_snapshot()

        if not snapshot:
            # No stable snapshot, use original launch prompts
            snapshot = self.load_original_prompts()

        # Restore prompt pool
        self.restore_snapshot(snapshot)

        # Log reset publicly
        log_reset({
            'timestamp': now(),
            'reason': reason,
            'snapshot_date': snapshot['timestamp'],
            'decisions_since_snapshot': count_decisions_since(snapshot)
        })

        # Notify community (Discord)
        notify_community(f"⚠️ Watchdog reset triggered: {reason}\n"
                        f"Restored prompts from {snapshot['timestamp']}")

        return "RESET_COMPLETE"
```

**Snapshot System:**
```python
def create_snapshot():
    """Save current prompt pool as potential restore point"""

    metrics = calculate_last_30_days()

    snapshot = {
        'timestamp': now(),
        'prompts': copy.deepcopy(PROMPT_POOL),
        'performance': {
            'community_agreement': metrics['agreement_avg'],
            'decision_count': metrics['total_decisions'],
            'reversal_rate': metrics['reversal_rate'],
            'confidence_avg': metrics['confidence_avg']
        }
    }

    # Save to git (version controlled, auditable)
    save_snapshot(f"governance/snapshots/{now().isoformat()}.json")

    # Keep last 12 snapshots (3 months @ weekly)
    cleanup_old_snapshots(keep=12)

    return snapshot

def find_last_stable_snapshot():
    """Find most recent snapshot meeting stability criteria"""

    snapshots = load_all_snapshots()

    for snapshot in reversed(snapshots):
        perf = snapshot['performance']

        # Stability criteria
        if (perf['community_agreement'] > 0.75 and
            perf['decision_count'] > 100 and
            perf['reversal_rate'] < 0.10):
            return snapshot

    return None  # No stable snapshot found
```

**Adaptive Threshold Tuning:**
```python
def tune_watchdog_quarterly():
    """Every 3 months, adjust sensitivity based on reset frequency"""

    reset_count = count_resets_last_90_days()

    # Target: 1-2 resets per quarter
    if reset_count == 0:
        # Too rigid, never resetting
        self.thresholds['community_override_rate'] *= 0.90  # More sensitive
        log_tuning("Reduced thresholds (no resets in 90 days)")

    elif reset_count > 4:
        # Too loose, resetting too often
        self.thresholds['community_override_rate'] *= 1.10  # Less sensitive
        log_tuning("Increased thresholds (excessive resets)")

    else:
        # Goldilocks zone
        log_tuning("Thresholds unchanged (healthy reset frequency)")
```

**Reset Frequency Targets:**
- **Ideal:** 1-2 resets per quarter (adapts without instability)
- **Too rigid:** 0 resets per year (prompts become outdated)
- **Too loose:** >1 reset per month (never stabilizes)

### Complete Example: System Runs Autonomously for 1 Year

**Month 1: Baseline**
```
Precog meetings: 287
Prompts in pool: 20 (original launch versions)
Avg community agreement: 79%
Resets: 0
```

**Month 2: First Evolution**
```
Worst prompt: #12 (68% agreement)
Experiment: Add stricter validation clause
Result: Experiment succeeds (76% agreement)
Action: Promote experiment → new prompt #12
```

**Month 4: First Reset**
```
Watchdog detects: Community override rate 27% (threshold: 25%)
Diagnosis: LLMs approving too many marginal branches
Action: Reset to Month 2 snapshot
Result: Prompts #12 (new) and #07 (evolved in Month 3) reverted
```

**Month 7: Stable Operation**
```
Precog meetings: 1,842 total
Avg agreement: 81%
Resets since Month 4: 0 (stable)
Prompt evolution: 3 prompts replaced (months 5, 6, 7)
```

**Month 10: Second Reset**
```
Watchdog detects: Reversal rate 16% (threshold: 15%)
Diagnosis: Prompts evolved too lenient, unstable decisions
Action: Reset to Month 7 snapshot
Result: 3 evolved prompts reverted
```

**Month 12: End of Year**
```
Total precog meetings: 3,456
Community agreement: 80% (within 1% of launch)
Resets: 2 (target: 1-2 per quarter → healthy)
Prompt evolution: 7 prompts replaced, 2 resets reverted 5 of them
Net evolution: 2 prompts permanently improved from launch versions
```

**Why This Works:**
- System runs autonomously (no human needed)
- Evolves gradually (1 prompt/month)
- Self-corrects (watchdog resets drift)
- Transparent (all decisions logged publicly)
- Survives indefinitely (no human intervention required)

### Discord Agent Framework

Three autonomous agents handle league operations:

#### Bounty Agent
**Role:** Manage bounty lifecycle, validate prerequisites, guide bounty creation

**Example Interaction:**
```
User: @BountyAgent available
Agent: You have 3 bounties available based on your tech tree:
  • tech_087: Adaptive Channel Selection (500 XP, requires tech_031)
  • tech_112: Deauth Attack Defense (750 XP, requires tech_087)
  • tech_134: Signal Strength Optimization (1000 XP, requires tech_112)

User: @BountyAgent create
Agent: Let's create a new bounty! What challenge did you overcome in your last match?
User: I figured out how to detect WiFi jamming attacks and switch channels automatically
Agent: Great! I found 2 similar strategies in the tech tree:
  • tech_087: Adaptive Channel Selection
  • tech_112: Deauth Attack Defense
  Does your approach differ from these?
User: Mine uses signal strength patterns, not just deauth detection
Agent: Perfect! That sounds like a new branch. What prior skills does someone need?
User: They need to know channel hopping basics and signal analysis
Agent: I'll set tech_087 (Adaptive Channel Selection) as prerequisite. Describe the challenge:
```

**Technical Implementation:**
```python
import discord
from anthropic import Anthropic
import json

class BountyAgent:
    def __init__(self):
        self.client = discord.Client(intents=discord.Intents.default())
        self.anthropic = Anthropic(api_key=os.environ['ANTHROPIC_API_KEY'])
        self.conversation_state = {}

    async def handle_available_bounties(self, user_id):
        """Show bounties user is qualified to attempt"""
        user_skills = self.get_unlocked_skills(user_id)
        available = self.find_available_bounties(user_skills)
        return self.format_bounty_list(available)

    async def handle_create_bounty(self, message):
        """Conversational wizard for bounty creation"""
        user_id = message.author.id

        # Multi-turn conversation with Claude
        messages = self.conversation_state.get(user_id, [])
        messages.append({"role": "user", "content": message.content})

        response = self.anthropic.messages.create(
            model="claude-sonnet-4-5-20250929",
            max_tokens=1024,
            system="""You are the Bounty Agent for Robot Arena.
            Help users create new bounties by:
            1. Understanding their achievement
            2. Finding similar existing strategies
            3. Determining prerequisites
            4. Writing clear challenge description
            5. Proposing XP value based on difficulty

            Ask questions until you have all info needed.""",
            messages=messages
        )

        self.conversation_state[user_id] = messages + [
            {"role": "assistant", "content": response.content[0].text}
        ]

        return response.content[0].text
```

#### Event Agent
**Role:** Match scheduling, arena availability, registration

**Example Interaction:**
```
User: @EventAgent find matches this weekend
Agent: I found 3 events in your region:
  • Berlin Arena - Saturday 14:00 (12 slots left, €50 entry)
  • Munich Warehouse - Sunday 10:00 (6 slots left, €50 entry)
  • Hamburg Hackerspace - Sunday 16:00 (20 slots left, €40 entry)

  Which sounds good?
User: Berlin Saturday
Agent: Perfect! I need a few details:
  • Team name (or competing solo?)
  • Role preference (Pilot or Hacker?)
  • Using rental bots or bringing your own?
User: Solo, Pilot, rental
Agent: Got it! €50 entry + €20 rental = €70 total.
  Payment link: [stripe_checkout_url]
  Confirmation will be sent to your email once paid.
  See you Saturday! 🤖
```

#### Sales/Rental Agent
**Role:** Fleet rentals, dataset licensing, sponsorship inquiries

**Example Interaction:**
```
User: @SalesAgent rent fleet
Agent: I can help with that! A few questions:
  • Event type? (school workshop, corporate event, tournament)
  • How many participants?
  • Date and location?
User: Corporate team building, 20 people, Berlin, March 15
Agent: Great! For 20 people I recommend:
  • 60-bot fleet (€400/day rental)
  • 3x3m arena setup (€200 setup fee)
  • 4-hour session with operator (€300)
  • Total: €900

  Want to add custom arena scenario? (+€500 for logistics/inspection theme)
User: Yes, warehouse logistics theme
Agent: Perfect! Updated quote:
  • Fleet + Arena + Operator: €900
  • Custom scenario design: €500
  • Total: €1400

  I'll send contract to your email. Need any modifications?
```

---

## The Living Tech Tree

### How It Works

**Match Data → Pattern Detection → Skill Discovery**

Every match uploads complete UART logs to Knowledge Commons. Post-match, the pattern detection agent analyzes:
- Command sequences (what did winning pilots do differently?)
- Timing patterns (when did they execute key maneuvers?)
- Collision behaviors (how did they recover from disruptions?)
- WiFi packet traces (what hacker techniques were used?)

**When 3+ pilots independently develop similar strategies (convergent evolution):**
```python
def analyze_tactical_patterns(match_logs):
    """Detect convergent evolution in UART logs"""
    patterns = extract_command_sequences(match_logs)
    clusters = cluster_similar_patterns(patterns)

    for cluster in clusters:
        if len(cluster['pilots']) >= 3 and cluster['similarity'] > 0.85:
            # Found convergent evolution!
            merge_proposal = llm_analyze_convergence(cluster)

            if merge_proposal['should_merge']:
                # Create new tech tree branch
                new_branch = {
                    'id': generate_tech_id(),
                    'name': merge_proposal['technique_name'],
                    'creators': cluster['pilots'],
                    'first_seen': cluster['earliest_match'],
                    'description': merge_proposal['description'],
                    'parent_skills': merge_proposal['prerequisites'],
                    'xp_value': calculate_difficulty(cluster['win_rate'])
                }
                propose_branch_merge(new_branch)
```

**Example Evolution:**

**Week 1:** Pilot Alice discovers that switching WiFi channels during deauth attacks improves swarm resilience. She wins 3 matches using this technique.

**Week 3:** Pilots Bob and Charlie independently develop similar channel-switching strategies in different regions.

**Week 4:** Pattern detection agent notices convergent evolution:
```
CONVERGENT EVOLUTION DETECTED
Technique: Adaptive Channel Selection
Pilots: Alice (Berlin), Bob (Munich), Charlie (Hamburg)
Similarity: 87%
Matches: 8 total (6 wins, 2 losses)
Win rate correlation: +23% when technique used

LLM Analysis:
"All three pilots switch WiFi channels when detecting abnormal packet loss,
but use different triggering thresholds. Recommend merging into single branch
with prerequisite: Basic Channel Hopping (tech_031)."

Proposed Branch:
ID: tech_087
Name: Adaptive Channel Selection
XP Value: 500 XP
Prerequisites: tech_031 (Basic Channel Hopping)
Creators: Alice, Bob, Charlie (equal credit)
```

**Week 5:** Branch auto-merged into tech tree. All three pilots receive 500 XP. Future pilots who unlock tech_087 earn 250 XP (mature branch discount).

### Tech Tree Example (WiFi-Only Strategies)

```
tech_001: Basic Bot Control
  ├─ tech_015: Formation Basics (3-bot triangle)
  │   ├─ tech_031: Basic Channel Hopping
  │   │   ├─ tech_087: Adaptive Channel Selection ⭐ NEW
  │   │   │   ├─ tech_112: Deauth Attack Defense
  │   │   │   │   └─ tech_134: Signal Strength Optimization
  │   │   │   └─ tech_098: Jamming Pattern Recognition
  │   │   └─ tech_056: Multi-Channel Swarm Coordination
  │   └─ tech_042: Collision Recovery Patterns
  └─ tech_023: Goal-Seeking Algorithms
      └─ tech_067: Dynamic Pathfinding
```

**Key Properties:**
- **Organic growth:** No manual curation, branches emerge from match data
- **Prerequisites enforce progression:** Can't attempt tech_112 without tech_087
- **Passive XP for creators:** Every time someone unlocks tech_087, Alice/Bob/Charlie get 10 XP
- **Branches have lifecycle:** Emerging → Growing → Mature → Declining → Archived

---

## Skill Gate System

### Five Progression Tiers

Skill gates are unlocked by **proving you used techniques in winning matches**, not by manual approval.

**Apprentice (tech_001-025)**
- **Entry requirement:** Complete first match (win or lose)
- **Unlocks:** Basic bot control, simple formations, goal-seeking
- **Badge:** Bronze gear sigil
- **XP range:** 0-2500 XP

**Journeyman (tech_026-075)**
- **Entry requirement:** 2500 XP + 3 wins using Apprentice techniques
- **Unlocks:** Channel hopping, collision recovery, multi-channel coordination
- **Badge:** Silver coil sigil
- **XP range:** 2500-10,000 XP

**Expert (tech_076-150)**
- **Entry requirement:** 10,000 XP + 10 wins using Journeyman techniques
- **Unlocks:** Adaptive channel selection, deauth defense, signal optimization
- **Badge:** Gold sparks sigil
- **XP range:** 10,000-30,000 XP

**Master (tech_151-250)**
- **Entry requirement:** 30,000 XP + 20 wins + 1 original technique contribution
- **Unlocks:** Advanced jamming resistance, protocol exploitation, swarm resilience
- **Badge:** Platinum eye sigil
- **XP range:** 30,000-100,000 XP

**Grandmaster (tech_251+)**
- **Entry requirement:** 100,000 XP + 50 wins + 5 original technique contributions
- **Unlocks:** Cutting-edge experimental strategies (pre-publication research)
- **Badge:** Diamond fractal sigil
- **XP range:** 100,000+ XP

### How Skills Unlock (Automated)

**Pattern Detection Flow:**
```
1. Match ends → UART logs uploaded
2. Pattern detection agent analyzes logs
3. Detects command sequences matching known techniques
4. Awards XP if technique contributed to victory
5. Unlocks new branches if prerequisites met
6. Updates leaderboard and skill gates
```

**Example:**
```
Match #4782 - Alice (Red Pilot) vs. Bob (Blue Pilot)
Winner: Alice

Pattern Detection Results:
✓ tech_031: Basic Channel Hopping detected (3 instances, effective)
✓ tech_087: Adaptive Channel Selection detected (7 instances, game-winning)
✗ tech_112: Deauth Attack Defense NOT detected

Awards:
Alice: +500 XP (tech_087 first unlock)
Alice: +50 XP (tech_031 usage bonus)
Alice: tech_112 now available (prerequisite tech_087 unlocked)

Creators:
Alice/Bob/Charlie: +10 XP each (tech_087 royalty)
```

---

## Bounty System

### How Bounties Work

**Bounties = Challenges to unlock new tech branches**

Each bounty tests whether you can execute a specific strategy in competitive conditions.

**Example Bounty: tech_087 (Adaptive Channel Selection)**

```yaml
id: tech_087
name: Adaptive Channel Selection
description: >
  Win a match where your swarm switches WiFi channels at least 5 times
  in response to packet loss or interference, maintaining >80% bot connectivity
  throughout the match.

prerequisites:
  - tech_031  # Basic Channel Hopping

xp_value: 500
attempts_allowed: 3
verification: automatic  # UART logs checked post-match

creators:
  - alice_berlin
  - bob_munich
  - charlie_hamburg

created: 2025-11-04
status: active
unlock_count: 47  # 47 pilots have unlocked this
```

**Bounty Lifecycle:**

1. **Creation:** LLM detects convergent evolution → proposes new bounty
2. **Validation:** LLM checks distinctness vs. existing branches
3. **Prerequisite Assignment:** LLM determines required parent skills
4. **Publication:** Auto-posted to Discord + Knowledge Commons
5. **Attempts:** Pilots try bounty in matches (max 3 attempts)
6. **Verification:** UART logs analyzed post-match (automatic)
7. **Unlock:** XP awarded if criteria met
8. **Royalties:** Creators earn 10 XP per unlock (passive income)

### Bounty Prerequisites (Strictly Enforced)

**You cannot attempt a bounty unless you have all prerequisite skills unlocked.**

```python
def can_attempt_bounty(pilot_id, bounty_id):
    """Check if pilot qualifies for bounty"""
    bounty = get_bounty(bounty_id)
    pilot_skills = get_unlocked_skills(pilot_id)

    for prereq in bounty['prerequisites']:
        if prereq not in pilot_skills:
            return False, f"Missing prerequisite: {prereq}"

    return True, "Qualified"
```

**Why This Matters:**
- Forces organic progression (can't skip fundamentals)
- Prevents impossible challenges (builds on known techniques)
- Creates natural learning curve

### Example Bounty Chain (WiFi Strategies)

**tech_031: Basic Channel Hopping (250 XP)**
- Prerequisite: tech_001 (Basic Bot Control)
- Challenge: Switch WiFi channel mid-match without losing >20% of bots
- Unlocks: tech_087, tech_056

**tech_087: Adaptive Channel Selection (500 XP)**
- Prerequisite: tech_031
- Challenge: Detect interference and auto-switch channels 5+ times
- Unlocks: tech_112, tech_098

**tech_112: Deauth Attack Defense (750 XP)**
- Prerequisite: tech_087
- Challenge: Win match while opponent attempts deauth attacks
- Unlocks: tech_134

**tech_134: Signal Strength Optimization (1000 XP)**
- Prerequisite: tech_112
- Challenge: Maintain >90% connectivity in high-interference environment
- Unlocks: tech_167 (Master tier)

---

## Pattern Detection & Meta Analysis

### Convergent Evolution Detection

**The LLM watches for pilots independently discovering similar strategies:**

```python
async def detect_convergent_evolution(match_batch):
    """Analyze 100 matches for emerging patterns"""

    # Extract command sequences from UART logs
    patterns = []
    for match in match_batch:
        for pilot in match['pilots']:
            commands = extract_commands(match['uart_logs'][pilot])
            patterns.append({
                'pilot': pilot,
                'match_id': match['id'],
                'commands': commands,
                'result': match['winner'] == pilot
            })

    # Cluster similar patterns
    clusters = cluster_patterns(patterns, similarity_threshold=0.85)

    # Find convergent evolution (3+ pilots, high similarity)
    for cluster in clusters:
        if len(set(cluster['pilots'])) >= 3:
            # LLM analyzes whether this is a new technique
            analysis = await llm_analyze_cluster(cluster)

            if analysis['is_new_technique']:
                proposal = {
                    'technique_name': analysis['name'],
                    'description': analysis['description'],
                    'creators': list(set(cluster['pilots'])),
                    'parent_skills': analysis['prerequisites'],
                    'xp_value': calculate_xp_value(cluster['win_rate']),
                    'evidence': cluster['match_ids']
                }

                # Post to Discord for community review
                await post_merge_proposal(proposal)
```

**Example Output:**
```
CONVERGENT EVOLUTION DETECTED

Technique: WiFi Packet Injection Mitigation
Pilots: 5 independent discoveries
Matches: 14 total (11 wins, 3 losses)
Win rate: +31% when technique used
First seen: Match #4821 (2025-11-12)

LLM Analysis:
"Five pilots independently developed a strategy where bots verify command
authenticity by checking sequence numbers and rejecting out-of-order packets.
This defends against packet injection attacks where hackers send fake movement
commands. All implementations use similar verification logic but different
timeout values.

Recommended merge into single branch with prerequisite: Deauth Attack Defense
(tech_112), as pilots need to understand adversarial WiFi attacks first."

Proposed Branch:
ID: tech_156
Name: Packet Injection Mitigation
Parent: tech_112 (Deauth Attack Defense)
XP Value: 1200 XP (Expert tier)
Creators: 5 pilots (equal credit)

Community Vote: Approve merge? (24h voting period)
```

### Meta-Shift Monitoring

**The LLM tracks which branches are rising/falling in effectiveness:**

```python
def analyze_meta_shifts(monthly_matches):
    """Detect rising/declining strategies"""

    branch_performance = {}

    for branch in all_branches:
        matches_using = find_matches_with_branch(monthly_matches, branch['id'])

        win_rate = calculate_win_rate(matches_using)
        usage_rate = len(matches_using) / len(monthly_matches)

        # Compare to previous month
        trend = calculate_trend(branch['id'], win_rate, usage_rate)

        branch_performance[branch['id']] = {
            'win_rate': win_rate,
            'usage_rate': usage_rate,
            'trend': trend,
            'status': determine_lifecycle_status(trend)
        }

    # Publish meta report
    publish_meta_report(branch_performance)
```

**Example Meta Report:**
```
NOVEMBER 2025 META REPORT

Rising Strategies:
🔥 tech_134: Signal Strength Optimization (+15% win rate, +40% usage)
🔥 tech_167: Multi-Channel Mesh Avoidance (+22% win rate, NEW)

Stable Strategies:
➡️ tech_087: Adaptive Channel Selection (55% win rate, 60% usage)
➡️ tech_112: Deauth Attack Defense (52% win rate, 45% usage)

Declining Strategies:
📉 tech_098: Jamming Pattern Recognition (-8% win rate, -20% usage)
   → Revival bonus: 2.0x XP for successful use (encourage innovation)

Archived Strategies:
💀 tech_042: Static Channel Assignment (0 usage for 60 days)
   → Preserved in git history, removed from active tree
```

---

## Branch Lifecycle Management

**Branches evolve through 5 states based on usage and effectiveness:**

### 1. Emerging (0-30 days old, <10 unlocks)
- **XP Multiplier:** 1.5x (encourage early adoption)
- **Survival Requirement:** 10 unlocks in 30 days OR archived
- **Purpose:** Protect experimental strategies during validation

### 2. Growing (30-90 days old, 10-50 unlocks)
- **XP Multiplier:** 1.25x (reward risk-takers)
- **Survival Requirement:** Maintain >40% win rate OR move to Declining
- **Purpose:** Nurture promising techniques

### 3. Mature (90+ days old, 50+ unlocks)
- **XP Multiplier:** 1.0x (standard value)
- **Survival Requirement:** Maintain >35% win rate OR move to Declining
- **Purpose:** Stable meta strategies

### 4. Declining (<35% win rate for 60 days)
- **XP Multiplier:** 2.0x (revival bonus)
- **Survival Requirement:** Return to >40% win rate in 90 days OR archived
- **Purpose:** Encourage counter-meta innovation

### 5. Archived (0 usage for 60 days)
- **XP Multiplier:** N/A (cannot attempt)
- **Survival Requirement:** Community vote to revive (requires proof of viability)
- **Purpose:** Preserve history without cluttering active tree

**Automatic State Transitions:**
```python
def update_branch_lifecycle(branch_id):
    """Run nightly to update branch states"""
    branch = get_branch(branch_id)
    stats = calculate_branch_stats(branch_id, days=60)

    if stats['unlock_count'] == 0 and branch['age_days'] > 60:
        return 'archived'

    if stats['win_rate'] < 0.35 and branch['status'] == 'mature':
        return 'declining'

    if stats['win_rate'] > 0.40 and branch['status'] == 'declining':
        return 'mature'  # Revival successful!

    if branch['age_days'] > 90 and stats['unlock_count'] > 50:
        return 'mature'

    if branch['age_days'] > 30 and stats['unlock_count'] > 10:
        return 'growing'

    return 'emerging'
```

---

## XP Attribution & Royalties

### Teacher Credit System

**When you help someone unlock a skill, you earn 50% of their XP:**

```python
def award_skill_unlock(pilot_id, bounty_id, match_id):
    """Award XP when pilot unlocks bounty"""
    bounty = get_bounty(bounty_id)
    pilot = get_pilot(pilot_id)

    # Base XP (adjusted for branch lifecycle)
    base_xp = bounty['xp_value']
    multiplier = get_lifecycle_multiplier(bounty['status'])
    awarded_xp = base_xp * multiplier

    # Award to pilot
    pilot['xp'] += awarded_xp
    pilot['unlocked_skills'].append(bounty_id)

    # Teacher credit (if declared)
    if pilot['declared_teacher']:
        teacher = get_pilot(pilot['declared_teacher'])
        teacher_xp = awarded_xp * 0.5
        teacher['xp'] += teacher_xp

        log_transaction({
            'type': 'teacher_credit',
            'student': pilot_id,
            'teacher': pilot['declared_teacher'],
            'bounty': bounty_id,
            'xp': teacher_xp,
            'match': match_id
        })

    # Creator royalties (passive income)
    for creator in bounty['creators']:
        creator_xp = 10  # Fixed royalty per unlock
        creator_pilot = get_pilot(creator)
        creator_pilot['xp'] += creator_xp

        log_transaction({
            'type': 'creator_royalty',
            'creator': creator,
            'bounty': bounty_id,
            'xp': creator_xp,
            'unlock_count': bounty['unlock_count']
        })
```

**Why This Matters:**
- **Incentivizes teaching:** Mentors earn XP by helping others
- **Passive income for creators:** Original innovators benefit from adoption
- **Transparent attribution:** All XP transactions logged publicly
- **Compound growth:** Teachers unlock more skills → more students → more XP

### Blueprint Sharing System

**Factorio-style copy/paste for strategies:**

```python
def export_strategy_blueprint(pilot_id, bounty_id):
    """Export winning strategy as shareable code"""
    match = get_winning_match(pilot_id, bounty_id)
    code = extract_code_from_logs(match['uart_logs'])

    blueprint = {
        'id': generate_blueprint_id(),
        'bounty': bounty_id,
        'creator': pilot_id,
        'code': code,
        'created': datetime.now(),
        'fork_count': 0,
        'attribution': {
            'teacher': get_pilot(pilot_id)['declared_teacher'],
            'branch_creators': get_bounty(bounty_id)['creators']
        }
    }

    # Encode as base64 for easy copy/paste
    encoded = base64.b64encode(json.dumps(blueprint).encode())
    return f"blueprint://{encoded.decode()}"

def import_strategy_blueprint(blueprint_string):
    """Import blueprint and attribute XP to creator"""
    encoded = blueprint_string.replace('blueprint://', '')
    blueprint = json.loads(base64.b64decode(encoded))

    # Award passive XP to creator when blueprint used
    if blueprint_used_in_match(blueprint['id']):
        creator = get_pilot(blueprint['creator'])
        creator['xp'] += 25  # Blueprint usage royalty

        log_transaction({
            'type': 'blueprint_royalty',
            'creator': blueprint['creator'],
            'blueprint': blueprint['id'],
            'xp': 25
        })
```

**Example Blueprint:**
```
blueprint://eyJpZCI6ICJicF80NTYiLCAiYm91bnR5IjogInRlY2hfMDg3IiwgImNyZWF0b3IiOiAiYWxpY2VfYmVybGluIiwgImNvZGUiOiAiZGVmIGFkYXB0aXZlX2NoYW5uZWxfc3dpdGNoKCk6XG4gICAgaWYgcGFja2V0X2xvc3MgPiAwLjI6XG4gICAgICAgIHN3aXRjaF9jaGFubmVsKCkiLCAiY3JlYXRlZCI6ICIyMDI1LTExLTA0VDEyOjM0OjU2WiIsICJmb3JrX2NvdW50IjogMTIsICJhdHRyaWJ1dGlvbiI6IHsidGVhY2hlciI6ICJib2JfbXVuaWNoIiwgImJyYW5jaF9jcmVhdG9ycyI6IFsiYWxpY2VfYmVybGluIiwgImJvYl9tdW5pY2giLCAiY2hhcmxpZV9oYW1idXJnIl19fQ==
```

**Usage Flow:**
1. Pilot wins match using tech_087
2. Exports blueprint from match replay
3. Shares blueprint link on Discord
4. Other pilots import and fork code
5. Original creator earns +25 XP per usage
6. Teachers and branch creators also credited

---

## LLM Governance Decisions

### What the LLM Decides (90% of Cases)

**Routine Operations (No Human Oversight):**
- Bounty validation (is this strategy distinct from existing?)
- Teacher credit attribution (did they actually help?)
- Badge awarding (meets skill gate criteria?)
- Branch lifecycle updates (emerging → growing → mature)
- Meta report generation (which strategies rising/falling?)

**Pattern Detection (Automated):**
- Convergent evolution detection (find similar strategies)
- Merge proposals (combine redundant branches)
- Prerequisite suggestions (what skills needed first?)
- XP value calculation (how difficult is this bounty?)

**Example LLM Decision Log:**
```json
{
  "decision_id": "dec_4821",
  "timestamp": "2025-11-15T14:23:45Z",
  "type": "branch_validation",
  "input": {
    "proposed_branch": "tech_187: Frequency Hopping Spread Spectrum",
    "description": "Use FHSS to avoid jamming attacks",
    "creator": "david_prague"
  },
  "llm_analysis": {
    "model": "claude-sonnet-4-5-20250929",
    "reasoning": "This technique is similar to existing tech_087 (Adaptive Channel Selection) but uses pseudo-random hopping instead of reactive switching. Sufficiently distinct to warrant new branch.",
    "similar_branches": ["tech_087", "tech_134"],
    "distinctness_score": 0.72,
    "recommended_parent": "tech_134"
  },
  "decision": "approve",
  "xp_value": 1500,
  "parent_skills": ["tech_134"],
  "auto_published": true
}
```

### Community Voting (10% Edge Cases)

**When LLM Defers to Humans:**
- Disputed teacher credits (conflicting claims)
- Controversial merges (community disagrees with LLM)
- Rule changes (affects game balance)
- Major governance updates (meta changes)

**Voting Process:**
```python
async def initiate_community_vote(proposal):
    """Post vote to Discord with 72h voting period"""

    # Only pilots with 5000+ XP can vote (prevents brigading)
    eligible_voters = get_pilots_above_xp(5000)

    vote_message = await discord_channel.send(f"""
🗳️ COMMUNITY VOTE REQUIRED

Proposal: {proposal['title']}
Type: {proposal['type']}
LLM Recommendation: {proposal['llm_recommendation']}

Details:
{proposal['description']}

React to vote:
✅ Approve
❌ Reject
🤔 Abstain

Voting closes: {proposal['deadline']}
Eligible voters: {len(eligible_voters)}
    """)

    await vote_message.add_reaction('✅')
    await vote_message.add_reaction('❌')
    await vote_message.add_reaction('🤔')

    # Wait 72 hours
    await asyncio.sleep(72 * 3600)

    # Tally votes
    results = await tally_votes(vote_message, eligible_voters)

    if results['approve'] > results['reject']:
        await execute_proposal(proposal)
    else:
        await reject_proposal(proposal)
```

**Example Community Vote:**
```
🗳️ COMMUNITY VOTE REQUIRED

Proposal: Merge tech_187 and tech_134
Type: Branch merger
LLM Recommendation: Approve (85% similarity)

Details:
The LLM detected that "Frequency Hopping Spread Spectrum" (tech_187) and
"Signal Strength Optimization" (tech_134) are implemented nearly identically
in 12 of 14 cases. Recommend merging to reduce tech tree clutter.

Creators of tech_187 (david_prague) disagrees, claims his approach uses
pseudo-random hopping which is fundamentally different.

React to vote:
✅ Approve merger (keep tech_134, archive tech_187)
❌ Reject merger (keep both branches)
🤔 Abstain

Voting closes: 2025-11-18 14:23 UTC
Eligible voters: 347 pilots (5000+ XP)

Results (72h later):
✅ Approve: 198 votes (57%)
❌ Reject: 124 votes (36%)
🤔 Abstain: 25 votes (7%)

OUTCOME: Merger approved. tech_187 archived, tech_134 updated with FHSS notes.
david_prague receives retroactive creator credit on tech_134.
```

---

## Competition Format (Unchanged)

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

---

## Media Production Engine

**Primary Goal:** Generate constant stream of social media content that keeps Robot Arena visible and sponsors eager to associate with the brand.

### Content Pipeline (Automated)

**Post-Match (Within 24 Hours):**
1. 60-camera UART logs + video uploaded
2. Auto-editing highlights (best moments, POV switches)
3. Strategy breakdowns (LLM analyzes winning techniques)
4. Sponsor-ready clips (branded overlays, hashtags)
5. Social media distribution (TikTok/Reels/Shorts format)

**Monthly (Meta Reports):**
1. Rising strategy videos (showcase tech_187, tech_134)
2. Top pilot interviews (explain their techniques)
3. Hacker highlight reel (most effective attacks)
4. Blueprint showcase (viral strategy shares)

### Sponsor Value Proposition

**What Sponsors Get (€100k+/year packages):**
- **Content Library Access:** Download any camera angle, any moment, any match—licensed for use in sponsor's own social channels
- **Distributed Micro-Influencer Network:** Every participant shares their bot's POV, organically promoting sponsor logos on arena/bots
- **Authentic Storytelling:** Real competition, real engineering, real drama (not staged)—content that remains interesting months later
- **Multiple Sponsor Categories:** Tech/Industrial (dataset access), Regional Development (talent showcase), Education (student recruitment), Consumer Brands (youth market), Media (broadcast rights)

---

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
10. **Virtual competitions:** Online tournaments, qualifiers, practice leagues (€10-20 entry, €10/month subscriptions)
11. **Creator royalties:** 10 XP per skill unlock + 25 XP per blueprint usage (converts to dataset access credits)

---

## Virtual Competitions (Global Accessibility)

### Integration with Physical Events

**Funnel Strategy:**
```
Free Practice in Simulator
    ↓
Monthly Online Qualifier (free)
    ↓
Top 20% → Quarterly Physical Event (€50 entry)
    ↓
Top 5 → Sponsored Travel + Accommodation
    ↓
Winners → Dataset Access + Recognition
```

**Off-Season Engagement:**
- Virtual leagues run year-round
- Physical events quarterly (high production value)
- Participants stay engaged between physical competitions
- Strategies developed online, validated physically
- Tech tree unlocks work across virtual and physical matches

**Technical Infrastructure:**
- Runs on single Mac Mini M4
- Python physics engine (60 bots @ 4Hz)
- Unreal Engine 5 (interpolates to 60fps)
- Same UART protocol as physical bots
- ML collision model trained on real match data

---

## Education Programs

### Learning Pathways

**Pathway 1: Pilot Training (Swarm Coordination)**
- **Phase 1:** Control 1 bot via button interface
- **Phase 2:** Control 3 bots simultaneously (formation basics)
- **Phase 3:** Control 10 bots with AI-assisted coding
- **Phase 4:** Control 30 bots in 90-second competitive rounds
- **Tech Tree Integration:** Each phase unlocks Apprentice → Journeyman skills

**Pathway 2: Hacker Training (IoT Security)**
- **Phase 1:** WiFi basics (monitor mode, packet capture)
- **Phase 2:** Deauth attacks (disrupt bot communication)
- **Phase 3:** Packet injection (send fake commands)
- **Phase 4:** Protocol exploitation (find vulnerabilities)
- **Tech Tree Integration:** Unlocks Zero-State Eye order skills

**Pathway 3: Builder Training (SMARS Customization)**
- **Phase 1:** Assemble stock SMARS bot from kit
- **Phase 2:** Modify one subsystem (motors, wheels, sensors)
- **Phase 3:** Design custom 3D printed parts
- **Phase 4:** Optimize firmware (faster response, better triggers)
- **Tech Tree Integration:** Unlocks Ascendant Coil order skills

### School Programs

**Middle School (Ages 11-14):**
- 6-week club using rental bots (3 bots per team)
- Focus: Apprentice skills (tech_001-025)
- Outcome: School tournament with 6-bot matches
- Cost: €200/school (rental + instructor guide)

**High School (Ages 14-18):**
- Semester-long course, hybrid rental + build approach
- Focus: Journeyman skills (tech_026-075)
- Outcome: Regional competition with full 60-bot 2v2 matches
- Cost: €500/school (rental fleet + build kits for 6 students)

**University Programs:**
- Semester course with research component
- Focus: Expert skills (tech_076-150) + original contributions
- Outcome: Academic paper + Knowledge Commons contribution
- Cost: Free (sponsored by research grants + licensing revenue)

---

## Prize Structure

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

**Creator Prizes (Tech Tree Contributions):**
- Most Unlocked Branch: €500 (technique adopted by 100+ pilots)
- Most Influential Blueprint: €300 (strategy forked 50+ times)
- Convergent Evolution Award: €200 (discovered same technique independently)

---

## The Sigil System (Orders)

Orders represent different **approaches** to competitive swarm robotics, not skill levels. All Orders can compete in all divisions.

**⟡ Order of the Fractured Gear**
- **Approach:** Accept imperfection, learn through rental bots or first resurrection
- **Sigil:** Broken gear with seven fragments
- **Tech Tree Focus:** Apprentice skills (tech_001-025)

**⟡ Order of the Ascendant Coil**
- **Approach:** Transform through modification (SMARS customs or successful resurrections)
- **Sigil:** Vertical coil rising through upward triangle
- **Tech Tree Focus:** Journeyman skills (tech_026-075)

**⟡ Order of the Twin Sparks**
- **Approach:** Unite old hardware with new intelligence (50cm custom platforms, major innovations)
- **Sigil:** Two dots connected by lightning
- **Tech Tree Focus:** Expert/Master skills (tech_076-250)

**⟡ Order of the Zero-State Eye**
- **Approach:** Hacker track, IoT security research
- **Sigil:** Horizontal oval eye with single pixel center
- **Tech Tree Focus:** WiFi attack/defense techniques

---

## Guild Structure (Decentralized Expansion)

**Initiates** (Individual Competitors)
- Purchase Awakening Modules or compete with rental/custom bots
- Contribute to Knowledge Commons (match data, resurrection guides, mods)
- Earn XP through tech tree progression

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
- Transparent income disclosure published annually

---

## Success Metrics

**Technical Automation (Achievable by One Person):**
- 90% of governance decisions handled by LLM (no manual approvals)
- Tech tree grows organically (3+ convergent evolution detections per month)
- Pattern detection accuracy: >80% (correctly identifies distinct strategies)
- Discord agent response time: <30 seconds average
- Community voting participation: >50% of eligible pilots

**Community Engagement:**
- 500+ active pilots in tech tree progression (Year 1)
- 50+ new branches created per quarter (organic growth)
- 10,000+ blueprint shares per year (strategy propagation)
- 100+ convergent evolution events detected (proof of living meta)

**Business Impact:**
- Validates €50k+ dataset licensing prices (proof of self-organizing ecosystem)
- Expands participant base 10x (global accessibility via automation)
- Reduces operational overhead 80% (no manual league management)
- Generates synthetic training data for edge cases (declining branches)

---

For complete technical architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For dataset integration, see [Knowledge Commons README](../01-knowledge-commons/README.md).

For virtual competition details, see [Virtual Arena Simulator README](../04-virtual-arena-simulator/README.md).
