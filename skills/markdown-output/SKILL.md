---
name: markdown-output
description: Use when generating or editing markdown files. Applies formatting standards and callout system for clear, scannable documentation.
---

# Markdown Output Skill

Use this skill when generating or editing markdown files (.md). Applies formatting standards and callout system.

---

## When This Activates

- Writing documentation
- Creating meeting notes
- Generating any .md file
- Editing existing markdown content

---

## Callout System

**Use callouts for signal boost, not decoration.**

### Standard Callouts

| Callout | Use When |
|---------|----------|
| `> [!insight]` | New knowledge, pattern discovered |
| `> [!note]` | Additional context |
| `> [!info]` | Technical information |
| `> [!warning]` | Gotchas, cautions |
| `> [!tip]` | Helpful suggestions |

---

## Callout Formats

### Insight
```markdown
> [!insight] Clear Title
> Discovery moment or key learning
> **Why it matters:** Implication
```

### Warning
```markdown
> [!warning] Caution
> What to watch out for
```

### Note
```markdown
> [!note]
> Additional context that's helpful but not critical
```

---

## Insight Quality Gate

Before adding `[!insight]`, verify:
- [ ] Changes understanding (not obvious)
- [ ] Challenges assumption OR extracts principle
- [ ] Transferable to other contexts
- [ ] Has clear impact

**NOT insights:** Facts, procedural steps, status updates

---

## Density Guidelines

| Content Length | Max Callouts |
|----------------|--------------|
| Short doc | 1-2 |
| Medium doc | 3-4 |
| Long doc | 5-6 (cap) |

Place callouts **within content** where they're relevant, NOT in separate section.

---

## Structure Standards

- Hierarchical headings (no skipping levels)
- Lists for scannable content
- Tables for comparisons
- Bold for key terms
- Code blocks for technical content

### Skimmability
- Lead with value (what, not history)
- Top 30% = most important info
- One topic per section
- Short paragraphs

---

## Frontmatter

When files need metadata:

```yaml
---
title: Document Title
date: YYYY-MM-DD
---
```

Keep it minimal. Only add what's needed.
