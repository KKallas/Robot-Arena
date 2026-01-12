# Virtual Arena Simulator

**Purpose:** Lightweight, open-source simulator that validates dataset quality while looking intentionally lo-fi cyberpunk.

## What It Is

**Deliberately pixelated aesthetic.** Low-poly bots, CRT scan lines, pixel-perfect collision boxes, retro UI. Technical constraints (4Hz physics, single Mac Mini) become stylistic choices.

**Think:** Early arcade games + Tron + hacker terminal. Not photorealistic - computational brutalism.

## Core Technology Stack

**All open source, runs on single Mac Mini M4:**

- **Godot Engine** (not Unreal) - fully open source, lightweight, Python-like scripting
- **Python physics engine** - 4Hz updates (250ms intervals), visible grid coordinates
- **ML collision predictor** - trained on per-drone logs from real matches
- **Same MicroPython code** - identical init.py runs in simulator as on ESP32s
- **CSV timeline format** - writes identical events.csv as physical matches

## The Aesthetic: Cyberpunk Data Visualization

**Intentional lo-fi choices that hide resource constraints:**

**Visual style:**
- Chunky pixels (8x8 or 16x16 sprite-like bots)
- Visible collision boxes (neon wireframes)
- CRT scan lines and screen flicker
- Monochrome or limited color palette (cyan/magenta/yellow)
- Grid-based arena floor (visible coordinate system)
- Retro terminal fonts for all UI text

**Why this works:**
- Low-poly models = easier to render 60 bots at once
- Pixelated = masks imperfect physics interpolation
- Wireframe collision boxes = shows AI decision boundaries
- Grid coordinates = makes bot positions debuggable
- Terminal aesthetic = feels like hacker tool, not toy

**Reference inspirations:**
- Uplink (2001) - hacker simulation aesthetic
- SUPERHOT - minimalist 3D with visible timing
- Hacknet - terminal interface meets real-time action
- Early Virtua Fighter - blocky but functional

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

### `/game-engine/` (Python)
Physics loop running at 4Hz:
- Updates 60 bot positions every 250ms
- Grid-based collision detection (visible in UI)
- ML model predicts collision outcomes
- Writes to events.csv (same format as physical matches)
- Sends positions to Godot via WebSocket

**Why Python:** Readable, debuggable, same language as match analysis tools. Not hidden in compiled binary.

### `/godot-renderer/` (Godot Engine 4.x)
Open-source game engine rendering:
- Receives bot positions via WebSocket @ 4Hz
- Pixel art sprites or low-poly 3D models
- CRT shader for scan lines and screen flicker
- Wireframe collision box overlay
- Grid floor with coordinate labels
- 2 camera views (top-down + bot POV)

**Why Godot:**
- Fully open source (MIT license)
- Lightweight (entire engine ~50MB)
- GDScript similar to Python
- Built-in shader system for retro effects
- Cross-platform (Mac, Linux, Windows)
- Active community

### `/web-interface/` (Flask + Terminal UI)
Minimalist match control interface:
- ASCII art dashboard (looks like tmux/screen)
- Terminal-style command input
- Real-time event log (scrolling text)
- Monospace font, limited colors
- Same 4-panel layout as physical matches

**Aesthetic goal:** Feels like SSH session into match server, not polished web app.

### `/ml-models/` (PyTorch)
Collision predictor trained on per-drone logs:
- Input: Pre-collision state (positions, velocities, masses)
- Output: Post-collision velocities, damage states
- Model file: ~500KB
- Inference: <1ms on M4 Neural Engine
- Training notebook published on GitHub

**Open source:** Anyone can retrain on updated datasets, audit predictions, contribute improvements.

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
- Month 1: Python physics engine + grid collision detection
- Month 2: Godot renderer + pixel art bot sprites + CRT shaders
- Month 3: WebSocket integration + CSV event logging
- Month 4: ML collision model training pipeline
- Month 5: Flask terminal UI + match replay
- Month 6: Polish, testing, documentation
- **Total: 6 months MVP (vs 8-12 with Unreal)**

**Why faster:**
- Godot has built-in 2D/3D sprite system (no modeling needed)
- Pixel art is faster than 3D modeling
- Open source tools = no licensing/setup friction
- Terminal UI is simpler than polished web frontend
- Lo-fi aesthetic forgives imperfections

## Usage

**For Competitors:**
- Practice unlimited in simulator (free)
- Develop strategies, test formations
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
