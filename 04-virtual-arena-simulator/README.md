# Virtual Arena Simulator

**Purpose:** Prove dataset value through high-fidelity simulation trained on real match data.

## What It Does

Runs 60 virtual bots on Mac Mini M4 using:
- Python physics engine (4Hz updates, 250ms intervals)
- ML collision predictor (trained on real UART logs from Knowledge Commons)
- Unreal Engine 5 (interpolates positions to 60fps rendering)
- Same MicroPython code as physical bots (identical init.py)

## Why It Matters

**Proof of Dataset Quality:**
When the simulator achieves 85%+ position accuracy, it demonstrates that the Knowledge Commons dataset captures genuine multi-agent physics—not just noise. This validation justifies €50k+ commercial licensing prices.

**Validation Metrics (Published Monthly):**
- Position RMSE: Target >85% (within 10cm after 90 seconds)
- Collision accuracy: Target >80% (velocity matching)
- Goal detection: Target >85% (vision simulation)

## Architecture

See [ARCHITECTURE.md](../ARCHITECTURE.md) for complete technical details.

**Key Components:**

### `/game-engine/`
Python physics engine that:
- Updates 60 bot positions every 250ms (4Hz loop)
- Detects collisions via proximity checks
- Uses ML model to predict collision outcomes
- Sends positions to Unreal via WebSocket

### `/unreal-integration/`
Unreal Engine 5 project that:
- Receives bot positions via WebSocket @ 4Hz
- Interpolates to 60fps for smooth rendering
- Generates 2 H.264 streams (top-down + POV)
- Simple 3D models (focus on accuracy, not graphics)

### `/web-interface/`
Flask app that:
- Serves same 3-tab UI as physical bots
- Handles virtual bot APIs (HTTP endpoints)
- Allows operators to select POV camera
- Provides match replay functionality

### `/ml-models/`
PyTorch collision predictor:
- Trained on collision events from Knowledge Commons
- Input: Pre-collision state (positions, velocities, masses)
- Output: Post-collision velocities, damage states
- Model file: ~500KB (deployable on M4 Neural Engine)

### `/deployment/`
- Mac Mini M4 setup instructions
- Docker compose (optional containerization)
- System requirements and optimization guide

## Development Timeline

**Single developer, part-time:**
- Months 1-2: Python physics engine + collision detection
- Months 3-4: Unreal scene + WebSocket position streaming
- Months 5-6: ML collision model training pipeline
- Months 7-8: Web interface + virtual bot API
- **Total: 8 months MVP, 12 months production-ready**

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
