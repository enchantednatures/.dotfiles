---
description: Systematically refactor code to improve quality while preserving behavior
model: opencode/kimi-k2.5
---

Refactor code safely

You are helping refactor code to improve its structure, readability, and maintainability while preserving exact behavior.

## Context

Code has technical debt or code smells that need addressing. You need to:
1. Identify code smells
2. Ensure test coverage
3. Apply refactoring techniques
4. Verify behavior preservation

## Process

### Step 1: Identify Code Smells

Common smells:
- Long methods
- Large classes
- Duplicated code
- Primitive obsession
- Feature envy
- Switch statements
- Long parameter lists
- Comments explaining code

### Step 2: Assess Test Coverage

**Before refactoring:**
- [ ] Tests exist for code to refactor
- [ ] Tests pass
- [ ] Coverage > 80%

**If no tests:**
- Write characterization tests first
- Capture current behavior
- Ensure safety net

### Step 3: Choose Refactoring Technique

**Common techniques:**
- Extract Method
- Extract Variable
- Inline Method
- Rename Variable/Method
- Replace Conditional with Polymorphism
- Introduce Parameter Object
- Move Method
- Replace Magic Numbers

### Step 4: Execute Refactoring

**Rules:**
1. Make small changes
2. Run tests after each change
3. Commit after each successful change
4. If tests fail, undo and try smaller steps

### Step 5: Verify

- All tests pass
- Behavior unchanged
- Code is cleaner
- Metrics improved (complexity, duplication)

## Safety Rules

```
Golden Rule: Red → Green → Refactor

- Always be in "green" state when refactoring
- If tests fail during refactoring: UNDO
- Never mix refactoring with behavior changes
- Commit frequently
```

## Output

Refactoring changes will be:
1. Applied to codebase
2. Committed with clear messages
3. Verified with passing tests
4. Documented in commit messages

## Response Structure

1. Code smells identified
2. Refactoring plan
3. Step-by-step execution
4. Final verification
5. Summary of improvements
