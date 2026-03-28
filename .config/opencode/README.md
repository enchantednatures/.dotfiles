# AI-DLC: AI-Driven Development Lifecycle for Opencode

A comprehensive AI-DLC (AI-Driven Development Lifecycle) implementation for Opencode, based on AWS's AI-DLC methodology and inspired by Speckit. This framework positions AI as a central collaborator in software development, with humans providing oversight and critical decisions.

## AI-DLC Overview

AI-DLC is an AI-centric transformative approach to software development emphasizing two dimensions:

**AI Powered Execution with Human Oversight:** AI creates detailed plans, seeks clarification, defers critical decisions to humans.

**Dynamic Team Collaboration:** Teams unite in collaborative spaces (Mob sessions) for real-time problem solving and rapid decision-making.

### Three Phases of AI-DLC

```
┌─────────────────────────────────────────────────────────────┐
│                    AI-DLC LIFECYCLE                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  INCEPTION          CONSTRUCTION          OPERATIONS       │
│  ─────────          ────────────          ───────────       │
│                                                             │
│  Mob Elaboration    Mob Construction    Infrastructure    │
│  Requirements  →    Implementation   →   Deployment       │
│  Specification      Code & Tests         Monitoring        │
│                                                             │
│  [specify skill]    [plan skill]       [k8s-debug skill] │
│  [/spec cmd]        [/plan cmd]        [Operations cmds]   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### New Terminology (AI-DLC)

| Traditional | AI-DLC | Description |
|------------|--------|-------------|
| Sprint | **Bolt** | Short, intense work cycles (hours/days, not weeks) |
| Epic | **Unit of Work** | Manageable scope of related work |
| Story Refinement | **Mob Elaboration** | Collaborative requirements validation |
| Architecture Review | **Mob Construction** | Collaborative technical decision-making |
| Daily Standup | **Bolt Check-in** | Quick progress sync |
| Sprint Retro | **Bolt Retrospective** | 10-minute learnings capture |

## Quick Start

### 1. Initialize AI-DLC Project Structure

```bash
# Create AI-DLC context directory
mkdir -p .ai-dlc/{inception,construction,operations,units}

# Create standard directories
mkdir -p specs plans tasks reviews mobs docs
```

### 2. AI-DLC Workflow (Complete)

```bash
# INCEPTION PHASE
# Step 1: Create Unit and Specification
opencode /spec "I want to build a user authentication system..."
# Creates: .ai-dlc/units/unit-001/, specs/YYYYMMDD-auth.md

# Step 2: Mob Elaboration (collaborative requirements validation)
opencode /mob-elaborate unit-001
# Facilitates team session to validate requirements

# CONSTRUCTION PHASE
# Step 3: Create Implementation Plan
opencode /plan specs/YYYYMMDD-auth.md
# Creates: plans/YYYYMMDD-auth-plan.md

# Step 4: Mob Construction (collaborative technical decisions)
opencode /mob-construct unit-001
# Facilitates architecture and design decisions

# Step 5: Generate Task List
opencode /tasks plans/YYYYMMDD-auth-plan.md
# Creates: tasks/YYYYMMDD-auth-tasks.md

# Step 6: Execute Bolt (short intense work cycle)
opencode /bolt unit-001 "Bolt 3: Core Implementation"
# Plans and executes 1-2 day focused work cycle

# QUALITY GATES
# Step 7: Review
opencode /review
# Creates: reviews/YYYYMMDD-auth-review.md

# Step 8: Generate PR
opencode /pr
# Creates PR description with full context

# OPERATIONS PHASE
# Step 9: Deploy (when implemented)
# Use k8s-microservices-debug skill for operations
```

### 3. Context Management

```bash
# View current context
opencode /context

# View specific unit
opencode /context unit-001

# Switch units
opencode /context unit-002

# View decisions
opencode /context decisions

# View constraints
opencode /context constraints
```

## AI-DLC Commands by Phase

### Inception Phase (Requirements)

**Goal:** Transform business intent into detailed requirements

| Command | Skill | Purpose |
|---------|-------|---------|
| `/spec` | specify | Create comprehensive specification |
| `/mob-elaborate` | mob-collaboration | Team validation of requirements |

**Output:**
- Specification (specs/*.md)
- Requirements documented
- Constraints identified
- Context saved to .ai-dlc/inception/

### Construction Phase (Build)

**Goal:** Using validated context, build the solution

| Command | Skill | Purpose |
|---------|-------|---------|
| `/plan` | plan | Create implementation plan |
| `/mob-construct` | mob-collaboration | Team technical decisions |
| `/tasks` | breakdown | Generate executable tasks |
| `/bolt` | - | Execute short work cycles |

**Output:**
- Implementation plan (plans/*.md)
- Task list (tasks/*.md)
- Architecture decisions
- Working code
- Context saved to .ai-dlc/construction/

### Quality & Design Commands

**Goal:** Ensure architecture, security, and API design quality

| Command | Skill | Purpose |
|---------|-------|---------|
| `/arch-review` | architecture-review | Review system architecture |
| `/api-design` | api-design | Design REST/GraphQL/gRPC APIs |
| `/data-model` | data-model-design | Design database schemas |
| `/security-review` | security-review | Security vulnerability scan |
| `/perf-review` | performance-review | Performance optimization review |
| `/refactor` | refactoring | Systematic code refactoring |

**Output:**
- Architecture review reports
- API specifications
- Database schemas
- Security assessments
- Performance reports

### Operations Phase (Run)

**Goal:** Deploy and maintain in production

| Command | Skill | Purpose |
|---------|-------|---------|
| `/review` | review | Quality gates |
| `/pr` | document | Delivery documentation |
| `/migrate` | migration-planning | Database/code migrations |
| `/incident` | incident-response | Production incident response |
| (debug) | k8s-microservices-debug | Production debugging |

**Output:**
- Review reports
- PR descriptions
- Migration plans
- Incident reports
- Documentation
- Context saved to .ai-dlc/operations/

## Available Commands Summary

## Core Skills

### AI-DLC Foundation Skills

1. **mob-collaboration** - Collaborative AI-team sessions
   - Mob Elaboration (Inception)
   - Mob Construction (Construction)
   - Real-time decision making

2. **context-persistence** - State management
   - Maintain context across sessions
   - Phase transitions
   - Unit of Work tracking

3. **specify** - Inception phase
   - Requirements specification
   - PRD creation

4. **plan** - Construction phase planning
   - Architecture design
   - Component breakdown

5. **breakdown** - Construction phase execution
   - Task generation
   - Acceptance criteria

### Supporting Skills

6. **test-driven-development** - Implementation methodology
7. **review** - Quality assurance
8. **document** - Knowledge capture
9. **k8s-microservices-debug** - Operations
10. **root-cause-tracing** - Deep debugging

## Specialized Agents (New!)

### Architecture & Design Agents

11. **architecture-review** - Systematic architecture validation
    - Reviews against requirements
    - Pattern evaluation
    - Component design review
    - Scalability assessment

12. **api-design** - API design (REST/GraphQL/gRPC)
    - Resource modeling
    - Endpoint design
    - Versioning strategy
    - OpenAPI documentation

13. **data-model-design** - Database schema design
    - Entity-relationship design
    - Normalization
    - Indexing strategy
    - Migration planning

### Quality & Security Agents

14. **security-review** - Security vulnerability identification
    - Input validation
    - Authentication/Authorization
    - Data protection
    - OWASP Top 10 assessment

15. **performance-review** - Performance optimization
    - Bottleneck identification
    - Resource usage analysis
    - Algorithm efficiency
    - Caching strategies

### Operations Agents

16. **deployment-planning** - Safe deployment strategies
    - Deployment patterns (blue-green, canary, rolling)
    - Rollback planning
    - Database migrations
    - Zero-downtime deployments

17. **migration-planning** - Systematic migrations
    - Database migrations
    - Code migrations
    - Infrastructure migrations
    - Expand-contract patterns

18. **incident-response** - Production incident handling
    - Incident triage
    - Mitigation strategies
    - Root cause analysis
    - Postmortem generation

19. **refactoring** - Safe code refactoring
    - Code smell identification
    - Refactoring techniques
    - Test-driven refactoring
    - Behavior preservation

## Bolt Workflow (Replaces Sprints)

### What is a Bolt?

A **Bolt** is a short, intense work cycle:
- **Duration:** Hours to 2 days (not weeks)
- **Scope:** 3-8 tasks
- **Team:** 1-3 people + AI
- **Output:** Working, tested code

### Bolt Types

| Type | Duration | Tasks | Best For |
|------|----------|-------|----------|
| Quick Bolt | 2-4 hours | 2-4 | Bug fixes, small features |
| Standard Bolt | 1 day | 4-6 | Feature implementation |
| Deep Bolt | 2 days | 6-8 | Complex features, architecture |

### Bolt Flow

```
Planning (15m) → Execution (hours) → Review (15m) → Retro (10m)
      ↓                ↓                ↓              ↓
   Select tasks    Intense work      Validate       Learn
   Set goals       TDD cycle         Quality        Improve
```

### Bolt Example

```bash
opencode /bolt unit-003 "Bolt 2: Payment Webhook"
```

Creates and executes:
```markdown
# Bolt 2: Payment Webhook
**Unit:** Unit 003 - Payment Processing
**Duration:** 1 day

## Goal
Implement secure Stripe webhook handling

## Tasks (5)
1. [ ] Setup webhook endpoint (30m)
2. [ ] Signature verification (2h)
3. [ ] Handle success events (2h)
4. [ ] Handle failure events (1h)
5. [ ] Retry logic (1h)

## Definition of Done
- [ ] All tasks complete
- [ ] Tests passing
- [ ] Code reviewed
- [ ] Security verified
```

## Mob Collaboration

### Mob Elaboration (Inception)

**Purpose:** Validate requirements collaboratively

**Participants:** Product Owner, Architect, Developer, QA

**Flow:**
1. AI presents understanding
2. AI asks clarifying questions
3. Team provides context
4. Consensus on requirements
5. AI refines specification

**Usage:**
```bash
opencode /mob-elaborate unit-001
```

### Mob Construction (Construction)

**Purpose:** Make technical decisions collaboratively

**Participants:** Architect, Developers, DevOps

**Flow:**
1. AI presents technical options
2. Team discusses tradeoffs
3. Consensus on approach
4. AI creates plan
5. AI implements

**Usage:**
```bash
opencode /mob-construct unit-001
```

## Context Persistence

### Unit of Work Structure

```
.ai-dlc/
├── context.json              # Master index
├── inception/
│   ├── requirements.md
│   ├── decisions.md
│   └── constraints.md
├── construction/
│   ├── architecture.md
│   ├── tech-decisions.md
│   └── domain-models.md
├── operations/
│   ├── infrastructure.md
│   ├── deployments.md
│   └── monitoring.md
└── units/
    ├── unit-001/
    │   ├── context.json      # Unit state
    │   ├── spec.md          # Specification
    │   ├── plan.md          # Implementation plan
    │   └── state.md         # Current progress
    └── unit-002/
        └── ...
```

### Context Commands

```bash
# View current context
opencode /context

# View specific unit details
opencode /context unit-003

# View all decisions
opencode /context decisions

# View constraints
opencode /context constraints

# Switch units
opencode /context unit-002
```

## Workflow Example

Complete example of building a feature:

### 1. Create Unit and Spec (Inception)

```bash
# Initialize context
mkdir -p .ai-dlc/units/unit-001

# Create specification
opencode /spec "Build user profile management with avatar upload"

# AI creates:
# - specs/20250115-user-profile.md
# - .ai-dlc/units/unit-001/context.json
```

### 2. Mob Elaboration (Inception)

```bash
opencode /mob-elaborate unit-001
```

AI facilitates:
- "Who are the users?"
- "What file formats?"
- "Max file size?"
- Team validates and clarifies

### 3. Create Plan (Construction)

```bash
opencode /plan specs/20250115-user-profile.md
```

### 4. Mob Construction (Construction)

```bash
opencode /mob-construct unit-001
```

AI facilitates:
- "Storage: S3 or filesystem?"
- "Processing: Lambda or app server?"
- "CDN needed?"
- Team makes technical decisions

### 5. Break Into Tasks

```bash
opencode /tasks plans/20250115-user-profile-plan.md
```

### 6. Execute Bolts

```bash
# Bolt 1: Setup and infrastructure
opencode /bolt unit-001 "Bolt 1: S3 and Upload Setup"

# Bolt 2: Avatar processing
opencode /bolt unit-001 "Bolt 2: Image Processing"

# Bolt 3: Profile API
opencode /bolt unit-001 "Bolt 3: Profile Endpoints"
```

### 7. Review and Deliver

```bash
opencode /review
opencode /pr
```

## Principles

### AI-DLC Core Principles

1. **AI Proposes, Humans Decide**
   - AI creates plans and asks questions
   - Humans provide context and make critical decisions
   - Consensus before implementation

2. **Context Compounds**
   - Each phase enriches the next
   - Persistent state across sessions
   - Decisions recorded with rationale

3. **Collaborative, Not Replacement**
   - Mob sessions for alignment
   - Team validates AI understanding
   - Shared decision-making

4. **Fast Cycles, Continuous Delivery**
   - Bolts: hours/days, not weeks
   - Immediate feedback
   - Rapid iteration

5. **Quality Through Clarity**
   - Spec-driven prevents rework
   - Mob sessions catch issues early
   - Continuous review

## Best Practices

### Do's

✅ Always use Mob sessions for decisions  
✅ Save context after every session  
✅ Execute work in Bolts  
✅ Review every Bolt  
✅ Record all decisions with rationale  
✅ Include diverse voices in Mobs  
✅ Timebox strictly (no extending Bolts)  
✅ Commit context with code  

### Don'ts

❌ Skip Mob sessions  
❌ Lose context between sessions  
❌ Work without specification  
❌ Let AI decide alone  
❌ Extend Bolts (start new one)  
❌ Skip reviews  
❌ Forget to document learnings  

## Comparison: Traditional vs AI-DLC

| Aspect | Traditional | AI-DLC |
|--------|-------------|---------|
| Requirements | Written by PM, devs implement | Mob Elaboration with AI |
| Architecture | Architect designs alone | Mob Construction consensus |
| Work cycles | 2-week sprints | Bolts (hours-days) |
| Decisions | Documented separately | Recorded in context |
| Context | Lost between meetings | Persisted in .ai-dlc/ |
| Teamwork | Async handoffs | Real-time Mob sessions |
| Velocity | Weeks per feature | Days per feature |

## Getting Started

### 1. Setup

```bash
# In your project root
mkdir -p .ai-dlc/{inception,construction,operations,units}
mkdir -p {specs,plans,tasks,reviews,mobs,docs}
```

### 2. First Unit

```bash
# Start with a small feature
opencode /spec "Build contact form with validation and email notification"

# Validate with team
opencode /mob-elaborate unit-001

# Continue through phases...
```

### 3. Daily Workflow

```bash
# Morning: Load context and plan Bolt
opencode /context
opencode /bolt unit-001 "Today's Bolt"

# During day: Execute with TDD
# (use test-driven-development skill)

# End of Bolt: Review and save
opencode /review
git add . && git commit -m "feat: completed Bolt 3"
```

## Integration with Existing Tools

### Git Integration

```bash
# Commit context with code
git add .ai-dlc/ src/ tests/
git commit -m "feat: payment webhook handler

- Implements signature verification
- Adds retry logic with circuit breaker
- Context: Unit 002, Bolt 3, Task 5→6"
```

### CI/CD Integration

```yaml
# Verify context in CI
- name: Check AI-DLC Context
  run: |
    test -f .ai-dlc/context.json || exit 1
    test -f .ai-dlc/units/unit-*/context.json || exit 1
```

## Troubleshooting

### "I lost my context"

```bash
# Context is version controlled
git log --oneline .ai-dlc/
git checkout HEAD~1 -- .ai-dlc/
```

### "Context is out of sync"

```bash
opencode /context
# AI will detect mismatch and offer to rebuild
```

### "AI isn't using context"

Always mention in prompt:
```
"Load context for unit-003 and continue with Task 5"
```

## Complete Command Reference

### AI-DLC Lifecycle Commands

| Command | Phase | Description |
|---------|-------|-------------|
| `/spec` | Inception | Create comprehensive specification |
| `/mob-elaborate` | Inception | Facilitate requirements validation |
| `/plan` | Construction | Create implementation plan |
| `/mob-construct` | Construction | Facilitate technical decisions |
| `/tasks` | Construction | Generate executable task list |
| `/bolt` | Construction | Plan and execute work cycle |
| `/context` | All | View and manage persistent context |
| `/review` | Operations | Perform comprehensive code review |
| `/pr` | Operations | Generate PR description |

### Design & Architecture Commands

| Command | Purpose | Skill Used |
|---------|---------|------------|
| `/arch-review` | Review system architecture | architecture-review |
| `/api-design` | Design REST/GraphQL/gRPC APIs | api-design |
| `/data-model` | Design database schemas | data-model-design |

### Quality & Security Commands

| Command | Purpose | Skill Used |
|---------|---------|------------|
| `/security-review` | Security vulnerability scan | security-review |
| `/perf-review` | Performance optimization review | performance-review |
| `/refactor` | Systematic code refactoring | refactoring |

### Operations Commands

| Command | Purpose | Skill Used |
|---------|---------|------------|
| `/migrate` | Plan database/code migrations | migration-planning |
| `/incident` | Production incident response | incident-response |
| `/commit` | Generate commit message | commit |

### Utility Commands

| Command | Purpose |
|---------|---------|
| `/help` | Get help with opencode |

## Agent Categories

### Requirements & Planning Agents (5)
1. **specify** - Specification creation
2. **plan** - Implementation planning
3. **breakdown** - Task generation
4. **mob-collaboration** - Team decision facilitation
5. **context-persistence** - State management

### Implementation Agents (3)
6. **test-driven-development** - TDD methodology
7. **document** - Documentation generation
8. **refactoring** - Code improvement

### Quality Assurance Agents (4)
9. **review** - Code review
10. **architecture-review** - Architecture validation
11. **security-review** - Security assessment
12. **performance-review** - Performance optimization

### Design Agents (3)
13. **api-design** - API design
14. **data-model-design** - Database design
15. **deployment-planning** - Deployment strategies

### Operations Agents (4)
16. **k8s-microservices-debug** - Kubernetes debugging
17. **migration-planning** - Migration management
18. **incident-response** - Incident handling
19. **root-cause-tracing** - Deep debugging

## Resources

See `.config/opencode/skills/` for detailed methodology guides.

See `.config/opencode/command/` for all available commands.

See `.config/opencode/templates/` for specification templates.

## References

- **AWS AI-DLC**: [AWS Blog Post](https://aws.amazon.com/blogs/)
- **Speckit**: [GitHub Spec Kit](https://github.com/github/spec-kit)
- **Opencode**: [Documentation](https://opencode.ai)

## License

MIT - Use freely in your projects.

---

**Built for:** Teams who want AI as a collaborative partner, not just a tool.  
**Philosophy:** AI proposes, humans decide, context compounds, quality wins.
