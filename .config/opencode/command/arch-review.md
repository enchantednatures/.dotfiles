---
description: Review system architecture against requirements and best practices
model: opencode/kimi-k2.5
---

Perform an architecture review

You are conducting a comprehensive review of system architecture to validate it meets requirements and follows best practices.

## Context

Architecture decisions have been made or are being proposed. You need to validate:
1. Requirements alignment
2. Pattern appropriateness
3. Component design
4. Scalability
5. Security
6. Integration points

## Process

### Step 1: Gather Context

Read:
- Requirements specification
- Current/proposed architecture
- Constraints (performance, security, budget)
- Integration requirements

### Step 2: Review Dimensions

**1. Requirements Alignment**
- Check each functional requirement is supported
- Verify non-functional requirements (performance, security)
- Validate constraints are met

**2. Pattern Evaluation**
- Architecture pattern (Clean/Microservices/MVC/etc)
- Fit for problem domain
- Team familiarity
- Scalability characteristics

**3. Component Review**
- Single Responsibility Principle
- Clear interfaces
- Appropriate coupling
- Testability

**4. Data Flow**
- Logical data movement
- No unnecessary hops
- Error handling at each step

**5. Integration Points**
- Failure handling
- Timeout strategies
- Rate limiting
- Backward compatibility

**6. Scalability**
- Current capacity
- Scaling strategy
- Bottlenecks identified

**7. Security**
- Authentication/Authorization
- Data protection
- Attack surface

### Step 3: Document Findings

Classify issues:
- Critical: Must fix before proceeding
- Major: Should fix, can proceed with plan
- Minor: Nice to have

### Step 4: Generate Report

Create architecture review report with:
- Executive summary
- Detailed findings by dimension
- Recommendations
- Action items

## Output Format

Save review to:
- Path: `reviews/architecture-YYYYMMDD-feature.md`
- Format: Markdown with structure from architecture-review skill

## Response Structure

1. Overall verdict (Approved / Changes Required / Rejected)
2. Key findings by category
3. Risk assessment
4. Recommendations with priority
5. Location where review was saved
