# Test Issue: Simulation Documentation Consolidation

Use this to create the test issue on GitHub.

---

## Issue Title

```
[TASK] Consolidate Simulation ML Model Documentation
```

## Issue Body

```markdown
## Context

**What exists now:**
Simulation/ML model documentation is spread across multiple files:
- `ARCHITECTURE.md` - ML Collision Predictor section
- `04-virtual-arena-simulator/README.md` - Simulation overview
- `01-knowledge-commons/README.md` - Dataset sections

**What's wrong / missing:**
Need to verify consistency and create a focused spec for v0.1 Alpha release.

## Task

**Action:** VALIDATE + CREATE

**Target files:**
- `ARCHITECTURE.md`
- `04-virtual-arena-simulator/README.md`
- `01-knowledge-commons/README.md`
- (NEW) `04-virtual-arena-simulator/SPEC-0.1-ALPHA.md`

**Do this:**
1. Read all simulation-related documentation
2. List any contradictions found (if any, comment to ask for clarification)
3. If no contradictions, create `SPEC-0.1-ALPHA.md` with:
   - Core features for 0.1 release (minimum viable)
   - Input/output specification
   - Test plan (what to validate)
4. Add a section listing tasks for implementation

**Do NOT do this:**
- Don't modify existing documentation (only read and validate)
- Don't implement any code (spec only)
- Don't add features beyond minimum viable

## Acceptance Criteria

- [ ] All simulation references reviewed
- [ ] Contradictions listed (or confirmed none exist)
- [ ] SPEC-0.1-ALPHA.md created with clear scope
- [ ] Test plan included
- [ ] Tasks listed for next phase

## Validation

**How to test:**
```bash
# New spec file exists
test -f 04-virtual-arena-simulator/SPEC-0.1-ALPHA.md && echo "PASS: Spec file exists"

# Spec has required sections
grep -q "## Core Features" 04-virtual-arena-simulator/SPEC-0.1-ALPHA.md && echo "PASS: Has features"
grep -q "## Test Plan" 04-virtual-arena-simulator/SPEC-0.1-ALPHA.md && echo "PASS: Has test plan"
grep -q "## Tasks" 04-virtual-arena-simulator/SPEC-0.1-ALPHA.md && echo "PASS: Has tasks"
```

**Expected result:** All three PASS messages printed.

## Dependencies

**Blocked by:** none
**Blocks:** Implementation tasks (to be created from this spec)

## Scope Limit

**Estimated changes:** MEDIUM
**Time box:** 30 minutes
```

---

## To Create This Issue

```bash
gh issue create \
  --repo kasparkallas/MechArena \
  --title "[TASK] Consolidate Simulation ML Model Documentation" \
  --body-file TEST-ISSUE-SIMULATION.md \
  --label "llm-ready"
```

Or create manually on GitHub and paste the body above.

---

## What This Tests

1. **Moderate mode:** If you create WITHOUT `llm-ready` label, the moderator should:
   - Read the messy issue
   - Propose a formatted version OR ask clarifying questions
   - Eventually add `llm-ready` label

2. **Solve mode:** Once `llm-ready`:
   - Claude reads the target files
   - Claude creates the spec document
   - Claude creates PR

---

## Key Simulation Documentation Locations

For reference, here's where simulation info lives:

### ARCHITECTURE.md
- Lines 461-517: Virtual Arena Simulator overview
- Lines 519-642: Virtual Bot Implementation
- Lines 644-751: ML Collision Predictor
- Lines 789-819: Dataset Flywheel

### 04-virtual-arena-simulator/README.md
- Lines 1-186: Complete simulator overview
- ML model: 4Hz physics, grid-based collision
- Aesthetic: Cyberpunk/lo-fi (intentional)
- Technology: Godot + Python + PyTorch

### 01-knowledge-commons/README.md
- Lines 112-186: ML datasets section
- Lines 141-186: Collision events extraction
- Lines 165-186: Sim-to-real validation

### Key Technical Claims to Validate
- Physics: 4Hz (250ms intervals)
- Bots: 60 per match
- ML Input: Pre-collision state (pos, vel, mass, angle)
- ML Output: Post-collision state (velocities, damage)
- Accuracy target: 85%+ position RMSE
- Model size: ~500KB
- Inference: <1ms on M4 Neural Engine
