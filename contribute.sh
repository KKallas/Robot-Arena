#!/bin/bash

# ============================================================
# SwarmPit Contributor Script
#
# Let your spare Claude credits work on open issues overnight.
# Two modes:
#   1. SOLVE: Find llm-ready issues, solve them, create PRs
#   2. MODERATE: Clean up messy issues, format them for automation
#
# Usage:
#   ./contribute.sh              # Interactive mode selector
#   ./contribute.sh solve        # Solve llm-ready issues
#   ./contribute.sh moderate     # Format messy issues
#   ./contribute.sh --help       # Show help
#
# Requirements:
#   - claude CLI installed (npm install -g @anthropic-ai/claude-code)
#   - gh CLI installed and authenticated
#   - python3
# ============================================================

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

show_banner() {
    echo ""
    echo -e "${CYAN}============================================${NC}"
    echo -e "${CYAN}  SwarmPit Auto-Contributor${NC}"
    echo -e "${CYAN}  Burning spare Claude credits for good${NC}"
    echo -e "${CYAN}============================================${NC}"
    echo ""
}

show_help() {
    show_banner
    echo "Usage: ./contribute.sh [MODE] [OPTIONS]"
    echo ""
    echo "Modes:"
    echo "  solve      Find llm-ready issues, solve them, create PRs"
    echo "  moderate   Format messy issues for automation"
    echo "  fix        Fix PRs based on review comments"
    echo "  (none)     Interactive mode selector"
    echo ""
    echo "Options:"
    echo "  --max N    Process at most N issues (default: 5)"
    echo "  --dry-run  Show what would be done (no Claude, no GitHub)"
    echo "  --test     Run Claude but don't post to GitHub (safe testing)"
    echo "  --issue N  Process specific issue number"
    echo "  --pr N     Process specific PR number (fix mode)"
    echo "  --help     Show this help"
    echo ""
    echo "Examples:"
    echo "  ./contribute.sh                       # Interactive"
    echo "  ./contribute.sh solve                 # Solve issues (LIVE)"
    echo "  ./contribute.sh solve --test          # Test solving without PR"
    echo "  ./contribute.sh moderate --dry-run    # Preview issues to moderate"
    echo "  ./contribute.sh moderate --test       # Test moderation without posting"
    echo "  ./contribute.sh solve --issue 123     # Solve specific issue"
    echo "  ./contribute.sh fix                   # Fix PRs with review comments"
    echo "  ./contribute.sh fix --pr 123          # Fix specific PR"
    echo ""
    echo "Environment Variables:"
    echo "  ROBOT_ARENA_REPO   Override repo (default: KKallas/Robot-Arena)"
    echo "  CLAUDE_MODEL       Override model (default: claude-sonnet-4-20250514)"
    echo ""
}

# Interactive mode selector
select_mode() {
    show_banner
    echo "What would you like to do?"
    echo ""
    echo -e "  ${GREEN}1) solve${NC}     - Find llm-ready issues and solve them (creates PRs)"
    echo -e "  ${YELLOW}2) moderate${NC}  - Format messy issues for automation (asks questions)"
    echo -e "  ${CYAN}3) fix${NC}       - Fix PRs based on review comments"
    echo ""
    read -p "Enter choice [1/2/3]: " choice

    case $choice in
        1|solve)
            MODE="solve"
            ;;
        2|moderate)
            MODE="moderate"
            ;;
        3|fix)
            MODE="fix"
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            exit 1
            ;;
    esac
}

# Parse arguments
MODE=""
EXTRA_ARGS=""

while [[ $# -gt 0 ]]; do
    case $1 in
        solve)
            MODE="solve"
            shift
            ;;
        moderate)
            MODE="moderate"
            shift
            ;;
        fix)
            MODE="fix"
            shift
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            # Pass through all other args to Python scripts
            EXTRA_ARGS="$EXTRA_ARGS $1"
            shift
            ;;
    esac
done

# If no mode specified, ask interactively
if [ -z "$MODE" ]; then
    select_mode
fi

# Check for python3
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: python3 not found${NC}"
    exit 1
fi

# Run the appropriate Python script
show_banner
echo -e "Mode: ${GREEN}$MODE${NC}"
echo ""

case $MODE in
    solve)
        python3 "$SCRIPT_DIR/99-tools/solve_issues.py" $EXTRA_ARGS
        ;;
    moderate)
        python3 "$SCRIPT_DIR/99-tools/moderate_issues.py" $EXTRA_ARGS
        ;;
    fix)
        python3 "$SCRIPT_DIR/99-tools/fix_prs.py" $EXTRA_ARGS
        ;;
esac
