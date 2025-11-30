---
description: System health check - verify Praxis is configured correctly
---

# /px:review - System Health Check

**Purpose:** Validate that Praxis is set up correctly and all components are working.

---

## Usage

```
/px:review            # Standard review
/px:review --quick    # Quick check (just essentials)
/px:review --full     # Deep review (everything)
```

---

## What This Checks

### 1. CLAUDE.md Status

```
Checking ~/.claude/CLAUDE.md...

  Size: 8,234 bytes (✓ under 40k limit)
  Components: identity, knowledge-map, working-style
  Status: ✓ Deployed correctly
```

**Issues detected:**
- Missing components
- File too large (approaching 40k limit)
- Syntax errors

### 2. Context Files

```
Checking ~/praxis/context/...

  person.md      — ✓ Found (updated 7 days ago)
  team.md        — ✓ Found (updated 14 days ago)
  priorities.md  — ✓ Found (updated 3 days ago)
  patterns.md    — ⚠️ Missing (run /px:setup to create)
```

**Issues detected:**
- Missing files
- Very old files (>60 days)
- Empty or malformed files

### 3. Skills

```
Checking ~/.claude/skills/...

  research       — ✓ Installed
  documentation  — ✓ Installed
  senior-dev     — ✓ Installed
  unit-testing   — ✓ Installed
  markdown-output — ✓ Installed

  5 skills active
```

**Issues detected:**
- Missing skill folders
- Invalid SKILL.md files

### 4. Commands

```
Checking ~/.claude/commands/...

  /px:setup      — ✓ Available
  /px:sync       — ✓ Available
  /px:review     — ✓ Available

  3 Praxis commands active
```

**Issues detected:**
- Missing command files
- Invalid command syntax

---

## Review Output

### All Good

```
⏺ Praxis System Review

  ✓ CLAUDE.md: 8,234 bytes (healthy)
  ✓ Context: 4/4 files present
  ✓ Skills: 5 installed
  ✓ Commands: 3 available

  Status: 🟢 Healthy

  Last sync: 3 days ago
  Recommendation: None needed
```

### Issues Found

```
⏺ Praxis System Review

  ✓ CLAUDE.md: 8,234 bytes (healthy)
  ⚠️ Context: 3/4 files (patterns.md missing)
  ✓ Skills: 5 installed
  ✓ Commands: 3 available

  Status: 🟡 Minor issues

  Issues:
  1. patterns.md is missing
     → Run /px:setup to create, or create manually

  2. priorities.md is 45 days old
     → Consider running /px:sync priorities
```

### Critical Issues

```
⏺ Praxis System Review

  ✗ CLAUDE.md: Not found!
  ✗ Context: Directory missing
  ✓ Skills: 5 installed
  ✓ Commands: 3 available

  Status: 🔴 Critical

  Issues:
  1. CLAUDE.md is missing
     → Run: cd ~/praxis && ./system/deploy.sh

  2. Context directory doesn't exist
     → Run /px:setup to initialize
```

---

## Quick Review

`/px:review --quick`

Just checks the essentials:
- CLAUDE.md exists and is reasonable size
- At least person.md exists
- Core commands are available

```
⏺ Quick Review

  ✓ CLAUDE.md exists (8k)
  ✓ person.md exists
  ✓ Core commands available

  Status: 🟢 OK
```

---

## Full Review

`/px:review --full`

Deep check including:
- All standard checks
- Content validation (are files properly formatted?)
- Cross-references (do links resolve?)
- Size analysis (what's taking space?)

```
⏺ Full System Review

  CLAUDE.md Analysis:
    Size: 8,234 bytes (20% of 40k limit)
    Sections: identity (3k), knowledge-map (2k), working-style (3k)

  Context Analysis:
    person.md: Valid, 45 lines
    team.md: Valid, 3 people defined
    priorities.md: Valid, 4 priorities listed
    patterns.md: Valid, 2 patterns defined

  Skills Analysis:
    All 5 skills have valid SKILL.md
    No duplicate skill names

  Commands Analysis:
    3 Praxis commands valid
    No syntax issues detected

  Status: 🟢 Healthy

  Recommendations:
    - Consider adding more detail to team.md profiles
    - priorities.md could use an update (30 days old)
```

---

## Fixing Issues

### CLAUDE.md Missing

```bash
cd ~/praxis
./system/deploy.sh
```

### Context Files Missing

```
/px:setup
```
Or create files manually in `~/praxis/context/`

### Skills Missing

```bash
cd ~/praxis
./install.sh
```

### Stale Context

```
/px:sync
```

---

## When to Review

- After initial setup (`/px:setup`)
- After updating context (`/px:sync`)
- If Praxis seems "off" or forgetful
- Monthly health check
