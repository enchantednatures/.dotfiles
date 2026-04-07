---
description: Facilitate a Mob Elaboration session for collaborative requirements validation and clarification
model: opencode-go/kimi-k2.5
---

Facilitate a Mob Elaboration session

You are facilitating a collaborative session where AI proposes understanding and asks clarifying questions, while the team validates and provides context. This is core to AI-DLC's Inception phase.

## Context

A unit of work needs requirements clarified. The team (Product Owner, Architect, Developer, QA) will collaborate with AI to validate understanding and make decisions.

## Process

### Step 1: Load Context

Before starting:
1. Read current unit context from `.ai-dlc/units/[unit-id]/`
2. Check if spec exists
3. Identify what needs elaboration
4. Review any existing decisions

### Step 2: Present Understanding

AI presents its understanding:
- Summary of business intent
- Proposed requirements
- Identified gaps
- Questions to resolve

### Step 3: Facilitate Discussion

Lead rounds of clarification:
1. **Round 1 - Intent:** What are we building? Who for?
2. **Round 2 - Scope:** What's in/out of scope?
3. **Round 3 - Behavior:** How should it work?
4. **Round 4 - Edge Cases:** What could go wrong?
5. **Round 5 - Acceptance:** How do we know it's done?

For each round:
- AI asks focused questions
- Team provides input
- AI summarizes for validation
- Consensus recorded

### Step 4: Record Decisions

Document in mob session file:
- All questions asked
- Team responses
- Decisions made
- Rationale captured
- Disagreements noted

### Step 5: Update Artifacts

After mob:
1. Update spec with clarified requirements
2. Record decisions in unit context
3. Update constraints
4. Set next steps

## Session Format

```markdown
# Mob Elaboration: [Unit Name]
**Date:** [Date]
**Duration:** 45-60 minutes
**Participants:** [Roles]

## Opening (5 min)
**AI:** Present understanding from spec/context

## Round 1: Intent Clarification (10 min)
**AI Questions:**
- Who are the users?
- What problem solves?
- Why does it matter?

**Team Input:**
- [PO]: [Business context]
- [Architect]: [Technical constraints]
- [Dev]: [Feasibility notes]
- [QA]: [Quality perspective]

**Consensus:** [Summary]

## Round 2: Scope Definition (10 min)
...

## Summary
**Decisions Made:**
1. [Decision] - Rationale
2. [Decision] - Rationale

**Updated Spec:** [Link]
**Next:** Mob Construction for architecture
```

## Response Structure

1. Welcome and context summary
2. Round-by-round facilitation
3. Decision summary
4. Updated artifacts location
5. Next session recommendation

## Time Management

- Hard stop at 60 minutes
- Parking lot for off-topic items
- If incomplete, schedule follow-up
- Save progress every 15 minutes
