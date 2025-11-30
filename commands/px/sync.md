---
description: Update your context files - keep Praxis current with changes in your work life
---

# /px:sync - Update Context

**Purpose:** Keep Praxis up-to-date by refreshing your context files through quick interviews.

---

## Usage

```
/px:sync              # Update all context files
/px:sync person       # Update just your profile
/px:sync team         # Update team information
/px:sync priorities   # Update current priorities
/px:sync patterns     # Update anti-patterns
```

---

## What This Does

Each context file has a "staleness" threshold. When you run sync:

1. I check when files were last updated
2. Ask targeted questions about changes
3. Update the relevant files
4. Re-deploy to apply changes

---

## Sync: All Context

**Running `/px:sync` with no arguments:**

### Step 1: Check Staleness

```
Checking context files...

  person.md       — Last updated: 14 days ago ⚠️
  team.md         — Last updated: 30 days ago ⚠️
  priorities.md   — Last updated: 7 days ago ✓
  patterns.md     — Last updated: 45 days ago ⚠️

3 files could use an update. Let's go through them.
```

### Step 2: Quick Interview

**For person.md:**
> Anything changed about your role or working style since [last update]?
> New responsibilities? Changed preferences?

**For team.md:**
> Any changes to your team? New people, departures, role changes?

**For priorities.md:**
> Still focused on the same priorities? Anything completed or changed?

**For patterns.md:**
> Have you noticed any new patterns to watch for?
> Any patterns we should remove (you've overcome them)?

### Step 3: Update & Deploy

After collecting updates:
```
Updating context files...
  ✓ person.md updated
  ✓ team.md updated
  ✓ priorities.md updated

Running deploy...
  ✓ Context deployed to ~/.claude/

Done! I'm now up to date.
```

---

## Sync: Person

`/px:sync person`

Quick check on your profile:

1. Role changes?
2. Working style evolved?
3. Communication preferences?
4. Anything you'd describe differently now?

Updates `~/praxis/context/person.md`

---

## Sync: Team

`/px:sync team`

Quick check on your team:

1. New team members to add?
2. Anyone left or changed roles?
3. Updates to existing profiles?
4. New people you're working with regularly?

Updates `~/praxis/context/team.md`

---

## Sync: Priorities

`/px:sync priorities`

Quick check on focus areas:

1. What's your current focus?
2. Anything completed from the list?
3. New priorities or projects?
4. Any priorities that dropped off?

Updates `~/praxis/context/priorities.md`

---

## Sync: Patterns

`/px:sync patterns`

Quick check on anti-patterns:

1. Noticed any new patterns?
2. Any patterns you've overcome? (Remove them!)
3. Want to refine the challenge questions?

Updates `~/praxis/context/patterns.md`

---

## Recommended Schedule

| Context | Update Frequency |
|---------|------------------|
| priorities | Weekly or when things change |
| team | When team changes |
| person | Monthly or after role changes |
| patterns | When you notice new ones |

---

## After Sync

Changes take effect in new conversations. For immediate effect:
- Start a new chat, or
- Run `/px:review` to verify changes

---

## Automation Tip

I'll remind you when context seems stale:

> It's been 30 days since you updated your priorities.
> Want to run `/px:sync priorities`?

You can ignore these if nothing has changed.
