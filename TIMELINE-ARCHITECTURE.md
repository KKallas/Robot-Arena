# Timeline Architecture: Universal Event Storage

## Core Concept

Two-tier data capture system:
1. **Live timeline** - CSV events written during match, available for real-time playback
2. **Per-drone logs** - Detailed ESP32 logs downloaded after match for debugging and simulator training

Single git commit after match captures everything. Timestamps enable playback without git commits during match.

## Event Format (Live Timeline)

Four fields: timestamp, event_type, executed_by, data

**timestamp** - Milliseconds since match start (e.g., 0, 1234, 12340, 45670, 90000)

**event_type** - Category tag (limited set, defined during implementation)

**executed_by** - Source: user, ai, script_name, system, bot_id

**data** - Event-specific information (pipe-separated)

Append-only. File grows during match.

## Git Storage Strategy

**No commits during live match** - timestamps handle playback, committing wastes time.

**Single commit after match ends:**
- All processes flush and close files
- events.csv contains complete timeline with millisecond timestamps
- Per-drone logs downloaded from all ESP32s
- One git commit captures everything
- Tag with match_end
- Push to repository

**Why single commit works:**
- Millisecond timestamps in CSV provide playback granularity
- Playback reads CSV and filters by timestamp
- No need for git history during match
- Faster (no commit overhead during critical 90 seconds)
- Simpler (one commit, one snapshot)

## Playback Strategy

**Timestamp-based, not git-based:**
- UI reads events.csv (complete timeline)
- User scrubs timeline by filtering timestamp ranges
- Jump to t=45s = show all events where timestamp <= 45000
- No git checkout needed for playback
- Git only for storage and distribution

**Playback mechanism:**
- Load entire events.csv into memory
- Filter events by timestamp range (millisecond precision)
- Display filtered events in UI panels
- Sync with YouTube video timestamp

## Two-Tier Data Capture

### Tier 1: Live Timeline (events.csv)

**Available during match** - written in real-time by external processes.

Contains high-level events:
- Pilot commands to AI
- AI responses and script uploads
- Bot positions (sampled, not every command)
- WiFi disruptions detected
- Match events (goals, penalties)

**Purpose:** Live playback, spectator view, immediate analysis.

**File grows during match, available immediately for playback.**

### Tier 2: Per-Drone Logs

**Downloaded after match** - stored on each ESP32 during match.

Contains detailed internal state:
- Every motor command executed
- Every sensor reading
- WiFi packet counters
- Script execution traces
- Timing diagnostics
- Internal ESP32 timestamps

**Purpose:** Post-match debugging, simulator training, detailed analysis.

**Download process:**
- Match ends
- Script connects to each bot via WiFi
- Downloads log file from ESP32 flash storage
- Saves as bot_01_internal.log, bot_02_internal.log, etc.
- Commits to git alongside events.csv

**These logs not available during live match** - only after download completes.

## The executed_by Field

Tracks decision authority in live timeline. Answers: who made this decision at this moment?

**Values:**
- user = pilot manually initiated
- ai = AI copilot initiated
- script_name = autonomous script running
- system = match infrastructure
- bot_id = individual bot telemetry

**Purpose:** Dataset buyers analyze trust patterns, AI latency tolerance, automation handoff, rejection behavior, learning curves.

This field makes the dataset valuable. Without it, just telemetry. With it, human-AI collaboration data under time pressure.

## Event Categories

Human input, AI responses, bot telemetry, WiFi events, match events, script events, system events.

Specific type numbering defined during implementation.

## File Structure

Match folder contains:
- **events.csv** - Live timeline (written during match, timestamp in milliseconds)
- **bot_01_internal.log** through **bot_20_internal.log** - Per-drone logs (downloaded after match)
- **match_metadata.txt** - Match info (teams, outcome, duration)
- **video_url.txt** - YouTube sync link

Two-tier data: live events for playback, internal logs for debugging/training.

## UI Integration

Four panels read events.csv and filter by event_type or executed_by.

AI Chat panel: user and ai events
Bot Visualization: bot telemetry events
Python Terminal: script execution events
System Log: other events

UI doesn't store data. Reads events.csv. File is truth.

Playback scrubber filters by timestamp (millisecond precision).

## Simulator

Simulator writes identical events.csv format with millisecond timestamps. Playback browser works for both physical and simulated matches.

Train simulator on per-drone logs from physical matches. Generate synthetic matches. Compare predictions vs actual. Accuracy validates dataset quality.

## CSV Choice

Text format for git-friendly diffs, universal readability, debuggability. 90-second match with 20 bots @ 10Hz = roughly 1-2MB. Acceptable for git.

Millisecond timestamps provide sufficient granularity without binary format complexity.

Optimize to binary format later only if file size or write performance becomes bottleneck.

## Core Principle

Storage format IS the product. Everything consumes or produces this format.

Single timeline, four fields, append-only, timestamp-based playback, git-tracked post-match.
