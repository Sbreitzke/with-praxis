#!/bin/bash
#
# withPraxis Installer
# Installs the Praxis framework for Claude Code
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PRAXIS_HOME="${PRAXIS_HOME:-$HOME/praxis}"
CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  withPraxis Installer${NC}"
echo -e "${BLUE}  Your AI in practice${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}⚠ Claude Code not found in PATH${NC}"
    echo "  Install Claude Code first: https://claude.ai/code"
    echo "  Then run this installer again."
    echo ""
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Step 1: Create Praxis home directory
echo -e "${BLUE}[1/5]${NC} Creating Praxis home directory..."
if [ -d "$PRAXIS_HOME" ]; then
    echo -e "  ${YELLOW}Directory exists:${NC} $PRAXIS_HOME"
else
    mkdir -p "$PRAXIS_HOME"
    echo -e "  ${GREEN}Created:${NC} $PRAXIS_HOME"
fi

mkdir -p "$PRAXIS_HOME/context"
mkdir -p "$PRAXIS_HOME/patterns"

# Step 2: Create Claude directory if needed
echo -e "${BLUE}[2/5]${NC} Setting up Claude Code directory..."
if [ ! -d "$CLAUDE_DIR" ]; then
    mkdir -p "$CLAUDE_DIR"
    echo -e "  ${GREEN}Created:${NC} $CLAUDE_DIR"
else
    echo -e "  ${YELLOW}Exists:${NC} $CLAUDE_DIR"
fi

mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/commands"

# Step 3: Copy skills
echo -e "${BLUE}[3/5]${NC} Installing skills..."
if [ -d "$SCRIPT_DIR/skills" ]; then
    cp -r "$SCRIPT_DIR/skills/"* "$CLAUDE_DIR/skills/" 2>/dev/null || true
    echo -e "  ${GREEN}Installed skills to:${NC} $CLAUDE_DIR/skills/"
else
    echo -e "  ${YELLOW}No skills to install${NC}"
fi

# Step 4: Copy commands
echo -e "${BLUE}[4/5]${NC} Installing commands..."
if [ -d "$SCRIPT_DIR/commands" ]; then
    cp -r "$SCRIPT_DIR/commands/"* "$CLAUDE_DIR/commands/" 2>/dev/null || true
    echo -e "  ${GREEN}Installed commands to:${NC} $CLAUDE_DIR/commands/"
else
    echo -e "  ${YELLOW}No commands to install${NC}"
fi

# Step 5: Install telemetry tool (self-improvement engine)
echo -e "${BLUE}[5/5]${NC} Installing telemetry tool..."
mkdir -p "$PRAXIS_HOME/tools"
if [ -f "$SCRIPT_DIR/tools/telemetry" ]; then
    cp "$SCRIPT_DIR/tools/telemetry" "$PRAXIS_HOME/tools/telemetry"
    chmod +x "$PRAXIS_HOME/tools/telemetry"
    echo -e "  ${GREEN}Installed:${NC} $PRAXIS_HOME/tools/telemetry"

    # Initialize telemetry database
    "$PRAXIS_HOME/tools/telemetry" init 2>/dev/null || true
    echo -e "  ${GREEN}Initialized:${NC} Telemetry database"

    # Add to PATH hint
    if [[ ":$PATH:" != *":$PRAXIS_HOME/tools:"* ]]; then
        echo -e "  ${YELLOW}Tip:${NC} Add to your shell config:"
        echo -e "       export PATH=\"\$HOME/praxis/tools:\$PATH\""
    fi
else
    echo -e "  ${YELLOW}No telemetry tool to install${NC}"
fi

# Copy initial CLAUDE.md if it doesn't exist
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    if [ -f "$SCRIPT_DIR/system/CLAUDE.md" ]; then
        cp "$SCRIPT_DIR/system/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
        echo -e "  ${GREEN}Installed:${NC} CLAUDE.md"
    fi
fi

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Next steps:"
echo ""
echo "  1. Start Claude Code:"
echo -e "     ${BLUE}claude${NC}"
echo ""
echo "  2. Run the guided setup:"
echo -e "     ${BLUE}/praxis:setup${NC}"
echo ""
echo "  Praxis will ask you 5 questions and configure"
echo "  your personalized AI partner."
echo ""
echo -e "Learn more: ${BLUE}https://with-praxis.com${NC}"
echo ""
