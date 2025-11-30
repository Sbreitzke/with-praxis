# FAQ

Common questions about Praxis.

---

## General

### What is Praxis?

Praxis is a framework that turns Claude Code into a personalized AI operational partner. It knows who you are, how you work, and can challenge you on patterns that aren't sustainable.

### How is this different from just using Claude Code?

Claude Code starts fresh every conversation. Praxis adds:
- **Persistent context** about you, your team, your priorities
- **Pattern recognition** to challenge unsustainable habits
- **Optimized prompting** with just-in-time context loading
- **Maintenance tools** to keep everything current

### Is this free?

Yes, Praxis is free and open source (MIT license). You need a Claude Code subscription from Anthropic.

### Does this work with ChatGPT or other AI?

Currently Praxis is designed for Claude Code. The concepts (context engineering, pattern recognition) could apply elsewhere, but the implementation is Claude-specific.

---

## Setup

### The installer failed. What do I do?

Check that you have:
1. A working terminal
2. Claude Code installed (`claude` command works)
3. Write permissions to your home directory

Try running manually:
```bash
mkdir -p ~/praxis/context
mkdir -p ~/.claude/skills
mkdir -p ~/.claude/commands/px
```

### /px:setup doesn't work

Make sure you're inside Claude Code, not regular terminal:
```bash
claude
```
Then type `/px:setup`.

### How do I redo the setup?

Just run `/px:setup` again. It will overwrite your existing context files.

---

## Usage

### Praxis doesn't seem to know who I am

1. Check that `~/.claude/CLAUDE.md` exists
2. Check that `~/praxis/context/person.md` has your info
3. Start a new conversation (context loads fresh each time)
4. Run `/px:review` to verify everything is set up

### How do I update my information?

Either:
- Run `/px:sync` for a guided update
- Edit the files directly in `~/praxis/context/`

### Do I need to run /px:sync after every edit?

No. Editing files directly is fine. `/px:sync` is for when you want a guided interview to update things.

### Why does Praxis seem to forget things between conversations?

Context loads fresh each conversation. This is by design:
- More efficient (doesn't carry irrelevant context)
- More focused (loads what's needed for current task)
- More private (nothing persists unless in files)

---

## Context

### How much can I put in my context files?

As much as you want in `~/praxis/context/`. These are loaded on-demand, so size doesn't impact every conversation.

Keep `~/.claude/CLAUDE.md` under 40k characters though.

### Can I have nested folders?

Yes:
```
~/praxis/context/
├── person.md
├── team.md
└── people/
    ├── sarah.md
    └── mike.md
```

Reference them in your knowledge map.

### How do I add a new person?

Either add to `~/praxis/context/team.md` or create a separate file like `~/praxis/context/people/name.md`.

---

## Commands

### How do I create my own commands?

Create a `.md` file in `~/.claude/commands/`:

```markdown
---
description: What this command does
---

# /my-command

[Instructions for the command]
```

### Can commands be in folders?

Yes. Folders become namespaces:
```
commands/work/standup.md → /work:standup
commands/personal/journal.md → /personal:journal
```

### How do I share commands with my team?

Share the `.md` files. Each person puts them in their own `~/.claude/commands/`.

---

## Skills

### How do I know which skills are active?

Run `/px:review` to see installed skills.

### Skills don't seem to activate

Skills activate based on keywords in the description. Make sure:
1. The skill is in `~/.claude/skills/[name]/SKILL.md`
2. The description matches what you're asking about
3. Try being more explicit ("help me research X" vs "tell me about X")

### Can I disable a skill?

Remove its folder from `~/.claude/skills/`.

---

## Troubleshooting

### "CLAUDE.md not found"

Run the deploy script:
```bash
cd ~/praxis
./system/deploy.sh
```

### Commands show as "not found"

Check that command files are in `~/.claude/commands/`:
```bash
ls ~/.claude/commands/px/
```

### Everything broke, how do I reset?

Reinstall from scratch:
```bash
cd ~/with-praxis  # wherever you cloned it
./install.sh
/px:setup
```

### How do I completely uninstall?

```bash
rm -rf ~/praxis
rm ~/.claude/CLAUDE.md
rm -rf ~/.claude/skills
rm -rf ~/.claude/commands/px
```

---

## Privacy & Security

### Where is my data stored?

All locally on your machine:
- `~/praxis/` — Your context files
- `~/.claude/` — Runtime configuration

Nothing is sent anywhere except to Claude when you chat.

### Is my context sent to Anthropic?

When you chat with Claude Code, your context files are included in the conversation. This is how Claude knows about you. Anthropic's standard privacy policy applies.

### Can I use Praxis for sensitive work?

Yes, but remember that conversation content goes to Anthropic's API. Don't put secrets, passwords, or highly confidential information in context files.

---

## Contributing

### How do I report a bug?

[Open an issue](https://github.com/sbernauer/with-praxis/issues) with:
1. What you expected to happen
2. What actually happened
3. Steps to reproduce
4. Your OS and Claude Code version

### Can I contribute features?

Yes! PRs welcome. For significant changes, open an issue first to discuss.
