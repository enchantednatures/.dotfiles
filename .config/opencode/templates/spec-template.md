# Specification: [Feature Name]

**Date:** YYYY-MM-DD  
**Author:** [Name]  
**Status:** Draft / In Review / Approved  
**Priority:** High / Medium / Low

---

## Overview

One-paragraph description of what this feature does and why it matters.

**Problem Statement:**  
Describe the problem being solved.

**Proposed Solution:**  
Brief description of the approach.

## Goals

- [ ] Specific, measurable objective 1
- [ ] Specific, measurable objective 2
- [ ] Specific, measurable objective 3

## Non-Goals

Explicitly out of scope:
- Feature not included 1
- Feature not included 2

## User Stories

### Story 1: [Title]
**As a** [type of user]  
**I want** [some goal]  
**So that** [some reason]

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2

### Story 2: [Title]
...

## Functional Requirements

### Requirement 1: [Name]
**Given** [context]  
**When** [action]  
**Then** [expected result]

**Edge Cases:**
- Edge case 1: [handling]
- Edge case 2: [handling]

### Requirement 2: [Name]
...

## API/Interface Specification

### Endpoint 1: [Name]

**Method:** `GET|POST|PUT|DELETE`  
**Path:** `/api/v1/...`

**Authentication:** Required / Optional

**Request:**
```json
{
  "field1": "type",
  "field2": "type"
}
```

**Success Response (200):**
```json
{
  "id": "uuid",
  "status": "created"
}
```

**Error Responses:**
- `400 Bad Request`: Invalid input
- `401 Unauthorized`: Authentication required
- `403 Forbidden`: Insufficient permissions
- `404 Not Found`: Resource not found
- `409 Conflict`: Resource already exists
- `500 Server Error`: Internal error

## Technical Constraints

### Performance
- Must support X concurrent users
- Response time < Y ms at p95
- Throughput > Z requests/sec

### Security
- Input validation required
- Rate limiting: X requests per minute
- Data encryption: [in transit/at rest]

### Compatibility
- Browser support: [list]
- API versioning: [strategy]
- Backward compatibility: [requirements]

## Data Model

```typescript
interface Entity {
  id: string;           // UUID
  field1: string;       // Description
  field2: number;       // Description
  createdAt: Date;      // Timestamp
  updatedAt: Date;      // Timestamp
}
```

## Open Questions

1. [Question that needs resolution]
2. [Another question]

## Dependencies

- [ ] Dependency 1: [status]
- [ ] Dependency 2: [status]

## Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [Strategy] |

## Success Metrics

- [ ] Metric 1: Target value
- [ ] Metric 2: Target value

## Appendix

### References
- [Link 1]
- [Link 2]

### Notes
- Additional context or decisions
