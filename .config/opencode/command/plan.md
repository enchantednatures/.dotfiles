---
description: Create an implementation plan from a completed specification
model: opencode-go/kimi-k2.5
---

Create an implementation plan

You are helping create a detailed implementation plan from an existing specification. Follow the `plan` skill methodology.

## Context

A specification exists and you need to create a plan for how to implement it. You need to:
1. Analyze the specification thoroughly
2. Break into components
3. Sequence dependencies
4. Document technical decisions

## Process

### Step 1: Analyze Specification

Read and understand:
- All functional requirements
- Non-functional requirements (performance, security, etc.)
- Integration points
- Success criteria

### Step 2: Component Breakdown

For each major piece:
- Define purpose and scope
- Identify inputs/outputs
- List dependencies
- Assess complexity
- Note risks

### Step 3: Sequence Components

Create execution order:
- Foundation first (data models, utilities)
- Core implementation next
- Integration after
- Polish last

### Step 4: Document Technical Decisions

Include:
- Architecture pattern chosen
- Technology choices
- Integration strategies
- Testing approach

## Output Format

Save the plan to:
- Path: `plans/YYYYMMDD-feature-name-plan.md`
- Format: Markdown with structure from `plan` skill

## Response Structure

1. Summary of the specification
2. Component breakdown
3. Execution sequence
4. Technical decisions
5. Open questions
6. Location where plan was saved
