# Context Engineering

**The key innovation in Praxis:** Load context just-in-time, not all upfront.

---

## The Problem with Big Context

Most people put everything into CLAUDE.md:
- Their full bio
- Every project they're working on
- All their preferences
- Complete team directory
- Every process they follow

**Result:**
- CLAUDE.md hits the 40k character limit
- AI responses become unfocused
- Irrelevant context pollutes every conversation
- Wasted tokens on info not needed for current task

---

## The Praxis Approach

### Minimal Deployed Context

Your `~/.claude/CLAUDE.md` contains only:
1. **Identity** — Who Praxis is (brief)
2. **Knowledge Map** — Where to find information
3. **Working Style** — How to load context efficiently

Total: ~10KB instead of 40KB

### On-Demand Loading

When Praxis needs information:
1. Checks the knowledge map
2. Loads specific files relevant to the task
3. Uses that context for the current conversation
4. Doesn't carry it to the next conversation

**Example:**
```
Task: "Help me prepare for my 1:1 with Sarah"

Praxis loads:
  ✓ ~/praxis/context/people/sarah.md
  ✓ ~/praxis/context/priorities.md

Praxis does NOT load:
  ✗ Full team directory
  ✗ All project details
  ✗ Pattern library
  ✗ Everything else
```

---

## How It Works

### 1. Knowledge Map

Located in CLAUDE.md, this tells Praxis where to find things:

```markdown
## Knowledge Map

| Need | Location |
|------|----------|
| My profile | ~/praxis/context/person.md |
| Team info | ~/praxis/context/team.md |
| Priorities | ~/praxis/context/priorities.md |
| Patterns | ~/praxis/context/patterns.md |
| People profiles | ~/praxis/context/people/ |
```

### 2. Context Loading

Praxis reads files when needed:

```
User: "Review my code for the payment feature"

Praxis thinks:
  - This is development work
  - Load senior-dev skill (done automatically)
  - Check if there's a payment spec
  - No need for team context

Praxis loads:
  - senior-dev skill (auto)
  - Any relevant specs if found

Praxis responds:
  - With focused development expertise
  - Without irrelevant context
```

### 3. Skill Auto-Activation

Skills are loaded based on the task:

| Task Type | Skill Loaded |
|-----------|--------------|
| Research questions | research |
| Writing docs | documentation |
| Code work | senior-dev |
| Writing tests | unit-testing |
| Creating markdown | markdown-output |

---

## Benefits

### 1. Focused Responses

When context is relevant, responses are more useful:

```
❌ With everything loaded:
   "Based on your role as [long bio], your team dynamics with
   [all team members], and considering your patterns of [all patterns],
   I recommend..."

✓ With just-in-time loading:
   "For this code review, I recommend..."
```

### 2. Larger Effective Context

40k limit goes much further when you're not wasting it:

```
❌ Big CLAUDE.md:
   35k identity + 5k for actual work

✓ Minimal identity:
   10k identity + 30k for actual work
```

### 3. Faster Responses

Less context = faster processing:
- Smaller prompts process faster
- Less irrelevant info to parse
- More token budget for output

---

## Best Practices

### 1. Keep Identity Minimal

Your CLAUDE.md should be:
- Who Praxis is (brief)
- How to find more info (knowledge map)
- How to work efficiently (working style)

**Not:**
- Your full biography
- Every preference you have
- Complete org chart

### 2. Structure Context Files Well

Make files easy to load partially:

```markdown
# Team

## Leadership
[...]

## Engineering
[...]

## Product
[...]
```

Praxis can reference "the Engineering section" without loading everything.

### 3. Use Clear File Names

```
~/praxis/context/
├── person.md           # Clear: your profile
├── team.md             # Clear: team overview
├── priorities.md       # Clear: current focus
├── patterns.md         # Clear: anti-patterns
└── people/
    ├── sarah-chen.md   # Clear: Sarah's profile
    └── mike-johnson.md # Clear: Mike's profile
```

### 4. Don't Duplicate

If info is in one place, reference it:

```markdown
## Team
See ~/praxis/context/team.md for full team info.
```

**Not:**
Copy-pasting team info into CLAUDE.md AND team.md.

---

## When to Load What

| Situation | Load |
|-----------|------|
| General chat | Just identity |
| Meeting prep | Relevant person profiles |
| Code review | senior-dev skill |
| Planning work | Priorities, relevant specs |
| Team discussion | Team context |
| Pattern intervention | Patterns file |

---

## Debugging Context Issues

### Praxis seems to have forgotten something

Context doesn't persist between conversations. If Praxis should know something:
1. Check if it's in a context file
2. Check if the knowledge map points to it
3. Consider if it should be in identity (always loaded) vs context (on-demand)

### Praxis loads irrelevant context

Check your prompts. Specific prompts get specific context:
```
❌ "Help me with work stuff" (vague → loads everything)
✓ "Review this Python function" (specific → loads senior-dev)
```

### Context file not being used

Make sure:
1. File exists in the right location
2. Knowledge map references it
3. You're asking about something that would trigger loading it

---

## Summary

**Old way:** Cram everything into CLAUDE.md
**Praxis way:** Minimal identity + just-in-time loading

The result: More focused, more efficient, more useful AI assistance.
