---
name: deployment-planning
description: Use when planning deployments - ensures safe, reliable, and reversible deployment strategies with proper rollback plans
---

# Deployment Planning

## Overview

Plan deployments that are safe, reliable, reversible, and minimize downtime. Good deployment practices prevent outages and enable rapid recovery.

**Core principle:** Deployments should be boring, not exciting.

## When to Use

**Always:**
- Before any production deployment
- When changing deployment strategy
- When adding new environments
- When scaling infrastructure
- When implementing CI/CD

**Never skip:**
- "It's just a small change"
- "We'll deploy directly to production"
- "Rollback is complicated"

## The Deployment Cycle

```dot
digraph deployment {
    rankdir=LR;
    plan [label="PLAN\nDefine strategy", shape=box, style=filled, fillcolor="#ffcccc"];
    prepare [label="PREPARE\nCheck readiness", shape=box, style=filled, fillcolor="#ccffcc"];
    deploy [label="DEPLOY\nExecute safely", shape=box, style=filled, fillcolor="#ccccff"];
    verify [label="VERIFY\nValidate success", shape=box, style=filled, fillcolor="#ffffcc"];
    monitor [label="MONITOR\nWatch health", shape=box, style=filled, fillcolor="#99ff99"];

    plan -> prepare -> deploy -> verify -> monitor;
    verify -> deploy [label="rollback"];
}
```

## Deployment Strategies

### 1. Rolling Deployment

**Best for:** Stateful services, gradual rollout, resource-constrained

**How it works:**
- Deploy to one instance at a time
- Wait for health check
- Move to next instance
- Old version gradually replaced

**Pros:** Simple, no extra resources
**Cons:** Rollback is slow, mixed versions during deployment

```yaml
# Kubernetes Rolling Update
strategy:
  type: RollingUpdate
  rollingUpdate:
    maxSurge: 1        # How many new pods can be created at once
    maxUnavailable: 0  # How many old pods can be unavailable
```

### 2. Blue-Green Deployment

**Best for:** Zero-downtime, easy rollback, stateless services

**How it works:**
- "Blue" = current production
- "Green" = new version (idle)
- Test green thoroughly
- Switch traffic: Blue → Green
- Keep Blue for quick rollback

**Pros:** Instant rollback, zero downtime
**Cons:** Double the resources

```yaml
# Using Kubernetes service
apiVersion: v1
kind: Service
metadata:
  name: my-app
spec:
  selector:
    version: green  # Switch from blue to green
```

### 3. Canary Deployment

**Best for:** Risk reduction, gradual rollout, A/B testing

**How it works:**
- Deploy new version to small subset (5%)
- Monitor metrics
- Gradually increase traffic (5% → 25% → 50% → 100%)
- Rollback if issues detected

**Pros:** Risk mitigation, real production testing
**Cons:** Complex to implement, longer deployment time

```yaml
# Istio Canary
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: my-app
spec:
  http:
  - route:
    - destination:
        host: my-app
        subset: v1
      weight: 90
    - destination:
        host: my-app
        subset: v2
      weight: 10
```

### 4. Feature Flags (Dark Launch)

**Best for:** Continuous deployment, gradual feature rollout

**How it works:**
- Deploy code to production (hidden)
- Enable features for specific users/groups
- Gradually increase exposure
- Instant disable if issues

**Pros:** Deploy without releasing, instant rollback
**Cons:** Code complexity, flag management

```javascript
// Feature flag example
if (featureFlags.isEnabled('new-payment-flow', userId)) {
  return newPaymentFlow();
} else {
  return oldPaymentFlow();
}
```

## Deployment Checklist

### Pre-Deployment

```markdown
## Pre-Deployment Checklist

### Code
- [ ] All tests passing (unit, integration, e2e)
- [ ] Code reviewed and approved
- [ ] No security vulnerabilities
- [ ] No TODOs or FIXMEs in changed code
- [ ] Database migrations tested
- [ ] Feature flags configured (if applicable)

### Infrastructure
- [ ] Infrastructure changes applied (Terraform/K8s)
- [ ] Resources sufficient (CPU, memory, storage)
- [ ] Database connections available
- [ ] External dependencies healthy
- [ ] SSL certificates valid

### Configuration
- [ ] Environment variables set
- [ ] Feature flags configured
- [ ] Secrets rotated (if needed)
- [ ] Third-party API keys valid
- [ ] Logging level appropriate

### Monitoring
- [ ] Alerts configured
- [ ] Dashboards ready
- [ ] Baseline metrics captured
- [ ] On-call engineer available
- [ ] Runbook updated

### Communication
- [ ] Deployment window communicated
- [ ] Stakeholders notified
- [ ] Rollback plan shared
- [ ] Communication channel established
```

### Deployment Execution

```markdown
## Deployment Execution

### Step 1: Backup
- [ ] Database backup completed
- [ ] Configuration backup
- [ ] Previous version tagged
- [ ] Rollback artifacts ready

### Step 2: Pre-Deploy Tests
- [ ] Smoke tests passing
- [ ] Health checks passing
- [ ] Dependencies responding

### Step 3: Deploy
- [ ] Deploy to staging first
- [ ] Verify staging
- [ ] Deploy to production (using chosen strategy)
- [ ] Monitor deployment progress

### Step 4: Verification
- [ ] Health checks passing
- [ ] Smoke tests passing
- [ ] Critical user journeys working
- [ ] Error rates normal
- [ ] Performance acceptable
- [ ] Business metrics healthy

### Step 5: Post-Deploy
- [ ] Remove old versions (after grace period)
- [ ] Update documentation
- [ ] Announce completion
- [ ] Monitor for 24 hours
```

## Rollback Strategy

### When to Rollback

**Immediate Rollback:**
- Error rate > threshold (e.g., 5%)
- Critical functionality broken
- Data corruption detected
- Security incident

**Planned Rollback:**
- Performance degradation
- User complaints increasing
- Business metrics dropping

### Rollback Procedures

**Blue-Green:**
```bash
# Instant rollback
kubectl patch service my-app -p '{"spec":{"selector":{"version":"blue"}}}'
```

**Rolling:**
```bash
# Gradual rollback
kubectl rollout undo deployment/my-app
# Or specify revision
kubectl rollout undo deployment/my-app --to-revision=2
```

**Canary:**
```bash
# Shift traffic back to stable
istioctl experimental traffic-shift my-app 100 v1
```

**Database Rollback:**
```bash
# Database rollbacks are hard - require reverse migration
# Always test migrations in staging first!
# Consider forward-fix instead of rollback
```

## Database Migrations

### Migration Strategy

**Expand-Contract Pattern:**
1. **Expand:** Add new columns/tables (backward compatible)
2. **Migrate:** Dual-write old and new
3. **Contract:** Remove old columns/tables

```sql
-- Step 1: Add new column
ALTER TABLE users ADD COLUMN email_normalized VARCHAR(255);

-- Step 2: Application dual-writes
-- Old code writes to 'email'
-- New code writes to both 'email' and 'email_normalized'

-- Step 3: Backfill data
UPDATE users SET email_normalized = LOWER(email) WHERE email_normalized IS NULL;

-- Step 4: Make new column required (after all data migrated)
ALTER TABLE users ALTER COLUMN email_normalized SET NOT NULL;

-- Step 5: Application only uses new column
-- (Old column can be removed later)
```

### Migration Checklist

```markdown
## Database Migration Checklist

- [ ] Migration tested in staging
- [ ] Migration is backward compatible (for rolling deploys)
- [ ] Large tables have chunked updates
- [ ] No locks on large tables during peak hours
- [ ] Rollback migration prepared
- [ ] Database backup before migration
- [ ] Migration run time estimated
- [ ] DBA approval obtained (for large migrations)
```

## Monitoring During Deployment

### Key Metrics

**System Metrics:**
- CPU usage
- Memory usage
- Disk I/O
- Network latency
- Database connections

**Application Metrics:**
- Error rate (target: < 0.1%)
- Response time (p50, p95, p99)
- Throughput (requests/sec)
- Queue depth

**Business Metrics:**
- Successful transactions
- User login rate
- Conversion rate
- Revenue (if applicable)

### Automated Rollback Triggers

```yaml
# Example: Argo Rollouts analysis
triggers:
  - metric: error-rate
    threshold: 5.0
    operator: greater-than
    rollback: true
  
  - metric: response-time-p95
    threshold: 2000
    operator: greater-than
    rollback: true
  
  - metric: success-rate
    threshold: 95.0
    operator: less-than
    rollback: true
```

## Deployment Automation

### CI/CD Pipeline

```yaml
# GitHub Actions example
name: Deploy
on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: npm test
      - name: Security scan
        run: npm audit

  deploy-staging:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to staging
        run: ./deploy.sh staging
      - name: Run smoke tests
        run: ./smoke-tests.sh staging

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy to production
        run: ./deploy.sh production
      - name: Verify deployment
        run: ./verify.sh production
      - name: Monitor for 30 min
        run: ./monitor.sh --duration=30m
```

### Infrastructure as Code

```hcl
# Terraform deployment
resource "kubernetes_deployment" "app" {
  metadata {
    name = "my-app"
  }

  spec {
    replicas = 3

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }
    }

    template {
      spec {
        container {
          image = "my-app:${var.image_tag}"
          
          readiness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }
          
          liveness_probe {
            http_get {
              path = "/health"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }
  }
}
```

## Deployment Communication

### Before Deployment

```markdown
## Deployment Announcement

**Date:** [Date]
**Time:** [Window]
**Duration:** [Expected duration]
**Impact:** [User impact, if any]
**Changes:** [Summary]
**Rollback Plan:** [Strategy]
**Contact:** [On-call engineer]
```

### During Deployment

```markdown
## Deployment Updates

**09:00:** Deployment started
**09:15:** Staging deployment complete, smoke tests passing
**09:30:** Production deployment started (Canary 10%)
**09:45:** Canary metrics healthy, increasing to 50%
**10:00:** 100% traffic on new version
**10:15:** All health checks passing, monitoring for 24h
```

### After Deployment

```markdown
## Deployment Complete

**Status:** ✅ Successful
**Duration:** 1 hour 15 minutes
**Issues:** None
**Metrics:** All green
**Next Steps:** Monitor for 24 hours

Thank you for your patience!
```

## Deployment Review

### Post-Deployment Retrospective

```markdown
## Deployment Retrospective

**Date:** [Date]
**Deployer:** [Name]
**Version:** [Version]

### What Went Well
- 
-

### What Could Be Improved
- 
-

### Metrics
- Deployment duration: [Time]
- Error rate during deploy: [Rate]
- Rollback needed? [Yes/No]
- User impact: [Description]

### Action Items
- [ ] [Improvement 1]
- [ ] [Improvement 2]
```

## Best Practices

### Do's

✅ Always have a rollback plan
✅ Test deployments in staging first
✅ Use automated smoke tests
✅ Monitor during and after deployment
✅ Communicate with team/stakeholders
✅ Deploy during low-traffic hours
✅ Keep deployments small and frequent
✅ Use feature flags for risky changes
✅ Have database rollback strategy
✅ Tag releases clearly

### Don'ts

❌ Deploy without tests passing
❌ Deploy without rollback plan
❌ Skip staging deployment
❌ Deploy during peak hours
❌ Make multiple big changes at once
❌ Forget to monitor after deploy
❌ Deploy without notifications
❌ Skip database migration testing
❌ Deploy on Friday (unless automated)
❌ Keep failed deployments running

## Integration with AI-DLC

### Construction Phase
- Define deployment strategy
- Set up CI/CD pipeline
- Configure monitoring
- Create runbooks

### Operations Phase
- Execute deployments
- Monitor health
- Handle rollbacks
- Continuous improvement

## Final Rule

```
Good deployment:
- Planned (not ad-hoc)
- Tested (staging first)
- Monitored (health checks)
- Reversible (rollback ready)
- Communicated (team knows)

Deploy without planning? You're gambling with production.
```

No exceptions without your human partner's permission.
