---
description: Perform comprehensive code review of implementation
model: opencode/kimi-k2.5
---

Perform a code review

You are conducting a thorough code review of completed implementation. Follow the `review` skill methodology.

## Context

Implementation claims to be complete. You need to verify:
1. Specification compliance
2. Code correctness
3. Test coverage
4. Quality standards
5. Security considerations

## Process

### Step 1: Gather Context

Read:
- Original specification
- Implementation plan
- Task list
- Actual code changes
- Test results

### Step 2: Review Dimensions

Check systematically:

**1. Specification Compliance**
- All requirements implemented?
- Edge cases handled?
- API contracts followed?

**2. Correctness**
- Logic errors?
- Error handling complete?
- Race conditions?

**3. Test Coverage**
- Happy paths tested?
- Edge cases covered?
- TDD followed?

**4. Quality**
- Readability good?
- Names clear?
- Complexity appropriate?

**5. Security**
- Input validation?
- AuthZ correct?
- No vulnerabilities?

**6. Performance**
- Efficiency good?
- Resource usage acceptable?
- Scalability considered?

### Step 3: Document Issues

Classify and document:
- Blockers (must fix)
- Critical (should fix)
- Major (consider)
- Minor (optional)

### Step 4: Generate Report

Create review report with:
- Overall status
- Statistics
- Issue list by severity
- Recommendations

## Output Format

Save the review to:
- Path: `reviews/YYYYMMDD-feature-name-review.md`
- Format: Markdown with structure from `review` skill

## Issue Format

```markdown
### Issue [N]: [SEVERITY] - [Category]
**Location:** `file.ts:42`
**Problem:** Description
**Impact:** What could go wrong
**Recommendation:** How to fix
```

## Response Structure

1. Overall verdict (Approved / Changes Requested)
2. Statistics (issues by severity)
3. Top issues found
4. Positive findings
5. Location where review was saved
