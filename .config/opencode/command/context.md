---
description: View and manage AI context - current unit, phase, decisions, constraints, and progress
model: opencode-go/kimi-k2.5
---

View or switch AI context

This command manages the persistent context that AI maintains across sessions, enabling continuity and informed assistance.

## Context Commands

### View Current Context

Show where we are:
- Current unit of work
- Current phase (Inception/Construction/Operations)
- Progress stats
- Recent decisions
- Active constraints
- Next steps

**Format:**
```
## Current Context

**Unit:** Unit 003 - Payment Processing
**Phase:** Construction (2/3 phases)
**Bolt:** Bolt 2 of 4
**Progress:** 5/12 tasks (42%)

**Last Session:** 2025-01-20 - Mob Construction
**Current Task:** Task 5 - Webhook handler implementation

**Recent Decisions:**
1. Use Stripe over PayPal (cost + features)
2. Webhook signature verification required

**Active Constraints:**
- Must handle 1000 req/min
- 99.9% uptime required
- GDPR compliant

**Next:** Continue Task 5 or Mob session for API design
```

### View Unit Details

Show specific unit:
- All decisions
- All constraints
- Task progress
- Learnings
- Blockers

### Switch Unit

Change to different unit:
- Save current unit state
- Load new unit context
- Show summary
- Ask for confirmation

### View Phase

Show phase-specific context:
- **Inception:** Requirements, stories, constraints
- **Construction:** Architecture, components, tech decisions
- **Operations:** Infrastructure, deployments, monitoring

### View Decisions

List all decisions:
- By unit
- By date
- By category (technical, business, process)

### View Constraints

List all constraints:
- Technical
- Business
- Regulatory
- Performance

## Process

### Step 1: Load Master Context

Read `.ai-dlc/context.json`

### Step 2: Display Information

Based on command type:
- Summary view
- Detailed view
- Specific category

### Step 3: Handle Switch (if requested)

If switching units:
1. Save current unit state
2. Load target unit context
3. Display new context
4. Confirm switch

## Response Structure

1. Context summary (current state)
2. Key information (decisions, constraints, progress)
3. Available actions (continue, switch, etc.)
4. Suggested next steps

## Examples

### View Current
```
**Current Unit:** Unit 003 - Payment Processing
**Phase:** Construction
**Status:** In Progress (42%)
**Active:** Task 5 of 12
**Last Work:** 2025-01-20

Quick Actions:
- Continue Task 5
- Start Mob session
- Switch to Unit 002
```

### Switch Unit
```
**Save:** Unit 003 state (Task 5/12, Construction phase)
**Load:** Unit 002 - User Auth (completed, Operations phase)

Unit 002 Summary:
- Status: Complete
- Phase: Operations
- Learnings: 3 captured
- Next: Infrastructure monitoring

**Switch confirmed. Ready to work on Unit 002.**
```

### View Decisions
```
## Decisions (Last 10)

**Unit 003:**
1. 2025-01-20: Stripe over PayPal (cost, features)
2. 2025-01-19: Webhook signature verification (security)
3. 2025-01-18: Redis for session storage (performance)

**Unit 002:**
4. 2025-01-15: JWT for auth (stateless)
...
```
