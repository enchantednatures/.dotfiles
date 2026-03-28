---
description: Generate a comprehensive PR description from specification and implementation
model: opencode/kimi-k2.5
---

Generate a pull request description

You are creating a comprehensive PR description that summarizes the work done. This helps reviewers understand the context and scope.

## Context

A feature has been implemented and reviewed. You need to create a PR description that:
1. Summarizes what was built
2. References the specification
3. Lists changes made
4. Documents testing
5. Notes any deployment considerations

## Process

### Step 1: Gather Information

Read:
- Original specification
- Implementation plan
- Task list (showing what was done)
- Code changes (diff)
- Review report

### Step 2: Summarize

Create sections:
- **Summary**: One-paragraph overview
- **Related Spec**: Link to PRD
- **Changes**: List of files/components changed
- **Testing**: What tests were added/run
- **Checklist**: Pre-merge verification

### Step 3: Write Description

Format as markdown suitable for GitHub/GitLab.

## PR Description Template

```markdown
## Summary

Brief description of what this PR accomplishes and why.

## Related Specification

See: [Link to spec](specs/YYYYMMDD-feature-name.md)

## Changes Made

### New Components
- `src/services/feature.ts` - Core service implementation
- `src/types/feature.ts` - Type definitions
- `tests/feature.test.ts` - Unit tests

### Modified Components
- `src/api/routes.ts` - Added new endpoints
- `src/config/app.ts` - Updated configuration

### Dependencies
- Added: `package-name@version`
- Updated: `other-package@version`

## Testing

### Unit Tests
- [x] Core functionality: 15 tests, 100% coverage
- [x] Edge cases: 8 tests
- [x] Error handling: 5 tests

### Integration Tests
- [x] API endpoint tests
- [x] Database integration tests

### Manual Testing
- [ ] Tested locally
- [ ] Verified in staging

## Deployment Notes

- [ ] Database migration required
- [ ] Environment variables updated
- [ ] Feature flag needed

## Checklist

- [x] Code follows style guidelines
- [x] Tests pass (unit, integration, e2e)
- [x] Documentation updated
- [x] Self-review completed
- [x] Code review approved
- [x] No console errors
- [x] No security vulnerabilities

## Screenshots / Demo

[If applicable]
```

## Output

The PR description will be:
1. Displayed to the user
2. Ready to copy into GitHub/GitLab
3. Linked to relevant specs/plans

## Response Structure

1. PR summary
2. Full markdown description (ready to use)
3. Files to include in PR
4. Any special notes
