# Getting Started with Praxis

Get up and running in 5 minutes.

---

## Prerequisites

- [Claude Code](https://claude.ai/code) installed and working
- Terminal access
- Git (for cloning)

---

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/sbernauer/with-praxis.git
cd with-praxis
```

### Step 2: Run the Installer

```bash
./install.sh
```

This creates:
- `~/praxis/` — Your personal context directory
- `~/.claude/skills/` — AI skills (research, documentation, etc.)
- `~/.claude/commands/px/` — Praxis commands

### Step 3: Start Claude Code

```bash
claude
```

### Step 4: Run the Guided Setup

```
/px:setup
```

Answer 5 questions about:
1. Who you are
2. Who you work with
3. Your current priorities
4. How you like to communicate
5. Patterns to watch for

Praxis will generate your personalized context files.

---

## Verify It's Working

After setup, try:

```
Hello, who am I?
```

Praxis should know your name, role, and preferences.

Run a health check:

```
/px:review
```

You should see all green checkmarks.

---

## What You Have Now

```
~/.claude/
├── CLAUDE.md              # Praxis identity
├── skills/                # 5 auto-triggered skills
│   ├── research/
│   ├── documentation/
│   ├── senior-dev/
│   ├── unit-testing/
│   └── markdown-output/
└── commands/
    └── px/
        ├── setup.md       # /px:setup
        ├── sync.md        # /px:sync
        └── review.md      # /px:review

~/praxis/
├── context/
│   ├── person.md          # Your profile
│   ├── team.md            # Key people
│   ├── priorities.md      # Current focus
│   └── patterns.md        # Anti-patterns to watch
└── system/
    └── deploy.sh          # Deployment script
```

---

## Next Steps

1. **Add team details** — Edit `~/praxis/context/team.md` to add more about key people

2. **Customize patterns** — Edit `~/praxis/context/patterns.md` to add your specific anti-patterns

3. **Try the skills** — Ask Praxis to help with research, documentation, or development

4. **Keep it current** — Run `/px:sync` periodically to update your context

---

## Quick Reference

| Command | Purpose |
|---------|---------|
| `/px:setup` | Initial configuration |
| `/px:sync` | Update context files |
| `/px:review` | System health check |

---

## Troubleshooting

### "Command not found"

Make sure you're in Claude Code (not regular terminal):
```bash
claude
```

### Setup didn't work

Try running the installer again:
```bash
cd ~/with-praxis  # or wherever you cloned it
./install.sh
```

### Praxis seems to have forgotten everything

Context loads fresh each conversation. Make sure:
1. `~/.claude/CLAUDE.md` exists
2. `~/praxis/context/` has your files
3. Run `/px:review` to check status

### Still stuck?

[Open an issue](https://github.com/sbernauer/with-praxis/issues) with details.

---

## Uninstalling

To remove Praxis:

```bash
# Remove Praxis files
rm -rf ~/praxis
rm ~/.claude/CLAUDE.md
rm -rf ~/.claude/skills
rm -rf ~/.claude/commands/px
```

This doesn't affect your other Claude Code settings.
