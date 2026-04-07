---
description: Plan and execute safe database, code, or infrastructure migrations
model: opencode-go/kimi-k2.5
---

Plan a migration

You are helping plan a safe migration (database, code, or infrastructure) with minimal risk and downtime.

## Context

A migration is needed. You need to:
1. Assess current and target state
2. Identify risks
3. Plan migration strategy
4. Create rollback plan
5. Ensure safety

## Migration Types

### Database Migrations
- Schema changes (add/remove columns, tables)
- Data migrations (backfill, transform)
- Index changes

### Code Migrations
- Language/framework upgrades
- API changes
- Architecture migrations (monolith → microservices)

### Infrastructure Migrations
- Cloud provider migration
- Kubernetes migration
- Database engine migration

## Process

### Step 1: Assessment

**Current State:**
- Document current system
- Measure data volumes
- Map dependencies
- Identify constraints

**Target State:**
- Define desired architecture
- Capacity requirements
- Performance targets

### Step 2: Strategy Selection

**Options:**
- **Big Bang:** All at once (higher risk, faster)
- **Incremental:** Step by step (lower risk, slower)
- **Dual-Write:** Write to both old and new
- **Strangler Fig:** Gradually replace old system

### Step 3: Migration Planning

**Preparation:**
- [ ] Backup strategy
- [ ] Testing plan
- [ ] Rollback plan
- [ ] Monitoring setup
- [ ] Communication plan
- [ ] Timeline

### Step 4: Script Creation

**Database:**
- Forward migration script
- Rollback migration script
- Verification queries
- Chunking strategy for large tables

**Code:**
- Feature flags for gradual rollout
- Backward compatibility code
- Rollback capability

### Step 5: Testing

- Test in staging
- Test rollback
- Performance testing
- Data integrity verification

## Key Principles

**Expand-Contract Pattern:**
1. Expand: Add new structure (backward compatible)
2. Migrate: Dual-write, backfill
3. Contract: Remove old structure

**Safety Rules:**
- Always have rollback plan
- Test migrations in staging
- Make changes backward compatible
- Migrate in small batches
- Verify at each step

## Output Format

Migration plan saved to:
- Path: `plans/migration-YYYYMMDD-name.md`
- Include: Strategy, scripts, timeline, rollback plan

## Response Structure

1. Migration type and scope
2. Risk assessment
3. Chosen strategy
4. Step-by-step plan
5. Rollback procedure
6. Testing checklist
