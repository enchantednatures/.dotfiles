---
name: mob-collaboration
description: Use for collaborative AI-team sessions where multiple stakeholders validate AI proposals together - supports real-time decision making, clarification, and consensus building
---

# Mob Collaboration

## Overview

Mob Collaboration enables teams to work together with AI in real-time, validating questions, making decisions, and building shared understanding. This is the core of AI-DLC's collaborative dimension.

**Core principle:** AI proposes, team validates, decisions are consensus-driven.

## When to Use

**Always for:**
- Inception phase elaboration (requirements validation)
- Construction phase decisions (architecture, design)
- Complex problem solving requiring multiple perspectives
- Cross-functional alignment sessions

**Never skip when:**
- AI asks clarifying questions
- Critical architectural decisions needed
- Business requirements are ambiguous
- Technical tradeoffs require discussion

## The Mob Pattern

```
AI proposes → Team discusses → Consensus reached → AI implements
     ↑_______________________________________________|
```

## Mob Session Types

### 1. Mob Elaboration (Inception Phase)

**Purpose:** Validate requirements and clarify intent

**Flow:**
1. AI presents understanding of business intent
2. AI asks clarifying questions
3. Team discusses and provides context
4. Consensus on requirements
5. AI refines specification

**Questions AI Should Ask:**
- "Who are the primary users?"
- "What problem are we solving?"
- "What does success look like?"
- "What are the constraints?"
- "What should happen in [edge case]?"

**Team Response Pattern:**
```
Product Owner: "The user is..."
Developer: "We should also consider..."
Architect: "The constraint is..."
AI: "Let me summarize: [validation]"
All: "Yes, that's correct" or "Actually..."
```

### 2. Mob Construction (Construction Phase)

**Purpose:** Make technical decisions collaboratively

**Flow:**
1. AI proposes architecture/design
2. AI asks technical questions
3. Team discusses tradeoffs
4. Consensus on approach
5. AI implements

**Decisions AI Should Facilitate:**
- Architecture pattern selection
- Technology choices
- API design
- Data model decisions
- Integration strategies

**Team Response Pattern:**
```
AI: "I propose using [pattern] because..."
Architect: "That works, but consider..."
Developer: "Can we use [alternative]?"
AI: "Tradeoffs: [A] vs [B]"
All: "Let's go with [decision]"
```

## Mob Session Format

### Opening (5 minutes)

```markdown
## Mob Session: [Topic]
**Type:** Elaboration / Construction
**Participants:** [Names and roles]
**Duration:** [30-60 minutes]
**Goal:** [Clear objective]

### Context
[Background from previous phases]
```

### Body (Iterative)

```markdown
### Round 1: AI Proposal
**AI:** [Proposes understanding/questions]

**Team Discussion:**
- [PO]: [Business context]
- [Architect]: [Technical consideration]
- [Dev]: [Implementation concern]
- [QA]: [Testing perspective]

**Consensus:** [Agreement]

**Action:** AI refines based on feedback
```

### Closing (5 minutes)

```markdown
### Summary
**Decisions Made:**
1. [Decision 1]
2. [Decision 2]

**Next Steps:**
- AI will: [Action]
- Team will: [Action]

**Artifacts Created:**
- [Links to specs/plans]
```

## Facilitation Patterns

### For Product Owners

**When AI asks business questions:**
- Provide user personas
- Clarify success metrics
- Define edge cases
- Validate priorities

**Phrases to use:**
- "The user needs..."
- "Success means..."
- "We should prioritize..."
- "Consider the scenario where..."

### For Architects

**When AI asks technical questions:**
- Guide architectural decisions
- Validate constraints
- Suggest patterns
- Identify risks

**Phrases to use:**
- "We should use..."
- "The constraint is..."
- "Consider [pattern] because..."
- "Risk: [concern]"

### For Developers

**When AI asks implementation questions:**
- Provide technical context
- Suggest libraries/tools
- Identify blockers
- Estimate complexity

**Phrases to use:**
- "We have..."
- "We could use..."
- "Blocker: [issue]"
- "This would take..."

### For QA/Testing

**When AI asks quality questions:**
- Define acceptance criteria
- Identify test scenarios
- Suggest edge cases
- Validate coverage

**Phrases to use:**
- "We should test..."
- "Edge case: [scenario]"
- "Acceptance criteria: [criteria]"
- "Consider [quality attribute]"

## Decision Making

### Consensus Building

**AI Role:**
- Present options objectively
- Summarize tradeoffs
- Highlight risks
- Guide to agreement

**When Consensus Isn't Reached:**

1. **Minor disagreement:**
   - AI suggests compromise
   - Team votes
   - Decision recorded with rationale

2. **Major disagreement:**
   - Escalate to decider (usually architect/PO)
   - Document dissenting views
   - Plan to revisit if issues arise

3. **Information gaps:**
   - Assign research tasks
   - Schedule follow-up mob
   - Make provisional decision

### Decision Record Format

```markdown
## Decision: [Topic]
**Date:** [Date]
**Mob Session:** [Link]

### Options Considered
1. [Option A] - Pros/Cons
2. [Option B] - Pros/Cons

### Decision
**Chosen:** [Option]
**Rationale:** [Why]
**Dissent:** [If any]

### Tradeoffs Accepted
- [Tradeoff 1]
- [Tradeoff 2]

### Revisit Criteria
Revisit if: [Conditions]
```

## Time Management

### Bolt Sessions

Mob sessions are time-boxed to maintain velocity:

| Type | Duration | Best For |
|------|----------|----------|
| Quick Clarification | 15 min | Single question |
| Elaboration Round | 30 min | Requirements |
| Architecture Decision | 45 min | Technical design |
| Full Mob | 60 min | Complex feature |

### Timeboxing Rules

- **Start on time** - No waiting
- **Hard stop** - When time's up, summarize and schedule follow-up
- **Parking lot** - Capture off-topic items for later
- **Rotate facilitator** - Different person each session

## AI-Human Collaboration Principles

### AI Responsibilities

1. **Prepare** - Research before session
2. **Present** - Clear proposals and questions
3. **Listen** - Capture all input
4. **Summarize** - Validate understanding
5. **Implement** - Execute decisions

### Human Responsibilities

1. **Attend** - Be present and engaged
2. **Question** - Challenge assumptions
3. **Contextualize** - Provide business/technical context
4. **Decide** - Make the critical choices
5. **Validate** - Confirm AI's understanding

## Common Anti-Patterns

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| AI decides alone | Missing context | Always seek validation |
| One voice dominates | Biased outcomes | Round-robin input |
| Analysis paralysis | No progress | Timebox and decide |
| Skipping elaboration | Wrong requirements | Mandatory mob sessions |
| Too many participants | Inefficient | Core team only (3-5 people) |

## Integration with AI-DLC Phases

### Inception (Mob Elaboration)

**Goal:** Shared understanding of requirements

**Sessions:**
- Intent clarification mob
- User story elaboration mob
- Edge case identification mob
- Acceptance criteria mob

### Construction (Mob Construction)

**Goal:** Shared technical decisions

**Sessions:**
- Architecture selection mob
- API design mob
- Data model mob
- Integration strategy mob
- Testing approach mob

### Operations

**Goal:** Shared operational decisions

**Sessions:**
- Deployment strategy mob
- Monitoring setup mob
- Runbook creation mob

## Example: Full Mob Session

```markdown
# Mob Session: User Authentication Feature
**Type:** Inception Elaboration
**Participants:** 
- Raja (Product Owner)
- Maya (Architect)
- Alex (Developer)
- Sam (QA)
**Duration:** 45 minutes
**Goal:** Validate requirements for auth system

## Round 1: User Intent

**AI:** Based on the business request, I understand we need a user authentication system. Let me propose my understanding:

- Users should log in with email/password
- Sessions should be secure
- We need password reset
- Admin should manage users

**Questions:**
1. Who are the primary users? Internal employees or external customers?
2. What does "secure" mean - MFA? SSO? Just passwords?
3. Should users self-register or be invited?

**Raja (PO):** These are external customers. Self-registration is required.

**Maya (Architect):** We need MFA for security compliance.

**Alex (Dev):** We should support OAuth as well - customers expect it.

**Sam (QA):** We need to test account lockout after failed attempts.

**AI:** Summary:
- External customers, self-registration
- MFA required for compliance
- OAuth support needed
- Account lockout policy needed

**All:** ✅ Confirmed

## Round 2: Scope Decisions

**AI:** Options for implementation:

A. Build custom (full control, longer)
B. Use Auth0/Clerk (faster, dependencies)
C. Hybrid (custom + OAuth providers)

**Maya:** Hybrid approach - custom for email/password, OAuth for Google/GitHub.

**Alex:** Agreed. We keep control of core auth.

**Raja:** Timeline is tight - can we do this in 2 weeks?

**Alex:** With AI help, yes. Without, no.

**Decision:** Hybrid approach, 2-week bolt

## Summary

**Decisions:**
1. External customers, self-registration
2. MFA required
3. Hybrid auth approach
4. 2-week implementation timeline

**Artifacts:**
- Updated spec: specs/20250115-auth.md

**Next Mob:** Architecture decision (tomorrow 2pm)
```

## Best Practices

1. **Prepare in advance** - AI reviews context before session
2. **Set clear goals** - Every mob has specific objective
3. **Document decisions** - Capture rationale for future reference
4. **Follow up** - Actions assigned and tracked
5. **Review retrospectively** - Did we make good decisions?
6. **Iterate quickly** - Short cycles, frequent mobs
7. **Include diverse voices** - Different perspectives improve decisions

## Success Metrics

- **Velocity:** Are we making decisions faster?
- **Alignment:** Do all stakeholders agree?
- **Quality:** Are decisions leading to good outcomes?
- **Engagement:** Is everyone participating?

## Final Rule

```
AI proposes → Team validates → Consensus reached → AI implements

Skip the mob? You lose context and alignment.
```

No exceptions without your human partner's permission.
