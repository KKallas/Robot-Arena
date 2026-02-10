# Testing Checklist: Contribute Scripts

## Test Issue

Create this issue on GitHub to test the workflow:

**Title:** `Take all documentation about the "Simulation" ML model and make sure there are no major contradictions`

**Body:**
```
The simulation documentation is spread across multiple files. Need to:
1. Find all references to the ML simulation model
2. Check for contradictions
3. Ask user to clarify if needed
4. Create short spec for 0.1 Alpha release
5. Create test plan
6. Split into tasks

Files that might contain simulation info:
- ARCHITECTURE.md
- 04-virtual-arena-simulator/README.md
- 01-knowledge-commons/README.md

This is a research/consolidation task, not a coding task.
```

---

## Phase 1: Dry Run Testing (No Claude, No GitHub)

### 1.1 Test moderate_issues.py --dry-run

```bash
cd /Users/kasparkallas/Documents/GitHub/Robot-Arena
python3 moderate_issues.py --dry-run
```

**Expected:**
- [ ] Shows "DRY RUN MODE" banner
- [ ] Lists issues needing moderation (or says "No issues")
- [ ] Does NOT call Claude
- [ ] Does NOT modify any GitHub issues
- [ ] Shows prompt preview for each issue

### 1.2 Test moderate_issues.py --dry-run --issue N

```bash
python3 moderate_issues.py --dry-run --issue <YOUR_ISSUE_NUMBER>
```

**Expected:**
- [ ] Shows details for specific issue
- [ ] Shows prompt that would be sent to Claude
- [ ] Does NOT call Claude or GitHub

### 1.3 Test contribute.sh moderate --dry-run

```bash
./contribute.sh moderate --dry-run
```

**Expected:**
- [ ] Shows banner with "DRY RUN" warning
- [ ] Passes through to Python script correctly
- [ ] Same behavior as direct Python call

### 1.4 Test contribute.sh solve --dry-run

```bash
./contribute.sh solve --dry-run
```

**Expected:**
- [ ] Shows banner with "DRY RUN" warning
- [ ] Finds llm-ready issues (or says none found)
- [ ] Shows "[TEST] Would claim issue" message
- [ ] Does NOT actually claim issue on GitHub
- [ ] Does NOT run Claude

---

## Phase 2: Test Mode (Claude Runs, No GitHub)

### 2.1 Test moderate_issues.py --test --issue N

```bash
python3 moderate_issues.py --test --issue <YOUR_ISSUE_NUMBER>
```

**Expected:**
- [ ] Shows "TEST MODE" banner
- [ ] Shows issue details
- [ ] Runs Claude with the prompt
- [ ] Claude output shows "[TEST] Would run: gh issue comment..."
- [ ] Claude does NOT actually post to GitHub
- [ ] Shows "✅ Test completed. No changes made to GitHub."

### 2.2 Test contribute.sh moderate --test

```bash
./contribute.sh moderate --test --max 1
```

**Expected:**
- [ ] Shows "TEST MODE" warning
- [ ] Runs Claude on first issue
- [ ] Claude outputs what it WOULD do
- [ ] No GitHub changes made

### 2.3 Test contribute.sh solve --test

```bash
./contribute.sh solve --test
```

**Expected:**
- [ ] Shows "TEST MODE" warning
- [ ] Finds llm-ready issue
- [ ] Shows "[TEST] Would claim issue"
- [ ] Runs Claude on the issue
- [ ] Claude makes file changes locally (in /tmp)
- [ ] Shows "[TEST] Would commit and push"
- [ ] Shows "[TEST] Would create PR"
- [ ] Does NOT actually push or create PR

---

## Phase 3: Live Mode (Actual GitHub Operations)

⚠️ **Only run these after Phase 1 and 2 pass!**

### 3.1 Test moderate_issues.py LIVE on test issue

```bash
python3 moderate_issues.py --issue <YOUR_ISSUE_NUMBER>
```

**Expected:**
- [ ] Shows "LIVE MODE" banner
- [ ] Runs Claude
- [ ] Claude actually posts comment on GitHub issue
- [ ] Check GitHub issue for comment
- [ ] Comment asks clarifying questions OR proposes format

### 3.2 Respond to the issue on GitHub

On GitHub, reply to the bot's comment with clarification.

**Expected:**
- [ ] Your reply appears on the issue

### 3.3 Run moderate again

```bash
python3 moderate_issues.py --issue <YOUR_ISSUE_NUMBER>
```

**Expected:**
- [ ] Claude sees previous comments
- [ ] Claude either asks more questions OR formats the issue
- [ ] If formatted, adds `llm-ready` label

### 3.4 Test contribute.sh solve LIVE

Once issue has `llm-ready` label:

```bash
./contribute.sh solve
```

**Expected:**
- [ ] Claims issue (adds `in-progress` label)
- [ ] Clones repo to /tmp
- [ ] Runs Claude to solve issue
- [ ] Makes changes
- [ ] Commits and pushes to branch
- [ ] Creates PR linking to issue
- [ ] Comments on issue with PR link

---

## Verification Checklist

After live testing, verify on GitHub:

### Issue State
- [ ] Issue has `in-progress` label (during processing)
- [ ] Issue has comment "🤖 Auto-contributor starting work..."
- [ ] Issue has comment "🤖 PR created: <url>"

### PR State
- [ ] PR exists with title "[AUTO] <issue title>"
- [ ] PR body has "Closes #<issue>"
- [ ] PR shows file changes
- [ ] PR shows validation output

### If Failure
- [ ] Issue `in-progress` label removed
- [ ] Issue has comment explaining error

---

## Cleanup

After testing:

```bash
# Close test issue if not needed
gh issue close <NUMBER> --repo kasparkallas/Robot-Arena

# Delete test branch if created
git push origin --delete auto/issue-<NUMBER>

# Close test PR if created
gh pr close <NUMBER> --repo kasparkallas/Robot-Arena
```

---

## Quick Reference

| Command | Claude | GitHub | Use Case |
|---------|--------|--------|----------|
| `--dry-run` | ❌ No | ❌ No | Preview issues, check prompts |
| `--test` | ✅ Yes | ❌ No | Test Claude responses safely |
| (no flag) | ✅ Yes | ✅ Yes | Production use |

## Troubleshooting

**"claude CLI not found"**
```bash
npm install -g @anthropic-ai/claude-code
claude login
```

**"gh not authenticated"**
```bash
gh auth login
```

**"No issues need moderation"**
- Check if issues have `llm-ready` or `needs-human` labels
- Those are excluded from moderation

**"No llm-ready issues found"**
- Run moderate first to format issues
- Or manually add `llm-ready` label to test issue
