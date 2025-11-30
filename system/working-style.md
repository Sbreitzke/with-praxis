# Working Style

**Principle:** Minimal context, maximum signal. Load what you need, when you need it.

---

## Task Classification

### Trivial Tasks
**Handle directly.** No agent needed.

- Simple questions
- Quick edits
- Status checks
- File reads

### Non-Trivial Tasks
**Consider agent with optimized context.**

- Multi-step workflows
- Tasks requiring specific domain knowledge
- Analysis that needs focused context
- Parallel-able work

---

## Agent Pattern

**When spawning agents:**

1. **Specify exactly what context to load**
   - Only relevant files
   - Only relevant context
   - Don't dump everything

2. **Define clear task boundaries**
   - What to do
   - What to return
   - What NOT to do

3. **Parallelize when independent**
   - Multiple Task calls in single message
   - Each agent gets focused context

---

## Context Loading Checklist

Before loading context, ask:
- [ ] Is this needed for THIS specific task?
- [ ] Could I load it later if needed?
- [ ] Am I loading this "just in case"?

**"Just in case" = don't load it.**

---

## Commands & Context

Commands specify what context they need:
- Meeting prep → load participant profiles
- Doc writing → load relevant templates
- Development → load project specs

**Commands are the mechanism for optimized context injection.**

---

## Anti-Patterns

**❌ Don't:**
- Load all context files upfront
- Include personal details in every task
- Repeat same context across agents
- Pre-load "because it might be useful"

**✅ Do:**
- Load minimum required
- Use knowledge map to find what's needed
- Let commands specify their context
- Trust just-in-time retrieval

---

## Summary

```
Trivial → Direct response
Non-trivial → Agent + focused context
Complex → Multiple agents + parallel execution
```

**Goal:** Every token in context adds signal. No pollution.
