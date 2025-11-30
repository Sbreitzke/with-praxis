# Customizing Praxis

Make Praxis work the way you want.

---

## Editing Context Files

Your context lives in `~/praxis/context/`. Edit these files directly:

| File | Purpose |
|------|---------|
| `person.md` | Your profile, preferences |
| `team.md` | People you work with |
| `priorities.md` | Current focus areas |
| `patterns.md` | Anti-patterns to watch |

After editing, changes take effect in new conversations.

---

## Adding Custom Commands

Create new slash commands in `~/.claude/commands/`.

### Basic Command

```markdown
<!-- ~/.claude/commands/standup.md -->
---
description: Generate daily standup update
---

# /standup

Generate a standup update based on:
1. What I did yesterday (check recent commits, notes)
2. What I'm doing today (check priorities)
3. Any blockers

Keep it brief, 3 bullet points max per section.
```

Now `/standup` is available in Claude Code.

### Nested Commands

Use folders for namespacing:

```
~/.claude/commands/
└── work/
    ├── standup.md     # /work:standup
    ├── review.md      # /work:review
    └── plan.md        # /work:plan
```

---

## Adding Custom Skills

Skills are auto-triggered based on context. Create in `~/.claude/skills/`.

### Skill Structure

```
~/.claude/skills/my-skill/
└── SKILL.md
```

### SKILL.md Format

```markdown
---
name: my-skill
description: Use when [trigger conditions]. Does [what it does].
---

# My Skill

You are [persona/role].

## When to Activate
- [Condition 1]
- [Condition 2]

## How to Behave
[Instructions]

## Output Format
[Expected output structure]
```

### Example: Meeting Notes Skill

```markdown
---
name: meeting-notes
description: Use when taking or formatting meeting notes. Structures notes for clarity and action.
---

# Meeting Notes Skill

You format meeting notes for maximum clarity and actionability.

## When to Activate
- User mentions "meeting notes"
- User pastes a meeting transcript
- User asks to summarize a meeting

## Format

```markdown
# [Meeting Title]

**Date:** [Date]
**Attendees:** [Names]

## Summary
[2-3 sentence overview]

## Key Decisions
- [Decision 1]
- [Decision 2]

## Action Items
- [ ] [Task] — @[Owner] by [Date]

## Notes
[Detailed notes if needed]
```
```

---

## Modifying Praxis Identity

Edit `~/.claude/CLAUDE.md` to change how Praxis behaves:

### Tone

Find the "Style" section and adjust:

```markdown
## Style

**Communication:**
- Very direct (or: Gentle and supportive)
- Brief (or: Detailed explanations)
- Challenge when needed (or: Wait to be asked)
```

### Pattern Challenges

Add or remove patterns:

```markdown
## Pattern Challenges

| Pattern | Signal | Challenge |
|---------|--------|-----------|
| [Your Pattern] | [How to detect] | "[Question to ask]" |
```

---

## Creating People Profiles

For key people you work with, create detailed profiles:

### Template

```markdown
# [Name]

**Role:** [Their role]
**Relationship:** [How you work together]

---

## Working Style
[How they prefer to work]

## Communication
[How to communicate with them effectively]

## Strengths
[What they're good at]

## Collaboration Notes
[Things to remember when working with them]
```

### Example

```markdown
# Sarah Chen

**Role:** Engineering Manager
**Relationship:** Direct manager, weekly 1:1s

---

## Working Style
Very organized, likes written proposals before meetings.
Data-driven decision maker.

## Communication
- Prefers async (Slack) over meetings
- Likes bullet points
- Appreciates context/background

## Strengths
- Strategic thinking
- Stakeholder management
- Budget negotiations

## Collaboration Notes
- Send agenda 24h before 1:1s
- Include metrics when proposing changes
- She values transparency about challenges
```

Save in `~/praxis/context/people/sarah-chen.md` or add to `team.md`.

---

## Redeploying Changes

After editing system files, redeploy:

```bash
cd ~/praxis
./system/deploy.sh
```

This rebuilds `~/.claude/CLAUDE.md` from your components.

---

## Backup Your Customizations

Your Praxis setup is in:
- `~/praxis/` — Your context and customizations
- `~/.claude/` — Deployed runtime files

Consider versioning `~/praxis/`:

```bash
cd ~/praxis
git init
git add .
git commit -m "Initial Praxis setup"
```

Now you can track changes and recover if needed.
