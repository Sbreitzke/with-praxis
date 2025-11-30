# withPraxis

**Transform Claude Code into your AI Operational Partner.**

Not an assistant. Not a tool. A partner who knows your context, challenges your patterns, and helps you build without breaking.

> *"Praxis"* — Greek: practical action, as opposed to theory. This is AI in practice.

---

## What is this?

Praxis is a context engineering framework for Claude Code that turns generic AI into a personalized operational partner:

- **Knows who you are** — Your role, working style, priorities
- **Knows your team** — Key people, relationships, how to communicate
- **Challenges your patterns** — Recognizes when you're falling into unsustainable habits
- **Maintains itself** — Self-updating context, validation, review cycles

### The Problem

Claude Code is powerful, but it starts fresh every conversation. You repeat context. It doesn't know your preferences. It can't challenge you on patterns it doesn't know about.

### The Solution

Praxis structures your context so Claude:
- Loads what it needs, when it needs it (not everything upfront)
- Knows how to communicate with you (direct? supportive? challenging?)
- Recognizes your anti-patterns and intervenes
- Maintains and updates its own knowledge

---

## Quick Start

```bash
# Clone the repo
git clone https://github.com/sbernauer/with-praxis.git
cd with-praxis

# Run the installer
./install.sh

# Start Claude Code and run the guided setup
claude
/px:setup
```

The setup wizard will ask you 5 questions and generate your personalized system.

---

## What You Get

```
~/.claude/
├── CLAUDE.md              # Praxis identity + knowledge map
├── skills/                # Auto-triggered expertise
│   ├── research/          # Market, technical, competitive research
│   ├── documentation/     # Doc creation, updates, standards
│   ├── senior-dev/        # Architecture, code review, patterns
│   └── unit-testing/      # Test-first, behavior-driven
└── commands/              # Slash commands for workflows
    └── px/
        ├── setup.md       # /px:setup - Initial configuration
        ├── sync.md        # /px:sync - Update your context
        └── review.md      # /px:review - System health check

~/praxis/                  # Your knowledge base
├── context/               # Who you are, your team, priorities
└── patterns/              # Anti-patterns to watch for
```

---

## Core Concepts

### Context Engineering

The key innovation is **just-in-time context loading**:

```
❌ Old way: Load everything into CLAUDE.md upfront
   → Context pollution, token waste, unfocused responses

✅ Praxis way: Minimal identity + knowledge map + load on-demand
   → Focused context, efficient tokens, relevant responses
```

Your CLAUDE.md stays small (~10KB). When Praxis needs your team dynamics for a meeting, it loads that. When doing code review, it loads the senior-dev skill. Nothing wasted.

### Pattern Recognition

Define anti-patterns you want to avoid:

```markdown
# firefighter-mode.md

**Pattern:** Solving problems instead of teaching others to solve them
**Signal:** "Let me just fix this real quick"
**Challenge:** "Who could learn to own this?"
**Why it matters:** You become the bottleneck. Others don't grow.
```

Praxis watches for these and intervenes when detected.

### Self-Maintenance

Praxis keeps itself current:

- `/px:sync` — Update your profile, priorities, team
- `/px:review` — Validate system health, check for issues
- Automatic staleness detection (reminds you to update)

---

## Commands

| Command | Purpose |
|---------|---------|
| `/px:setup` | Initial guided configuration |
| `/px:sync` | Update context files |
| `/px:review` | System health check |

### Example Commands (templates)

| Command | Purpose |
|---------|---------|
| `/dev:plan` | Turn idea into spec with answer blocks |
| `/dev:implement` | Build from spec with tests |
| `/doc:write` | Create documentation from code |
| `/doc:compress` | Remove duplication, sharpen text |

---

## Customization

### Adding Your Own Commands

```markdown
<!-- ~/.claude/commands/my-command.md -->
---
description: What this command does
---

# /my-command

[Your prompt here]
```

### Adding Skills

```markdown
<!-- ~/.claude/skills/my-skill/SKILL.md -->
---
name: my-skill
description: What triggers this skill
---

[Skill instructions]
```

### Updating Context

Edit files in `~/praxis/context/`:
- `person.md` — Your profile
- `team.md` — Key people
- `priorities.md` — Current goals
- `patterns.md` — Anti-patterns to watch

Then run `/px:sync` to validate and deploy.

---

## Philosophy

### AI as Operational Partner

Not assistant (passive, waits for orders).
Not tool (does one thing, no context).
**Partner** (knows context, challenges, collaborates).

### Pragmatic Quality

Built for real work, not enterprise theater:
- **Right-sized solutions** — Not over-engineered
- **Evolution-ready** — Can grow, but doesn't gold-plate
- **Ship fast, refactor smart** — Pragmatic quality

### Direct Communication

No fluff, no hedging:
- "Frontmatter broken. Fixing." (not "I noticed there might be an issue...")
- "Done. Next?" (not "I've completed the task you requested...")
- Evidence over opinion, action over explanation

---

## FAQ

**Q: Does this work with other AI tools?**
A: Currently optimized for Claude Code. The concepts apply elsewhere, but the implementation is Claude-specific.

**Q: How much does it cost?**
A: Free and open source (MIT license). You need a Claude Code subscription.

**Q: Can I use this for my team?**
A: Yes! Each person runs their own setup. Team patterns can be shared.

**Q: How is this different from just writing a good CLAUDE.md?**
A: Structure. Praxis provides the architecture (skills, commands, context loading, maintenance) that makes a complex system manageable.

---

## Contributing

Issues and PRs welcome. This is an evolving system.

---

## License

MIT — Do what you want with it.

---

## Author

Built by [Sebastian Bernauer](https://s16e.de) as a real production system, then extracted for others.

**"AI as Operational Partner"** is the thesis. Praxis is the proof.

---

[with-praxis.com](https://with-praxis.com)
