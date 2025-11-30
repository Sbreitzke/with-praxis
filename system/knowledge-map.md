# Knowledge Map

**Purpose:** Where to find information. Load on-demand, not upfront.

---

## Folder Structure

```
~/praxis/
├── context/                 # Your personal context
│   ├── person.md            # → Your profile, preferences
│   ├── team.md              # → Key people you work with
│   ├── priorities.md        # → Current goals, focus areas
│   └── patterns.md          # → Anti-patterns to watch for
│
├── work/                    # Work-related knowledge
│   ├── projects/            # → Project-specific context
│   └── people/              # → Detailed people profiles
│
└── notes/                   # General notes, research
```

---

## Context Files (Load On-Demand)

| File | Load When |
|------|-----------|
| `person.md` | Personalization needed, preferences matter |
| `team.md` | Working with others, meetings, delegation |
| `priorities.md` | Planning, prioritization decisions |
| `patterns.md` | Recognizing and challenging anti-patterns |

---

## People Profiles

**Location:** `~/praxis/work/people/`

**Load when:** Meeting prep, collaboration, delegation

**Naming:** `firstname-lastname.md` (kebab-case)

**Contains:** Role, working style, communication preferences, collaboration notes

---

## Commands

**Location:** `~/.claude/commands/`

**Structure:**
- `px/` → `/px:*` (Praxis core commands)
  - `setup.md` → `/px:setup` - Initial configuration
  - `sync.md` → `/px:sync` - Update context
  - `review.md` → `/px:review` - System health

**Add your own:** Create `.md` files in `~/.claude/commands/`

---

## Skills

**Location:** `~/.claude/skills/`

| Skill | Auto-Activates For |
|-------|-------------------|
| `research` | Market, technical, competitive research |
| `documentation` | Doc lifecycle (create, update, maintain) |
| `senior-dev` | Development, architecture, code review |
| `unit-testing` | Writing/reviewing tests |
| `markdown-output` | Generating/editing .md files |

---

## Just-in-Time Loading

**Don't:** Pre-load everything into context
**Do:** Load specific files when task requires them

**Example:**
```
Task: Prepare for meeting with Alex
→ Load: alex.md from ~/praxis/work/people/
→ Load: priorities.md (to know current focus)
→ Don't load: team.md (not needed for 1:1)
```

**Why this matters:**
- Keeps context focused
- Reduces token waste
- More relevant responses

---

## Customization

Add your own structure as you work. Common additions:

- `~/praxis/templates/` — Reusable document templates
- `~/praxis/workflows/` — Standard operating procedures
- `~/praxis/research/` — Research outputs and findings

The knowledge map grows with your needs.
