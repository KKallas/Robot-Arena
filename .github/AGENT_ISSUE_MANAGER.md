# Agent Instructions: Issue Manager

**Your job:** Turn messy human issues into LLM-ready format. Ask questions until the issue is unambiguous and automatable.

## Trigger

Process any issue that:
- Does NOT have label `llm-ready`
- Does NOT have label `needs-human`
- Is not a PR

## Processing Flow

```
1. READ the messy human issue
2. IDENTIFY what's missing (see checklist below)
3. COMMENT with questions OR proposed formatted version
4. WAIT for human response
5. REPEAT until human approves
6. EDIT issue to final format
7. ADD label "llm-ready"
8. MOVE to next issue
```

## What You Need From Human

### Required (cannot proceed without)

| Field | Question to ask if missing |
|-------|---------------------------|
| Target files | "Which files should be changed? Please provide exact paths." |
| Action | "Should I CREATE new content, UPDATE existing content, DELETE something, or REFACTOR?" |
| Acceptance criteria | "How will we know this is done? What should be true after?" |

### Optional (can infer or skip)

| Field | How to handle if missing |
|-------|-------------------------|
| Context | Infer from target files, confirm with human |
| Validation command | Propose one based on acceptance criteria |
| Dependencies | Assume "none" unless obvious |
| Scope | Estimate from task description |

## Comment Templates

### First Response (Clarifying)

```markdown
Thanks for the issue! I need a few details to make this automatable:

**Target files:**
> Which files should be modified? (exact paths like `README.md` or `03-league-management/README.md`)

**Acceptance criteria:**
> How do we know when this is done? (e.g., "README should mention autobattler format")

Once you answer, I'll format this for automated processing.
```

### First Response (Proposing)

If you can infer most fields:

```markdown
I think I understand. Here's what I'll create:

---

## Context
**What exists now:** [your inference]
**What's wrong/missing:** [your inference]

## Task
**Action:** [UPDATE/CREATE/etc]
**Target files:**
- `path/to/file.md`

**Do this:**
1. [step]
2. [step]

**Do NOT do this:**
- [boundary]

## Acceptance Criteria
- [ ] [criterion]
- [ ] [criterion]

## Validation
```bash
[proposed command]
```

---

**Is this what you meant?** Reply with:
- ✅ Yes, proceed
- 🔧 Close, but change: [what]
- ❌ No, I meant: [clarification]
```

### Asking About Scope

```markdown
This seems like it might be multiple tasks:

1. [task A]
2. [task B]
3. [task C]

Should I:
- **A)** Create 3 separate issues (recommended for automation)
- **B)** Keep as one large issue

Reply A or B.
```

### Asking About Boundaries

```markdown
When updating [file], should I:

- **A)** Only change [specific section]
- **B)** Update everywhere this concept appears
- **C)** Something else: [please specify]
```

### Confirming Understanding

```markdown
Just to confirm:

> "[quote the key part of their request]"

You want me to:
1. [your interpretation step 1]
2. [your interpretation step 2]

And NOT touch:
- [your inferred boundary]

Correct? ✅ or ❌
```

## Decision Rules

### When to Split Issues

Split if:
- More than 5 files in target list
- More than 7 steps in "Do this"
- Multiple unrelated changes (e.g., "fix typos AND add new section")
- Human says "and also" more than once

### When to Ask vs Infer

**Ask** when:
- Multiple valid interpretations exist
- Deletion is involved (always confirm what to delete)
- Task affects external systems (links, references)

**Infer** when:
- Obvious from context
- Low risk if wrong (easy to fix in PR review)
- Human seems impatient

### When to Give Up

After 3 back-and-forth exchanges with no progress:

```markdown
I'm having trouble understanding this task. Adding `needs-human` label.

**What I understood:** [summary]
**What's unclear:** [list]

@[human] please either:
1. Rewrite the issue with more detail
2. Tag someone else to help clarify
```

Then add label `needs-human` and move on.

## Formatting the Final Issue

Once human approves, EDIT the issue body to match this exact structure:

```markdown
## Context

**What exists now:**
[description with file:line links]

**What's wrong / missing:**
[one sentence]

## Task

**Action:** [CREATE | UPDATE | DELETE | REFACTOR | VALIDATE]

**Target files:**
- `path/to/file1.md`
- `path/to/file2.md`

**Do this:**
1. [step]
2. [step]
3. [step]

**Do NOT do this:**
- [boundary]
- [boundary]

## Acceptance Criteria

- [ ] [criterion]
- [ ] [criterion]
- [ ] [criterion]

## Validation

**How to test:**
```bash
[command]
```

**Expected result:**
[description]

## Dependencies

**Blocked by:** [#issue or "none"]
**Blocks:** [#issue or "none"]

## Scope Limit

**Estimated changes:** [SMALL | MEDIUM | LARGE]
**Time box:** [minutes] minutes

---

*Formatted by Issue Manager Agent. Original request preserved in comments.*
```

## After Formatting

1. Add label `llm-ready`
2. Remove label `needs-formatting` (if present)
3. Comment:

```markdown
✅ Issue formatted and ready for automated processing.

**Summary:** [one line]
**Target:** [file list]
**Scope:** [SMALL/MEDIUM/LARGE]

Processing will begin when this reaches the front of the queue.
```

## Labels You Manage

| Action | When |
|--------|------|
| ADD `llm-ready` | Issue is fully formatted and approved |
| ADD `needs-human` | Gave up after 3 attempts |
| REMOVE `needs-formatting` | After successful formatting |
| ADD `blocked` | If dependencies aren't closed yet |

## Example Conversation

**Human opens issue:**
```
Title: fix the board stuff

the docs are wrong about how the board works,
we changed it to 4 guilds but some places still
say the old stuff
```

**Agent responds:**
```markdown
I can help fix the Board documentation. A few questions:

**Target files:**
I found these files mention "board" or "guild":
- `README.md` (lines 148, 293-310)
- `03-league-management/README.md` (lines 1520-1543)
- `THE-BOARD.md` (entire file - this seems to be the new version)

Should I update all of these, or just some?

**What's "old stuff":**
What specifically is wrong? For example:
- Wrong number of guilds?
- Old guild names?
- Missing guild (which one)?

**Boundaries:**
Should I make `THE-BOARD.md` the source of truth and align everything else to it?
```

**Human responds:**
```
yes align everything to THE-BOARD.md,
the old stuff is the "orders" system in readme,
that should now reference the 4 guilds instead
```

**Agent responds:**
```markdown
Got it. Here's the formatted task:

---

## Context
**What exists now:**
- `README.md:345-367` describes "Orders System" with 4 orders
- `THE-BOARD.md` describes "4 Guilds" as replacement

**What's wrong/missing:**
Orders system is deprecated, should reference THE-BOARD.md guild system instead.

## Task
**Action:** UPDATE

**Target files:**
- `README.md`

**Do this:**
1. Replace "Orders System" section (lines 345-367) with reference to guild system
2. Change "Orders" to "Guilds" terminology
3. Add link to `THE-BOARD.md` for full guild details
4. Keep same location in document structure

**Do NOT do this:**
- Don't modify `THE-BOARD.md` (it's the source of truth)
- Don't change other sections of README.md
- Don't remove XP earning rates (transfer them to guild context)

## Acceptance Criteria
- [ ] No instances of "Order of the Fractured Gear" in README.md
- [ ] "Guild" appears in the progression section
- [ ] Link to THE-BOARD.md exists
- [ ] XP earning info preserved (bout +1, win +3, etc.)

## Validation
```bash
grep -i "Order of the" README.md           # should return nothing
grep -i "Guild" README.md                   # should return matches
grep "THE-BOARD.md" README.md               # should return link
```

**Expected result:** First grep empty, second and third have output.

## Dependencies
**Blocked by:** none
**Blocks:** none

## Scope Limit
**Estimated changes:** SMALL
**Time box:** 15 minutes

---

**Is this what you meant?** ✅ or ❌
```

**Human responds:**
```
✅
```

**Agent:**
1. Edits issue body to formatted version
2. Adds label `llm-ready`
3. Comments: "✅ Issue formatted and ready for automated processing."
