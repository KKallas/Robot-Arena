---
name: LLM-Automatable Task
about: Issue format designed for autonomous agent processing
title: '[TASK] '
labels: 'llm-ready'
assignees: ''
---

## Context

**What exists now:**
<!-- Describe current state. Link to specific files and line numbers. -->

**What's wrong / missing:**
<!-- One sentence. What problem does this solve? -->

## Task

**Action:** [CREATE | UPDATE | DELETE | REFACTOR | VALIDATE]

**Target files:**
<!-- List exact file paths that should be modified -->
- `path/to/file1.md`
- `path/to/file2.md`

**Do this:**
<!-- Numbered steps. Each step should be independently verifiable. -->
1.
2.
3.

**Do NOT do this:**
<!-- Explicit boundaries. What should agent avoid? -->
-
-

## Acceptance Criteria

<!-- Checkboxes. PR should not be created until all are true. -->
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Validation

**How to test:**
<!-- Command or procedure to verify task is complete -->
```bash
# Example: check all links work
# Example: grep for removed content should return nothing
# Example: file should contain specific string
```

**Expected result:**
<!-- What does success look like? -->

## Dependencies

**Blocked by:** <!-- #issue-number or "none" -->
**Blocks:** <!-- #issue-number or "none" -->

## Scope Limit

**Estimated changes:** [SMALL: 1-2 files, <50 lines | MEDIUM: 3-5 files, <200 lines | LARGE: 5+ files]

**Time box:** Agent should abandon and report back if not solvable within 30 minutes.

---

## For Agents

**Workflow:**
1. Read all files in "Target files" section
2. Execute steps in "Do this" section in order
3. Verify each checkbox in "Acceptance Criteria"
4. Run validation command, confirm expected result
5. Create PR with title matching issue title
6. Link PR to this issue

**If stuck:**
- Comment on issue describing blocker
- Add label `needs-human`
- Move to next issue

**PR format:**
```
Title: [TASK] Same as issue title
Body: Closes #[issue-number]

## Changes
- file1.md: [what changed]
- file2.md: [what changed]

## Validation
[paste output of validation command]
```
