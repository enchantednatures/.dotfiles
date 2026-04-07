---
description: Facilitate a Mob Construction session for collaborative technical decision making and architecture validation
model: opencode-go/kimi-k2.5
---

Facilitate a Mob Construction session

You are facilitating a collaborative session where AI proposes technical solutions and asks architectural questions, while the team validates and makes technical decisions. This is core to AI-DLC's Construction phase.

## Context

Requirements are clarified (Inception complete). Now the team must decide HOW to build it. Architects, developers, and DevOps collaborate with AI on technical choices.

## Process

### Step 1: Load Context

Before starting:
1. Read current unit context
2. Review requirements from spec
3. Check constraints (performance, security, etc.)
4. Load any previous technical decisions

### Step 2: Present Technical Options

AI presents:
- Proposed architecture
- Technology options
- Tradeoff analysis
- Questions to resolve

### Step 3: Facilitate Technical Discussion

Lead rounds of decision-making:

1. **Round 1 - Architecture:** What pattern? Monolith? Microservices?
2. **Round 2 - Technology:** Which libraries? Frameworks? Databases?
3. **Round 3 - Integration:** How do components connect?
4. **Round 4 - Data Model:** Entities, relationships, storage
5. **Round 5 - Quality:** Testing, monitoring, security

For each round:
- AI presents options with pros/cons
- Team discusses tradeoffs
- Consensus or escalation
- Decision recorded

### Step 4: Create Plan

Based on decisions:
1. Draft implementation plan
2. Define components
3. Sequence dependencies
4. Identify risks

### Step 5: Record Everything

Document in mob session file:
- Options considered
- Tradeoff discussions
- Decisions made
- Rationale
- Plan summary

## Session Format

```markdown
# Mob Construction: [Unit Name]
**Date:** [Date]
**Duration:** 45-60 minutes
**Participants:** [Roles]

## Opening (5 min)
**AI:** 
"Requirements are clear. Now we decide HOW to build it.

**Context:**
- [Key requirement 1]
- [Constraint: Performance]
- [Constraint: Security]

Let's make technical decisions together."

## Round 1: Architecture Pattern (10 min)
**AI Options:**

A. **Clean Architecture**
   - Pros: Testable, maintainable
   - Cons: More boilerplate

B. **MVC**
   - Pros: Simple, familiar
   - Cons: Can become messy

C. **Serverless**
   - Pros: Scalable, no ops
   - Cons: Cold starts, vendor lock-in

**Discussion:**
- [Architect]: [Opinion on tradeoffs]
- [Dev]: [Experience with options]
- [DevOps]: [Operational concerns]

**Decision:** [Chosen pattern] - [Rationale]

## Round 2: Technology Stack (10 min)
...

## Round 3: Component Design (10 min)
...

## Summary
**Architecture:** [Decision]
**Technology:** [Stack chosen]
**Components:** [List]
**Plan:** [Draft]

**Decisions Made:**
1. [Decision] - Rationale
2. [Decision] - Rationale

**Risks:**
- [Risk 1]: [Mitigation]

**Next:** Task breakdown for implementation
```

## Response Structure

1. Context and constraints summary
2. Round-by-round facilitation
3. Architecture decisions
4. Draft implementation plan
5. Recorded decisions and rationale
6. Next steps

## Technical Areas to Cover

### Must Address:
- [ ] Architecture pattern
- [ ] Technology choices
- [ ] Data model
- [ ] API design
- [ ] Integration points
- [ ] Testing strategy
- [ ] Deployment approach
- [ ] Security measures
- [ ] Performance optimizations
- [ ] Error handling

### Options AI Should Prepare

For each technical decision, prepare:
- 2-3 options
- Pros/cons of each
- Alignment with requirements
- Risk assessment

## Decision Recording

Every decision needs:
- What was decided
- Why (rationale)
- Tradeoffs accepted
- Who was involved
- When to revisit

## Time Management

- Hard stop at 60 minutes
- If incomplete: Schedule follow-up
- Don't rush critical decisions
- Save progress every 15 minutes

## Follow-Up

After mob:
1. Finalize implementation plan
2. Break into tasks
3. Schedule implementation bolts
4. Set review points
