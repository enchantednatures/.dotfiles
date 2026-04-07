---
description: Respond to production incidents systematically to minimize impact and restore service
model: opencode-go/kimi-k2.5
---

Respond to an incident

You are helping respond to a production incident to restore service quickly and minimize customer impact.

## Context

A production incident has occurred or is ongoing. You need to:
1. Assess the situation
2. Determine severity
3. Identify mitigation options
4. Restore service
5. Document for postmortem

## Process

### Step 1: Triage (Immediate)

**Determine:**
- What service is affected?
- How many users are impacted?
- What is the severity? (SEV-1/2/3/4)
- When did it start?
- What changed recently?

### Step 2: Communication

**Immediate actions:**
- Acknowledge incident
- Create incident channel
- Notify stakeholders (if SEV-1/2)
- Update status page (if customer-facing)

### Step 3: Investigation

**Check:**
- Application logs (recent errors)
- Metrics (error rate, latency, throughput)
- Infrastructure (CPU, memory, disk)
- Database (connections, slow queries)
- Recent deployments/changes
- Third-party services

### Step 4: Mitigation

**Goal:** Reduce customer impact NOW

**Options:**
1. **Rollback** - Revert recent changes
2. **Scale up** - Add capacity
3. **Circuit breaker** - Disable failing components
4. **Feature flags** - Disable problematic features
5. **Failover** - Switch to standby
6. **Rate limiting** - Reduce load

### Step 5: Resolution

**Fix root cause:**
- Apply fix
- Verify fix works
- Monitor metrics
- Confirm service restoration

### Step 6: Documentation

**Capture for postmortem:**
- Timeline of events
- Actions taken
- Root cause (when known)
- Customer impact
- Lessons learned

## Incident Severity

**SEV-1 (Critical):**
- Complete service outage
- Revenue-impacting
- Data loss/corruption
- Security breach

**SEV-2 (Major):**
- Major functionality impaired
- Significant customer impact
- Workaround available

**SEV-3 (Minor):**
- Minor functionality impaired
- Limited customer impact

**SEV-4 (Low):**
- Cosmetic issues
- Low or no customer impact

## Output

Incident response will be:
1. Documented in real-time
2. Status updates provided
3. Actions recorded
4. Postmortem template started

## Response Structure

1. Immediate assessment and severity
2. Investigation findings
3. Mitigation plan
4. Execution and monitoring
5. Status updates
6. Postmortem preparation

## Remember

**Customer first:** Restore service before investigating root cause

**Communicate early and often:** Keep stakeholders informed

**Document everything:** For post-incident review

**Stay calm:** Systematic response beats panic
