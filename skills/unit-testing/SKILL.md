---
name: unit-testing
description: Use when writing or reviewing tests. Behavior-driven, fewer expressive tests over coverage-driven quantity. Pragmatic quality.
---

# Unit Testing Skill

You write tests that express **behavior**, not implementation details. Fewer expressive tests > many coverage-driven tests.

## When to Activate

- User asks to write tests
- User asks to review test quality
- User wants test refactoring
- User mentions TDD, testing strategy, test coverage

## Core Philosophy: Behavior Over Coverage

**Tests document behavior.** They answer: "What does this system DO?" not "What lines does this code execute?"

### What to Test

| Test This | Skip This |
|-----------|-----------|
| Business rules | Framework behavior |
| Core contracts | Edge case paranoia |
| Integration points | Implementation details |
| Failure modes that matter | Every null/empty permutation |

### Test Quality Criteria

**A good test:**
- Expresses a behavior someone cares about
- Fails for meaningful reasons
- Reads like documentation
- Survives refactoring (tests behavior, not implementation)

**A bad test:**
- Tests framework/library behavior (List.Add works)
- Tests obvious defensive code (null returns 0)
- Duplicates another test's assertion
- Pinpoints implementation lines instead of behavior

## Anti-Patterns to Eliminate

### 1. Edge Case Paranoia
```csharp
// ❌ DELETE THESE - Nobody cares
void ShouldReturnZero_WhenInputIsNull() { ... }
void ShouldReturnZero_WhenInputIsEmpty() { ... }
void ShouldDoNothing_WhenAlreadyNull() { ... }
```
These test defensive programming, not behavior.

### 2. Framework Behavior Tests
```csharp
// ❌ DELETE - Tests List<T>.Add, not your code
void ShouldAppendToExistingMessages() { ... }
```

### 3. Redundant Behavior Tests
```csharp
// ❌ MERGE THESE - Same behavior
void AddMessage_ShouldUpdateToHigherAttentionLevel() { ... }
void AddMessage_ShouldNotDowngradeAttentionLevel() { ... }

// ✅ ONE TEST expressing the actual behavior
void AddMessage_UpdatesAttentionLevelToHighest() { ... }
```

## Test Organization

### Structure by Behavior, Not Method

```csharp
// ❌ WRONG - Organized by method
#region RemoveMessages Tests
#region AddMessages Tests

// ✅ RIGHT - Organized by behavior
#region Core Behavior: Messages Stay In Sync
#region Business Rule: Only Active Items Count
```

### Class Header Documents Behaviors

```csharp
/// <summary>
/// Tests for OrderService.
///
/// Core Behaviors Under Test:
/// 1. Order state transitions follow business rules
/// 2. Invalid transitions throw meaningful exceptions
/// 3. Completed orders cannot be modified
/// </summary>
```

## Naming Convention

**Pattern:** `[Action]_[Behavior]_[Condition]`

```csharp
// ✅ GOOD - Describes behavior
RemoveItem_RecalculatesTotal_WhenItemRemoved()
Cancel_ThrowsException_WhenAlreadyShipped()

// ❌ BAD - Describes implementation
RemoveItem_ShouldCallRecalculateAndReturnCount()
```

## Test Body Structure

```csharp
[Test]
public void RemoveItem_RecalculatesTotal_WhenItemRemoved()
{
    // The behavior: when we remove items, total must reflect
    // the current items, not stay stuck at old value
    var order = new Order();
    order.AddItem(new Item { Price = 100 });
    order.AddItem(new Item { Price = 50 });

    order.RemoveItem(order.Items.First());

    Assert.That(order.Total, Is.EqualTo(50),
        "Total must recalculate after removing item");
}
```

**Key elements:**
- Comment explains WHY (the behavior being tested)
- Setup is minimal and readable
- Single action
- Assertions include failure message

## Refactoring Checklist

When reviewing existing tests, ask:

- [ ] Does this test express a behavior someone cares about?
- [ ] Would removing this test lose documentation of important behavior?
- [ ] Is there another test covering the same behavior?
- [ ] Does this test survive implementation refactoring?
- [ ] Is this testing MY code or framework/library code?

**Target:** 10-15 behavior tests > 50 coverage tests

## Density Guidelines

| Behaviors | Target Tests |
|-----------|--------------|
| 2-3 behaviors | 5-8 tests |
| 4-5 behaviors | 10-15 tests |
| Complex domain | 15-25 tests max |

**More than 25 tests?** Split the class or you're testing implementation.

## Quick Reference

**Delete tests that:**
- Test null/empty edge cases (unless that's the feature)
- Test framework behavior
- Duplicate other tests' behaviors
- Pin implementation details

**Keep tests that:**
- Express business rules
- Document core contracts
- Catch real bugs
- Survive refactoring
