---
name: context-persistence
description: Use to maintain and manage persistent AI context across sessions, phases, and work units - ensures continuity and builds richer context over time
---

# Context Persistence

## Overview

Context Persistence enables AI to maintain state across multiple sessions, building increasingly rich understanding as work progresses through AI-DLC phases. This is essential for coherent, context-aware assistance.

**Core principle:** Context compounds - each phase enriches the next.

## When to Use

**Always:**
- Starting a new session (load previous context)
- Ending a session (save current state)
- Transitioning between phases (handoff context)
- Resuming work after interruption

**Never skip:**
- Starting "fresh" without checking context
- Losing decision rationale
- Forgetting constraints discovered earlier

## The Context Flow

```
Inception Context → Construction Context → Operations Context
       ↓                    ↓                    ↓
   Requirements          Architecture         Infrastructure
   User Stories          Domain Models        Deployments
   Constraints           Technical Decisions  Monitoring
       ↓                    ↓                    ↓
   RICHER CONTEXT → RICHER CONTEXT → RICHER CONTEXT
```

## Context Structure

### Context Hierarchy

```
project-root/
├── .ai-dlc/
│   ├── context.json          # Master context index
│   ├── inception/
│   │   ├── requirements.md
│   │   ├── decisions.md
│   │   └── constraints.md
│   ├── construction/
│   │   ├── architecture.md
│   │   ├── domain-models.md
│   │   └── tech-decisions.md
│   ├── operations/
│   │   ├── infrastructure.md
│   │   ├── deployments.md
│   │   └── monitoring.md
│   └── units/                 # Units of Work (was: Epics)
│       ├── unit-001/
│       │   ├── context.json
│       │   ├── spec.md
│       │   ├── plan.md
│       │   └── state.md
│       └── unit-002/
│           └── ...
```

### Context Index (context.json)

```json
{
  "project": {
    "name": "Project Name",
    "version": "1.0.0",
    "created": "2025-01-15",
    "lastUpdated": "2025-01-20"
  },
  "currentUnit": "unit-003",
  "phase": "construction",
  "lastSession": {
    "date": "2025-01-20",
    "type": "mob-elaboration",
    "topic": "API Design",
    "decisions": 3
  },
  "units": [
    {
      "id": "unit-001",
      "name": "User Authentication",
      "status": "completed",
      "phase": "operations",
      "path": "units/unit-001"
    },
    {
      "id": "unit-002", 
      "name": "Payment Processing",
      "status": "in-progress",
      "phase": "construction",
      "path": "units/unit-002"
    }
  ],
  "globalConstraints": [
    "Must support 10k concurrent users",
    "99.9% uptime SLA",
    "GDPR compliant"
  ],
  "patterns": {
    "architecture": "Clean Architecture",
    "api": "REST with OpenAPI",
    "testing": "TDD with Jest"
  }
}
```

## Unit of Work Context

Each unit (replaces "Epic") maintains:

### unit-context.json

```json
{
  "unit": {
    "id": "unit-001",
    "name": "User Authentication",
    "description": "Login, logout, session management",
    "status": "completed",
    "bolt": 3,
    "created": "2025-01-15",
    "completed": "2025-01-17"
  },
  "spec": {
    "path": "specs/20250115-auth.md",
    "version": "1.2",
    "status": "approved"
  },
  "plan": {
    "path": "plans/20250115-auth-plan.md",
    "architecture": "Token-based auth with JWT",
    "components": ["AuthService", "SessionManager", "TokenValidator"]
  },
  "progress": {
    "totalTasks": 12,
    "completed": 12,
    "currentTask": null
  },
  "decisions": [
    {
      "date": "2025-01-15",
      "topic": "Auth Method",
      "decision": "JWT with refresh tokens",
      "rationale": "Stateless, scalable",
      "mobSession": "mobs/20250115-auth-architecture.md"
    }
  ],
  "constraints": [
    "Token expiry: 24 hours",
    "Max sessions per user: 5"
  ],
  "learnings": [
    "Rate limiting critical for login",
    "Redis perfect for session storage"
  ],
  "nextUnits": ["unit-004"]
}
```

## Context Operations

### 1. Session Start - Load Context

**Before any work:**

```markdown
## Context Loading

**AI Action:**
1. Read .ai-dlc/context.json
2. Identify current unit and phase
3. Load unit context
4. Check for pending decisions
5. Review constraints

**AI:** "Welcome back! We're working on Unit 002: Payment Processing, currently in the Construction phase. Last session we decided to use Stripe for payments and defined the PaymentService architecture. There are 3 tasks remaining. Ready to continue?"
```

### 2. Session End - Save Context

**Before ending:**

```markdown
## Context Saving

**AI Action:**
1. Update unit progress
2. Record decisions made
3. Note constraints discovered
4. Capture learnings
5. Set next session context

**Update Files:**
- unit-context.json (progress, decisions)
- decisions.md (new decisions)
- state.md (current task state)
- context.json (lastSession, global state)
```

### 3. Phase Transition - Handoff

**Moving Inception → Construction:**

```markdown
## Phase Handoff: Inception → Construction

**Context to Transfer:**
- ✓ Requirements (from spec)
- ✓ Constraints (from elaboration)
- ✓ User stories (from mob sessions)
- ✓ Decisions (from elaboration mobs)

**AI:** "Moving to Construction phase. I have:
- 8 user stories
- 12 constraints
- 5 architectural requirements
- 3 integration points

Ready to create the implementation plan."
```

### 4. Bolt Planning

**Work is organized in Bolts (hours/days, not weeks):**

```markdown
## Bolt 3: Payment Integration

**Previous Bolts:**
- Bolt 1: Spec and elaboration (completed)
- Bolt 2: Architecture and planning (completed)

**This Bolt Goal:** Implement Stripe integration

**Context from Previous:**
- Chose Stripe over PayPal
- Webhook architecture defined
- Retry policy: 3 attempts with exponential backoff

**Tasks for This Bolt:**
1. Setup Stripe SDK
2. Create payment intents
3. Handle webhooks
4. Implement retry logic

**Duration:** 1-2 days
```

## Context Categories

### 1. Business Context

**What:**
- User personas
- Business goals
- Success metrics
- Market constraints

**Where:** `inception/requirements.md`

### 2. Technical Context

**What:**
- Architecture decisions
- Technology stack
- Integration patterns
- Performance requirements

**Where:** `construction/architecture.md`

### 3. Operational Context

**What:**
- Infrastructure setup
- Deployment processes
- Monitoring configuration
- Incident runbooks

**Where:** `operations/infrastructure.md`

### 4. Decision Context

**What:**
- All decisions made
- Rationale
- Dissenting views
- Revisit criteria

**Where:** `*/decisions.md` and `unit-context.json`

### 5. Constraint Context

**What:**
- Technical constraints
- Business constraints
- Regulatory constraints
- Resource constraints

**Where:** `*/constraints.md`

### 6. Learning Context

**What:**
- What worked
- What didn't
- Surprises
- Improvements

**Where:** `*/learnings.md`

## Context Usage Patterns

### Pattern 1: Enrichment

```
Inception: Basic user story
    ↓
Construction: Add technical constraints
    ↓
Operations: Add deployment considerations
    ↓
RICH CONTEXT
```

**Example:**
```markdown
**Inception:** User wants to upload files

**Construction:** 
- Add: Max file size 10MB
- Add: Supported formats: PDF, PNG, JPG
- Add: Virus scanning required

**Operations:**
- Add: S3 bucket configuration
- Add: CDN for delivery
- Add: Scanning service quota
```

### Pattern 2: Refinement

```
Initial assumption → Mob validation → Refined understanding
```

**Example:**
```markdown
**Initial:** "Users need authentication"

**Mob 1:** "Which users?"
- Refined: External customers, not internal

**Mob 2:** "How do they authenticate?"
- Refined: OAuth + MFA required

**Final:** "External customers authenticate via OAuth with MFA"
```

### Pattern 3: Continuity

```
Previous session → Saved context → Next session resumes seamlessly
```

**Example:**
```markdown
**Monday:** Worked on Task 3, left off at line 45
**Tuesday:** AI loads context
"Welcome back! You were implementing the retry logic in paymentService.ts at line 45. The circuit breaker pattern was decided in last week's mob. Ready to continue?"
```

## Context Best Practices

### Do's

✅ **Save frequently** - After every mob session
✅ **Be specific** - Exact file paths, line numbers
✅ **Capture rationale** - Why decisions were made
✅ **Version control** - Commit context with code
✅ **Review context** - Start sessions by reviewing state
✅ **Link artifacts** - Connect specs, plans, tasks

### Don'ts

❌ **Lose context** - Never start without loading
❌ **Duplicate info** - Reference, don't copy
❌ **Vague state** - "In progress" → "Task 3 of 8, line 45"
❌ **Orphan decisions** - Always record with rationale
❌ **Forget constraints** - They're critical for later phases

## AI Context Prompts

### Starting Work

```markdown
**User:** Continue work on payment system

**AI:** [Loads context]
"Resuming Unit 002: Payment Processing. We're in Bolt 3 (Construction phase).

**Context:**
- Architecture: Stripe integration
- Current task: Task 5/8 - Webhook handler
- Last action: Defined webhook schema
- Next: Implement signature verification

**Ready to:** Implement webhook security. Correct?"
```

### Switching Units

```markdown
**User:** Switch to work on user profiles

**AI:** [Saves current, loads new]
"Saving Unit 002 state (Construction, 5/8 tasks complete). 

Loading Unit 003: User Profiles (Inception phase, 2/3 mobs completed).

**Next:** Architecture mob scheduled for tomorrow.
**Current:** Spec approved, awaiting elaboration on avatar upload."
```

### Phase Transition

```markdown
**User:** Move payment system to operations

**AI:** [Handoff]
"Unit 002 Phase Transition: Construction → Operations

**Transferring context:**
- ✓ 8/8 tasks complete
- ✓ All tests passing
- ✓ Architecture: Stripe + Redis
- ✓ Constraints: Rate limits, retry policy

**Operations needs:**
- Infrastructure: ECS vs Lambda?
- Monitoring: Which metrics?
- Deployment: Blue/green strategy?

**Ready for Operations planning?"
```

## Context Persistence Tools

### Context Commands

```bash
# View current context
opencode /context

# Switch to different unit
opencode /context unit-003

# View phase context  
opencode /context phase inception

# Show all decisions
opencode /context decisions

# Show constraints
opencode /context constraints
```

### Context API

```typescript
interface ContextManager {
  load(): Promise<Context>;
  save(context: Context): Promise<void>;
  transition(from: Phase, to: Phase): Promise<void>;
  getUnit(id: string): Promise<UnitContext>;
  recordDecision(decision: Decision): Promise<void>;
  addConstraint(constraint: Constraint): Promise<void>;
  updateProgress(unit: string, progress: Progress): Promise<void>;
}
```

## Troubleshooting

### "I lost my context!"

**Solution:** Context is version controlled - check git history
```bash
git log --oneline .ai-dlc/
git show HEAD:.ai-dlc/context.json
```

### "Context is out of sync"

**Solution:** Rebuild from artifacts
```markdown
**AI:** "Context mismatch detected. Rebuilding from:
- Specs: 3 files
- Plans: 2 files  
- Tasks: 1 incomplete
- Mobs: 5 sessions

Reconciled. Current state: Unit 002, Task 5/8"
```

### "Multiple units in progress"

**Solution:** Context switching with state preservation
```markdown
**AI:** "You have 2 active units:
1. Unit 002: Payment (Construction, 5/8 tasks) - LAST ACTIVE
2. Unit 003: Profiles (Inception, 2/3 mobs)

Which unit to work on?"
```

## Integration with Tools

### Git Integration

```bash
# Commit context with code
git add .ai-dlc/ src/
git commit -m "feat: payment webhook handler

- Implements signature verification
- Adds retry logic with circuit breaker
- Context: Unit 002, Task 5 → 6"
```

### CI/CD Integration

```yaml
# Verify context on build
- name: Check Context
  run: |
    if [ ! -f .ai-dlc/context.json ]; then
      echo "ERROR: Missing AI-DLC context"
      exit 1
    fi
```

## Final Rule

```
Context compounds → Decisions improve → Quality increases

Ignore context? You lose continuity and make poor decisions.
```

No exceptions without your human partner's permission.
