---
description: Plan and execute a Bolt - short, intense work cycle (hours/days) for rapid delivery
model: opencode/kimi-k2.5
---

Plan and execute a Bolt

A Bolt is a short, intense work cycle (hours to days, not weeks) for rapid delivery in AI-DLC. Bolts replace traditional sprints with faster, focused execution.

## Context

You need to complete a specific set of tasks quickly. The Bolt methodology emphasizes:
- Intense focus
- Clear objectives  
- Rapid iteration
- Immediate feedback

## Bolt Characteristics

- **Duration:** 2 hours to 2 days
- **Scope:** 3-8 tasks
- **Goal:** Complete specific deliverable
- **Team:** 1-3 people + AI
- **Output:** Working, tested code

## Process

### Step 1: Bolt Planning (15 min)

AI helps plan the Bolt:
1. Load current unit context
2. Identify available tasks
3. Select tasks for this Bolt
4. Estimate effort
5. Define done criteria

**Bolt Plan Format:**
```markdown
# Bolt [Number]: [Name]
**Date:** [Date]
**Duration:** [X hours/days]
**Unit:** [Unit ID]

## Goal
[Clear statement of what will be delivered]

## Tasks
- [ ] Task A - [Time estimate]
- [ ] Task B - [Time estimate]
- [ ] Task C - [Time estimate]

## Definition of Done
- [ ] All tasks complete
- [ ] All tests passing
- [ ] Code reviewed
- [ ] Deployed to [environment]

## Risks
- [Risk]: [Mitigation]
```

### Step 2: Bolt Execution

Work through tasks rapidly:
1. Start with highest priority
2. Use TDD for each
3. Commit after each task
4. Track time
5. Handle blockers immediately

AI assists by:
- Generating code
- Writing tests
- Debugging issues
- Explaining concepts
- Refactoring

### Step 3: Bolt Review (15 min)

At Bolt end:
1. Verify all tasks done
2. Run all tests
3. Review code quality
4. Check against acceptance criteria
5. Update unit context

### Step 4: Bolt Retrospective (10 min)

Brief reflection:
- What went well?
- What was hard?
- What to improve?
- Next Bolt plan

## Bolt Types

### Quick Bolt (2-4 hours)
**Best for:**
- Bug fixes
- Small features
- Refactoring
- Documentation

**Tasks:** 2-4
**Team:** 1 dev + AI

### Standard Bolt (1 day)
**Best for:**
- Feature implementation
- Integration work
- Testing coverage

**Tasks:** 4-6
**Team:** 1-2 devs + AI

### Deep Bolt (2 days)
**Best for:**
- Complex features
- Architecture changes
- Performance optimization

**Tasks:** 6-8
**Team:** 2-3 devs + AI

## Bolt Workflow

```
Planning (15m) → Execution (X hours) → Review (15m) → Retro (10m)
       ↓                ↓                  ↓              ↓
   Set goals      Intense work      Validate       Improve
   Select tasks   TDD cycle         Quality        Next bolt
```

## Time Management

### During Bolt:

- **No meetings** (except mob sessions)
- **No context switching** (focus on bolt tasks only)
- **No interruptions** (Slack/Teams: DND mode)
- **Frequent commits** (after every task)
- **Test continuously** (watch tests pass)

### If Behind Schedule:

1. **Re-estimate** remaining work
2. **Cut scope** if needed (move tasks to next bolt)
3. **Extend** if critical (max 1 day extension)
4. **Abort** if fundamentally blocked (rare)

## Bolt Success Metrics

- ✅ All planned tasks complete
- ✅ All tests passing
- ✅ Code reviewed
- ✅ Acceptance criteria met
- ✅ No blockers remaining
- ✅ Knowledge documented

## Bolt Failure Recovery

If Bolt fails:

1. **Analyze:** Why did we miss?
2. **Learn:** What to improve?
3. **Adjust:** Next Bolt plan updated
4. **Communicate:** Stakeholders informed
5. **Continue:** Start next Bolt immediately

## Multiple Bolts in a Unit

```
Unit: User Authentication (2 weeks)
├── Bolt 1: Requirements & Elaboration (1 day)
├── Bolt 2: Architecture & Planning (1 day)
├── Bolt 3: Core Implementation (2 days)
├── Bolt 4: Integration & Testing (2 days)
├── Bolt 5: Polish & Deploy (1 day)
└── Bolt 6: Monitoring & Hardening (1 day)
```

Total: 8 days (vs. 2-week sprint = 10 days)

## Comparison: Bolts vs. Sprints

| Aspect | Sprint (2 weeks) | Bolt (hours-days) |
|--------|------------------|-------------------|
| Duration | 2 weeks | Hours to 2 days |
| Planning | 1-2 hours | 15 minutes |
| Review | At end | Continuous |
| Retrospective | 1 hour | 10 minutes |
| Scope | 10-20 tasks | 3-8 tasks |
| Focus | Distributed | Intense |
| Feedback | Delayed | Immediate |
| Adaptation | Next sprint | Next bolt |

## Response Structure

1. Current unit and phase context
2. Available tasks
3. Bolt proposal (which tasks, duration)
4. Definition of done
5. Ready to start confirmation

## Example Bolt

```markdown
# Bolt 3: Payment Webhook Handler
**Unit:** Unit 002 - Payment Processing
**Phase:** Construction
**Duration:** 1 day

## Context
Previous Bolts:
- Bolt 1: Spec & Elaboration ✅
- Bolt 2: Architecture & Stripe Setup ✅

## Goal
Implement secure webhook handling for Stripe events

## Tasks (5)
1. [ ] Setup webhook endpoint route (30m)
2. [ ] Implement signature verification (2h)
3. [ ] Handle payment_intent.succeeded (2h)
4. [ ] Handle payment_intent.failed (1h)
5. [ ] Add retry logic for failed events (1h)

Total: ~6.5 hours

## Definition of Done
- [ ] All Stripe events handled
- [ ] Signature verification tested
- [ ] Retry logic working
- [ ] Integration tests pass
- [ ] Code reviewed by Maya

## Risk
Stripe API rate limits - use exponential backoff

## Start Time: 9:00 AM
## Target End: 4:00 PM (with buffer)
```

## Integration with Other Commands

- Start with `/mob-elaborate` or `/mob-construct`
- Plan with `/plan` and `/tasks`
- Execute with `/bolt`
- Review with `/review`
- Track in context

## Best Practices

1. **Timebox strictly** - Bolts don't extend
2. **Focus intensely** - No multitasking
3. **Commit often** - After every task
4. **Test always** - TDD discipline
5. **Review immediately** - Don't wait
6. **Learn continuously** - Retro every Bolt

## Final Rule

```
Plan → Execute → Review → Learn → Repeat

Short cycles → Fast feedback → Rapid improvement
```

No exceptions without your human partner's permission.
