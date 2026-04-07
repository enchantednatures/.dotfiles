---
description: Break down implementation plan into executable tasks with acceptance criteria
model: opencode-go/kimi-k2.5
---

Create a task list from implementation plan

You are breaking down an implementation plan into discrete, executable tasks. Follow the `breakdown` skill methodology.

## Context

An implementation plan exists and you need to create specific tasks. You need to:
1. Take each component from the plan
2. Break into individual behaviors
3. Create tasks with acceptance criteria
4. Order by dependencies

## Process

### Step 1: Select Component

Work through the plan component by component.

### Step 2: Identify Behaviors

For each component, identify:
- Happy path behaviors
- Edge cases
- Error scenarios
- Integration points

### Step 3: Create Tasks

Each task must have:
- Clear description
- Acceptance criteria (Given/When/Then)
- Complexity estimate
- Dependencies listed
- Files to modify

### Step 4: Order Tasks

Sequence by:
- Dependencies (what needs what)
- Logical flow
- Parallel opportunities

## Output Format

Save the task list to:
- Path: `tasks/YYYYMMDD-feature-name-tasks.md`
- Format: Markdown with structure from `breakdown` skill
- Include a summary table

## Task List Format

```markdown
# Task List: [Feature Name]

## Summary
- Total Tasks: 12
- Estimated Time: 6 hours
- Parallel Groups: 3

## Execution Order

### Group 1: Foundation
- [ ] Task 1: [Name] (Low) - No deps
- [ ] Task 2: [Name] (Medium) - Needs Task 1
...

### Group 2: Implementation
...

## Detailed Tasks

### Task 1: [Name]
**Description:** ...
**Acceptance Criteria:**
- [ ] ...
- [ ] ...
**Files:** `src/...`
**Complexity:** Low/Medium/High
**Dependencies:** ...
```

## Response Structure

1. Summary of components
2. Task count and estimate
3. Execution sequence overview
4. Location where task list was saved
