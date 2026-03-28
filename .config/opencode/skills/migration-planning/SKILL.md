---
name: migration-planning
description: Use when planning database migrations, code migrations, or infrastructure migrations - ensures safe, reversible migrations with minimal downtime
---

# Migration Planning

## Overview

Plan and execute migrations safely. Migrations are high-risk operations that require careful planning, testing, and rollback strategies.

**Core principle:** Migrations should be reversible, tested, and non-breaking.

## When to Use

**Always:**
- Database schema changes
- Data format migrations
- Technology stack migrations (e.g., language/framework)
- Infrastructure migrations (cloud provider, Kubernetes)
- Legacy system modernization

**Never skip:**
- "We'll just run it in production"
- "Rollback is too hard"
- "It's just a simple change"

## Migration Types

### 1. Database Migrations

**Schema Migrations:**
```sql
-- Forward migration: 001_add_user_status.sql
ALTER TABLE users ADD COLUMN status VARCHAR(20) DEFAULT 'active';

-- Rollback migration: 001_add_user_status_rollback.sql
ALTER TABLE users DROP COLUMN status;
```

**Data Migrations:**
```sql
-- Backfill data safely (chunked)
UPDATE users 
SET status = 'active' 
WHERE id IN (
  SELECT id FROM users 
  WHERE status IS NULL 
  LIMIT 1000
);
-- Run in batches until complete
```

**Expand-Contract Pattern:**
1. **Expand:** Add new column/table (backward compatible)
2. **Migrate:** Dual-write, backfill
3. **Contract:** Remove old (after verification)

### 2. Code Migrations

**Gradual Migration:**
```typescript
// Feature flags enable gradual migration
if (featureFlags.isEnabled('new-payment-service')) {
  return newPaymentService.process(order);
} else {
  return legacyPaymentService.process(order);
}
```

**Strangler Fig Pattern:**
- Gradually replace old system
- Route traffic incrementally
- Keep old system running until new is complete

### 3. Infrastructure Migrations

**Cloud Migration:**
1. Pilot with non-critical workload
2. Parallel run (dual-write)
3. Gradual traffic shift
4. Decommission old infrastructure

**Kubernetes Migration:**
1. Containerize applications
2. Deploy to K8s alongside VMs
3. Shift traffic via load balancer
4. Remove VMs after stability

## Migration Planning Process

### Step 1: Assessment

```markdown
## Migration Assessment

### Current State
- [ ] Current system documented
- [ ] Data volumes measured
- [ ] Dependencies mapped
- [ ] Performance baseline captured
- [ ] Known issues documented

### Target State
- [ ] Target architecture defined
- [ ] Capacity requirements
- [ ] Performance targets
- [ ] Feature parity confirmed

### Risk Assessment
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Data loss | Low | Critical | Backup + dry run |
| Downtime | Medium | High | Blue-green deploy |
| Rollback failure | Low | High | Test rollback |
| Performance degradation | Medium | Medium | Load test |

### Timeline
- Preparation: [X] days
- Testing: [Y] days
- Migration: [Z] hours
- Validation: [A] hours
```

### Step 2: Preparation

```markdown
## Migration Preparation

### Backups
- [ ] Full database backup completed
- [ ] Configuration backup
- [ ] Code backup (tag current version)
- [ ] Test restore from backup

### Testing
- [ ] Test migration in staging
- [ ] Performance testing completed
- [ ] Rollback tested
- [ ] Data integrity verified

### Communication
- [ ] Stakeholders notified
- [ ] Maintenance window scheduled
- [ ] Team availability confirmed
- [ ] Escalation path defined

### Tools
- [ ] Migration scripts ready
- [ ] Monitoring dashboards prepared
- [ ] Rollback scripts tested
- [ ] Runbook updated
```

### Step 3: Execution

```markdown
## Migration Execution

### Pre-Migration (T-30 min)
- [ ] Final backup completed
- [ ] Health checks passing
- [ ] Monitoring active
- [ ] Team in war room
- [ ] Communication channel open

### Migration (T-0)
- [ ] Migration started
- [ ] Progress monitored
- [ ] Errors logged
- [ ] Duration tracked

### Post-Migration (T+X)
- [ ] Health checks verify success
- [ ] Data integrity checked
- [ ] Performance validated
- [ ] Applications tested
- [ ] Users can access system
```

### Step 4: Validation

```markdown
## Migration Validation

### Functional Validation
- [ ] Core features working
- [ ] Edge cases tested
- [ ] Integration tests passing
- [ ] User acceptance complete

### Data Validation
- [ ] Record counts match
- [ ] Sample data verified
- [ ] Referential integrity checked
- [ ] Audit logs reviewed

### Performance Validation
- [ ] Response times acceptable
- [ ] Throughput maintained
- [ ] Resource usage normal
- [ ] No memory leaks

### Monitoring
- [ ] Error rates normal
- [ ] No unusual patterns
- [ ] All alerts resolved
- [ ] Metrics healthy for 24h
```

## Database Migration Strategies

### Zero-Downtime Migrations

**Online Schema Change (PostgreSQL):**
```sql
-- Use pg_repack or similar for large tables
-- Creates new table with changes, syncs data, swaps
```

**Expand-Contract Detailed:**

```sql
-- Phase 1: Expand (deploy 1)
-- Add new column, nullable
ALTER TABLE users ADD COLUMN email_normalized VARCHAR(255);

-- Phase 2: Dual-write (deploy 2)
-- Application writes to both columns
-- Backfill existing data in batches
UPDATE users 
SET email_normalized = LOWER(email)
WHERE id BETWEEN 1 AND 1000;

-- Phase 3: Read from new (deploy 3)
-- Application reads from new column
-- Validate data integrity

-- Phase 4: Contract (deploy 4)
-- Make new column required
ALTER TABLE users ALTER COLUMN email_normalized SET NOT NULL;
-- Remove old column (after grace period)
-- ALTER TABLE users DROP COLUMN email;
```

### Migration Scripts Template

```sql
-- Forward migration: 20250115_add_user_preferences.sql

-- Start transaction
BEGIN;

-- Create new table
CREATE TABLE user_preferences (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    preferences JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE (user_id)
);

-- Create index
CREATE INDEX idx_user_prefs_user_id ON user_preferences(user_id);

-- Backfill data (if migrating from columns)
INSERT INTO user_preferences (user_id, preferences)
SELECT id, jsonb_build_object(
    'theme', theme,
    'notifications', notifications_enabled,
    'language', language
)
FROM users
WHERE theme IS NOT NULL 
   OR notifications_enabled IS NOT NULL
   OR language IS NOT NULL;

-- Verify counts
DO $$
DECLARE
    source_count INT;
    target_count INT;
BEGIN
    SELECT COUNT(*) INTO source_count FROM users 
    WHERE theme IS NOT NULL OR notifications_enabled IS NOT NULL;
    
    SELECT COUNT(*) INTO target_count FROM user_preferences;
    
    IF source_count != target_count THEN
        RAISE EXCEPTION 'Migration verification failed: % source vs % target', 
            source_count, target_count;
    END IF;
END $$;

COMMIT;
```

```sql
-- Rollback migration: 20250115_add_user_preferences_rollback.sql

BEGIN;

-- Verify it's safe to rollback
DO $$
DECLARE
    app_version TEXT;
BEGIN
    -- Check if new code is still deployed
    SELECT current_setting('application.version') INTO app_version;
    IF app_version >= '2.0.0' THEN
        RAISE EXCEPTION 'Cannot rollback: New application version is still deployed';
    END IF;
END $$;

-- Restore columns if needed
ALTER TABLE users ADD COLUMN theme VARCHAR(50);
ALTER TABLE users ADD COLUMN notifications_enabled BOOLEAN;
ALTER TABLE users ADD COLUMN language VARCHAR(10);

-- Migrate data back
UPDATE users u
SET 
    theme = p.preferences->>'theme',
    notifications_enabled = (p.preferences->>'notifications')::boolean,
    language = p.preferences->>'language'
FROM user_preferences p
WHERE p.user_id = u.id;

-- Drop new table
DROP TABLE IF EXISTS user_preferences;

COMMIT;
```

## Data Migration Best Practices

### Chunking Large Migrations

```sql
-- Process in batches to avoid locks
DO $$
DECLARE
    batch_size INT := 1000;
    total_updated INT := 0;
    batch_updated INT;
BEGIN
    LOOP
        UPDATE users 
        SET status = 'migrated'
        WHERE id IN (
            SELECT id FROM users 
            WHERE status = 'pending' 
            LIMIT batch_size
        );
        
        GET DIAGNOSTICS batch_updated = ROW_COUNT;
        total_updated := total_updated + batch_updated;
        
        -- Log progress
        RAISE NOTICE 'Migrated % records (total: %)', batch_updated, total_updated;
        
        -- Sleep to reduce load
        PERFORM pg_sleep(0.1);
        
        EXIT WHEN batch_updated = 0;
    END LOOP;
END $$;
```

### Verification Queries

```sql
-- Count verification
SELECT 'Source' as source, COUNT(*) as count FROM legacy_table
UNION ALL
SELECT 'Target', COUNT(*) FROM new_table;

-- Sample data verification
SELECT l.id, l.name, n.name
FROM legacy_table l
JOIN new_table n ON l.id = n.id
WHERE l.name != n.name
LIMIT 10;

-- Orphan check
SELECT COUNT(*) as orphan_count
FROM legacy_table l
LEFT JOIN new_table n ON l.id = n.id
WHERE n.id IS NULL;
```

## Code Migration Strategies

### Strangler Fig Pattern

```typescript
// Gradually migrate from old to new
class FeatureMigration {
  private oldService: LegacyService;
  private newService: ModernService;
  private migrationPercent: number = 0;

  async process(request: Request): Promise<Response> {
    // Route based on migration percentage
    if (Math.random() * 100 < this.migrationPercent) {
      try {
        const result = await this.newService.process(request);
        // Compare with old service (shadow mode)
        this.compareResults(request, result);
        return result;
      } catch (error) {
        // Fallback to old service
        return this.oldService.process(request);
      }
    }
    
    return this.oldService.process(request);
  }

  increaseMigration(percent: number) {
    this.migrationPercent = Math.min(100, percent);
  }
}
```

### Feature Flags for Migration

```typescript
// Use feature flags for gradual rollout
const userPercentage = getUserFlag('new-search-percentage', 0);

if (shouldUseNewSearch(user.id, userPercentage)) {
  return newSearchService.search(query);
} else {
  return legacySearchService.search(query);
}

function shouldUseNewSearch(userId: string, percentage: number): boolean {
  // Consistent hashing for same user experience
  const hash = hashUserId(userId);
  return (hash % 100) < percentage;
}
```

## Migration Checklist

### Before Migration

- [ ] Migration tested in staging
- [ ] Rollback tested
- [ ] Backup completed and verified
- [ ] Monitoring configured
- [ ] Runbook ready
- [ ] Communication sent
- [ ] Maintenance window scheduled
- [ ] Team assembled
- [ ] Rollback criteria defined

### During Migration

- [ ] Progress monitored
- [ ] Duration tracked
- [ ] Errors logged
- [ ] Communication updated
- [ ] Rollback ready if needed

### After Migration

- [ ] Health checks passing
- [ ] Data verified
- [ ] Performance acceptable
- [ ] No increase in errors
- [ ] Users not affected
- [ ] Documentation updated
- [ ] Retrospective scheduled

## Migration Failure Recovery

### Immediate Rollback

```bash
# If automated rollback available
./rollback-migration.sh

# If manual rollback needed
# 1. Stop application
# 2. Restore database from backup
# 3. Deploy previous code version
# 4. Verify functionality
# 5. Communicate status
```

### Post-Incident Actions

1. **Assess impact**
   - Data affected?
   - Users affected?
   - Duration of issue?

2. **Root cause analysis**
   - What went wrong?
   - Why didn't we catch it?

3. **Improvements**
   - Test coverage gaps
   - Process improvements
   - Tool improvements

## Best Practices

### Do's

✅ Test migrations thoroughly in staging
✅ Have a tested rollback plan
✅ Make migrations idempotent (can run multiple times safely)
✅ Use transactions where possible
✅ Migrate in small batches for large datasets
✅ Monitor during and after migration
✅ Communicate with stakeholders
✅ Keep old system running until new is verified
✅ Document everything

### Don'ts

❌ Run untested migrations in production
❌ Skip backups
❌ Migrate during peak hours
❌ Do large migrations in one transaction
❌ Forget to test rollback
❌ Ignore performance impact
❌ Skip verification
❌ Delete old system immediately

## Integration with AI-DLC

### Construction Phase
- Database migrations
- Code migrations
- Technology upgrades

### Operations Phase
- Infrastructure migrations
- Cloud migrations
- Legacy modernization

## Final Rule

```
Good migration:
- Planned (not ad-hoc)
- Tested (staging first)
- Reversible (rollback ready)
- Monitored (watch closely)
- Verified (data integrity)

Migrate without planning? You're risking production.
```

No exceptions without your human partner's permission.
