#!/bin/bash
#
# Praxis Deploy Script - Clean Slate Deployment
# Single source of truth: ~/praxis/ (or $PRAXIS_HOME)
# Target: ~/.claude/
#
# Usage: ./deploy.sh
#
# This script does COMPLETE REPLACEMENT of Praxis-managed components:
# 1. Backs up Praxis-managed files only (skills, commands, CLAUDE.md)
# 2. Removes all Praxis-managed components
# 3. Deploys fresh from source
#

set -e

# Configuration - can be overridden with environment variables
PRAXIS_ROOT="${PRAXIS_HOME:-$HOME/praxis}"
PRAXIS_SYSTEM="$PRAXIS_ROOT/system"
CLAUDE_USER="$HOME/.claude"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }
step() { echo -e "${BLUE}[STEP]${NC} $1"; }

# Check if system directory exists
check_location() {
    if [[ ! -d "$PRAXIS_SYSTEM" ]]; then
        error "Praxis system directory not found: $PRAXIS_SYSTEM"
        error "Run install.sh first or set PRAXIS_HOME environment variable"
        exit 1
    fi
}

# Backup only Praxis-managed components
create_backup() {
    step "Backing up Praxis-managed components..."

    local backup_dir="$HOME/.claude.backup"

    # Remove old backup if exists
    [[ -d "$backup_dir" ]] && rm -rf "$backup_dir"

    # Create fresh backup directory
    mkdir -p "$backup_dir"

    if [[ -d "$CLAUDE_USER" ]]; then
        # Only backup Praxis-managed files
        [[ -d "$CLAUDE_USER/skills" ]] && cp -r "$CLAUDE_USER/skills" "$backup_dir/"
        [[ -f "$CLAUDE_USER/CLAUDE.md" ]] && cp "$CLAUDE_USER/CLAUDE.md" "$backup_dir/"
        [[ -d "$CLAUDE_USER/commands" ]] && cp -r "$CLAUDE_USER/commands" "$backup_dir/"

        info "✓ Backup created: ~/.claude.backup"
    else
        warn "~/.claude does not exist yet, creating fresh"
        mkdir -p "$CLAUDE_USER"
    fi
}

# Remove all Praxis-managed components (clean slate)
clean_existing() {
    step "Removing existing Praxis-managed components..."

    # Remove skills directory entirely
    if [[ -d "$CLAUDE_USER/skills" ]]; then
        rm -rf "$CLAUDE_USER/skills"
        info "Removed: ~/.claude/skills/"
    fi

    # Remove Praxis commands
    if [[ -d "$CLAUDE_USER/commands" ]]; then
        local removed=0

        # Remove command folders (px, dev, doc - examples)
        for folder in "px" "dev" "doc"; do
            if [[ -d "$CLAUDE_USER/commands/$folder" ]]; then
                rm -rf "$CLAUDE_USER/commands/$folder"
                ((removed++))
            fi
        done

        # Remove root commands
        for pattern in "deploy.md" "research.md"; do
            for cmd in "$CLAUDE_USER/commands"/$pattern; do
                if [[ -f "$cmd" ]]; then
                    rm "$cmd"
                    ((removed++))
                fi
            done
        done

        if [[ $removed -gt 0 ]]; then
            info "Removed: $removed Praxis commands/folders"
        fi
    fi

    info "✓ Clean slate ready"
}

# Assemble and deploy CLAUDE.md from components
deploy_identity() {
    step "Assembling ~/.claude/CLAUDE.md..."

    local target="$CLAUDE_USER/CLAUDE.md"
    local identity_dir="$PRAXIS_SYSTEM/identity"

    # Start fresh
    > "$target"

    local component_count=0

    # Identity: Main praxis.md
    if [[ -f "$identity_dir/praxis.md" ]]; then
        cat "$identity_dir/praxis.md" >> "$target"
        echo "" >> "$target"
        ((component_count++))
    else
        warn "Missing: praxis.md"
    fi

    # Context: Knowledge map and working style
    for component in knowledge-map.md working-style.md; do
        if [[ -f "$PRAXIS_SYSTEM/$component" ]]; then
            cat "$PRAXIS_SYSTEM/$component" >> "$target"
            echo "" >> "$target"
            ((component_count++))
        fi
    done

    info "✓ Assembled CLAUDE.md from $component_count components"
}

# Deploy skills
deploy_skills() {
    step "Deploying skills..."

    local skills_source="$PRAXIS_ROOT/skills"
    local skills_target="$CLAUDE_USER/skills"

    if [[ ! -d "$skills_source" ]]; then
        warn "No skills directory: $skills_source"
        return 0
    fi

    mkdir -p "$skills_target"

    local count=0
    for skill_dir in "$skills_source"/*/; do
        if [[ -d "$skill_dir" ]]; then
            local skill_name=$(basename "$skill_dir")
            cp -r "$skill_dir" "$skills_target/$skill_name"
            info "Deployed skill: $skill_name"
            ((count++))
        fi
    done

    if [[ $count -eq 0 ]]; then
        warn "No skill folders found"
    else
        info "✓ Deployed $count skills"
    fi
}

# Deploy commands - preserve folder structure
deploy_commands() {
    step "Deploying commands..."

    local commands_source="$PRAXIS_ROOT/commands"
    local commands_target="$CLAUDE_USER/commands"

    if [[ ! -d "$commands_source" ]]; then
        warn "No commands directory: $commands_source"
        return 0
    fi

    mkdir -p "$commands_target"

    # Copy entire folder structure
    cp -r "$commands_source"/* "$commands_target/"

    local count=$(find "$commands_target" -name "*.md" -type f | wc -l | tr -d ' ')
    info "✓ Deployed $count commands"
}

# Show deployment status
show_status() {
    echo ""
    step "=== Deployment Status ==="
    echo ""

    # Skills
    local skill_count=$(find "$CLAUDE_USER/skills" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
    if [[ $skill_count -gt 0 ]]; then
        echo -e "${GREEN}✓${NC} Skills: $skill_count deployed"
        find "$CLAUDE_USER/skills" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort | sed 's/^/    - /'
    else
        echo -e "${YELLOW}○${NC} Skills: none deployed"
    fi

    echo ""

    # Commands
    local cmd_count=$(find "$CLAUDE_USER/commands" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    if [[ $cmd_count -gt 0 ]]; then
        echo -e "${GREEN}✓${NC} Commands: $cmd_count deployed"
    else
        echo -e "${YELLOW}○${NC} Commands: none deployed"
    fi

    echo ""

    # CLAUDE.md
    if [[ -f "$CLAUDE_USER/CLAUDE.md" ]]; then
        local size=$(wc -c < "$CLAUDE_USER/CLAUDE.md" | tr -d ' ')
        echo -e "${GREEN}✓${NC} CLAUDE.md: deployed ($size bytes)"
    else
        echo -e "${RED}✗${NC} CLAUDE.md: NOT deployed"
    fi

    echo ""
    info "Source: $PRAXIS_ROOT"
    info "Target: ~/.claude/"
    echo ""
}

# Main deployment flow
main() {
    echo ""
    echo "═══════════════════════════════════════════"
    echo "   Praxis Deploy - Clean Slate Deployment"
    echo "═══════════════════════════════════════════"
    echo ""
    info "Source: $PRAXIS_ROOT"
    info "Target: ~/.claude/"
    echo ""

    check_location
    create_backup
    clean_existing

    echo ""

    deploy_identity
    deploy_skills
    deploy_commands

    echo ""
    echo "═══════════════════════════════════════════"
    info "✓ Deployment Complete"
    echo "═══════════════════════════════════════════"

    show_status
}

main "$@"
