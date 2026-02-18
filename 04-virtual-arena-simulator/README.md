# Virtual Arena Simulator

**Purpose:** Lightweight, open-source simulator that validates dataset quality through offline batch rendering and autobattler match format.

## What It Is

**Autobattler format.** 90-second matches with no operator interference. Pilots prepare their Python packages in advance with LLM assistance, upload them, and the simulation runs autonomously. Strategy generation "on the go" is a future enhancement.

**Deliberately lo-fi aesthetic.** Low-poly bots, CRT scan lines, pixel-perfect collision boxes, retro UI. Technical constraints (4Hz updates, single Mac Mini) become stylistic choices—computational brutalism that accelerates development.

**Think:** Automated chess match + offline video production + hacker terminal aesthetic. Not realtime—batch processed for scalability.

## Core Technology Stack

**All open source, runs on single Mac Mini M4:**

- **Blender** (offline rendering) - open source, scriptable, lo-fi cyberpunk aesthetic
- **Python game server** (no physics engine) - cluster detection, ML-based position prediction
- **ML Predictor** - takes last 5 keyframes, predicts next + % match to original data
- **Same Python code** - identical swarm code runs in simulator as on physical bot phones
- **CSV timeline format** - writes identical events.csv as physical matches

## The Autobattler Format

**90-second matches with no operator interference during the match:**

**How it works:**
1. Pilots prepare Python packages with LLM assistance (Claude, ChatGPT)
2. Packages are uploaded and signed before match start
3. Match runs autonomously—no manual intervention allowed
4. Results rendered offline and delivered as video

**Why autobattler:**
- Forces pilots to encode complete strategies in advance
- AI copilot collaboration happens during preparation, not execution
- Captures strategic planning data, not just reaction data
- Matches can be queued and batch-processed for scalability

**Future enhancement:** Strategy generation "on the go" where bots can request LLM assistance mid-match.

## Battle Reproducibility

**Each battle is a complete, verifiable repository:**

**Deterministic execution:**
- Same input packages + same ML predictor = same output every time
- No random seeds, no non-deterministic operations
- Anyone can clone the battle repo and verify results

**Battle repo structure:**
```
battle-2026-01-07-001/
├── inputs/
│   ├── team_red_package.py      # Signed strategy package
│   ├── team_blue_package.py     # Signed strategy package
│   └── match_config.json        # Arena setup, bot assignments
├── ml-predictor/
│   └── predictor_v1.npz         # Exact ML model version used
├── outputs/
│   ├── events.csv               # Complete event timeline
│   ├── keyframes.json           # All position data
│   └── prediction_log.json      # Which training data was matched
├── verification/
│   └── checksums.sha256         # Verify all outputs match
└── README.md                    # How to reproduce this battle
```

**Prediction transparency:**
- Each prediction logs which original match data was referenced
- Shows % similarity to training data (e.g., "87% match to match-2025-12-15-042")
- Different input matches used for prediction = only difference in output

## Game Server Architecture

**Python-based game server (no physics engine):**

**Cluster detection:**
- Identify bots that are close and need to react to each other
- Group nearby bots into interaction clusters
- Only compute detailed interactions within clusters

**Position prediction (ML-based):**
- Input: Last 5 keyframes (positions, velocities, rotations)
- Output: Next keyframe prediction + % match to original data
- Reports which original training track(s) were used
- 4Hz update rate (250ms intervals)

**ML Predictor:**
- Pre-computed from real recorded world data
- Takes last 5 keyframes, predicts next keyframe
- Returns % similarity to original training data
- Faster than physics simulation, validated against real data
- Deterministic: same inputs always produce same outputs

## Why It Matters

**Proof of Dataset Quality:**
When simulator achieves 85%+ position accuracy, proves dataset captures genuine multi-agent physics. Validates €50k+ commercial licensing.

**Validation Metrics (Published Monthly):**
- Position RMSE: Target >85% (within 10cm after 90 seconds)
- Collision accuracy: Target >80% (velocity matching)
- Goal detection: Target >85% (vision simulation)

**Open source validation:**
- All code on GitHub
- Anyone can audit prediction accuracy
- Community can contribute improvements
- No black-box simulation

## Architecture: Open Source Stack

See [ARCHITECTURE.md](../ARCHITECTURE.md) for complete technical details.

**Design principle:** Everything open source, everything lightweight, everything debuggable.

### `/game-server/` (Python)
Game loop running at 4Hz:
- Updates 60 bot positions every 250ms
- Cluster-based interaction detection
- ML prediction: last 5 keyframes → next keyframe + % match
- Logs which original training data was used for each prediction
- Writes to events.csv (same format as physical matches)
- Outputs position timeline for Blender rendering

**Why Python:** Readable, debuggable, same language as match analysis tools. Not hidden in compiled binary.

### `/blender-renderer/` (Blender 4.x)
Offline batch rendering with lo-fi cyberpunk aesthetic:
- Reads position timeline after match completion
- Renders all camera angles in parallel
- Low-poly 3D models, chunky pixels, CRT scan lines
- Visible wireframe collision boxes, grid floor with coordinates
- Multiple camera outputs (top-down + bot POV angles)
- Exports final video files (MP4/WebM)

**Why lo-fi works:**
- Low-poly models = faster to create, easier to render 60 bots
- Pixelated aesthetic = masks imperfect position interpolation
- Wireframe collision boxes = shows decision boundaries
- Grid coordinates = makes bot positions debuggable
- Terminal aesthetic = feels like hacker tool, not toy
- **Accelerates development with limited resources**

**Why Blender:**
- Fully open source (GPL license)
- Python scripting for automation
- Headless rendering (no GUI needed)
- Production-quality output
- Cross-platform (Mac, Linux, Windows)
- Active community

### Offline/Batch Processing Benefits

**Scalability for limited compute resources:**
- Matches can be prepared, signed, and queued
- Non-realtime simulation allows batch processing
- Multiple matches rendered sequentially on single machine
- Peak demand smoothed across available compute time
- No need for low-latency infrastructure

### `/web-interface/` (Flask + Terminal UI)
Match preparation and results interface:
- ASCII art dashboard (looks like tmux/screen)
- Terminal-style command input
- Package upload and signing
- Match queue management
- Results video playback
- Monospace font, limited colors

**Aesthetic goal:** Feels like SSH session into match server, not polished web app.

### `/ml-predictor/` (Python + NumPy)
ML-based position predictor built from real match data:
- Source: Per-node logs from physical matches
- Input: Last 5 keyframes (positions, velocities, rotations)
- Output: Next keyframe prediction + % match to original training data
- Structure: Indexed by path similarity vectors for fast lookup
- Reports which original track(s) were used for prediction
- Size: ~50MB compressed database

**Reproducibility:** Same inputs always produce same outputs. Each prediction includes reference to source match data with percentage similarity score.

**Open source:** Anyone can rebuild from datasets, audit prediction logic, contribute improvements.

### `/assets/`
All visual assets open source:
- Pixel art bot sprites (8x8, 16x16, 32x32)
- CRT shader code (scan lines, chromatic aberration)
- Grid floor texture with coordinate labels
- Monospace terminal fonts
- Color palettes (cyberpunk cyan/magenta/yellow)

**License:** CC0 or MIT, anyone can fork and customize.

## Development Timeline

**Single developer, part-time (choosing lightweight stack accelerates timeline):**
- Month 1: Python game server + cluster detection
- Month 2: Collision LUT builder + position prediction
- Month 3: Blender rendering pipeline + automation scripts
- Month 4: Package upload/signing + match queue system
- Month 5: Flask terminal UI + results delivery
- Month 6: Polish, testing, documentation
- **Total: 6 months MVP**

**Why faster:**
- Offline rendering = no realtime synchronization complexity
- Blender Python scripting = automated pipeline
- Collision LUT = no physics engine needed
- Batch processing = simpler infrastructure
- Autobattler format = no live interaction handling

## Usage

**For Competitors:**
- Prepare strategy packages with LLM assistance
- Upload signed packages for 90-second autobattler matches
- Review rendered match videos to refine strategies
- Compete in online qualifiers (€10 entry)
- Top performers invited to physical events

**For Commercial Licensees:**
- See validation metrics before purchasing dataset
- Test your swarm algorithms in proven simulator
- Request custom scenarios (€3k validation service)

**For Researchers:**
- Cite sim-to-real papers using this dataset
- Access simulator for academic research (free)
- Contribute improvements to ML models

## Revenue Streams

- Virtual tournaments: €10-20 entry fees
- Practice subscriptions: €10/month unlimited access
- Corporate workshops: €1k/day custom scenarios
- Validation services: €3k to test client algorithms

**Year 2 Target:** €150k revenue from virtual operations

## Success Metrics

**Technical (Achievable by One Person):**
- Sim-to-real position accuracy: >85%
- System uptime: >95%
- Development time: 8-12 months

**Business:**
- Validates €50k+ dataset licensing prices
- Expands participant base 10x (global accessibility)
- Generates synthetic training data for edge cases

---

For detailed architecture, see [ARCHITECTURE.md](../ARCHITECTURE.md).

For business context, see main [README.md](../README.md#virtual-arena-simulator-proof-of-dataset-value).
