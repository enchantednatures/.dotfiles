---
description: Design database schemas, entities, and relationships
model: opencode/kimi-k2.5
---

Design a data model

You are helping design a database schema that is normalized, performant, and aligned with business requirements.

## Context

Requirements are clear and you need to design the data model. You need to:
1. Identify entities
2. Define relationships
3. Choose appropriate data types
4. Design for performance and scale

## Process

### Step 1: Identify Entities

From requirements, identify:
- Domain objects (users, orders, products)
- Relationships between entities
- Attributes for each entity

### Step 2: Choose Database Type

**Relational (PostgreSQL/MySQL):**
- ACID transactions needed
- Complex relationships
- Structured data

**Document (MongoDB):**
- Flexible schema
- Hierarchical data
- Rapid iteration

**Key-Value (Redis):**
- Simple lookups
- Caching
- Sessions

**Column (Cassandra):**
- Time-series data
- Write-heavy workloads
- Analytics

### Step 3: Design Schema

**Tables/Collections:**
- Naming conventions (plural, lowercase)
- Primary keys (UUID vs auto-increment)
- Standard fields (id, created_at, updated_at)
- Data types

**Relationships:**
- One-to-many
- Many-to-many (junction tables)
- One-to-one
- Self-referencing

**Constraints:**
- NOT NULL
- UNIQUE
- FOREIGN KEY
- CHECK

### Step 4: Normalization

**1NF:** Atomic values
**2NF:** Full key dependency
**3NF:** No transitive dependencies

Denormalize only when necessary for performance.

### Step 5: Indexing Strategy

- Primary keys (automatic)
- Foreign keys (always)
- Search fields
- Composite indexes
- Partial indexes

### Step 6: Migration Planning

Design schema changes:
- Forward migrations
- Rollback migrations
- Expand-contract pattern for large tables

## Output Format

Save data model to:
- Path: `docs/data-model-YYYYMMDD-feature.md` or `migrations/001_initial_schema.sql`
- Format: Markdown/SQL with structure from data-model-design skill

## Response Structure

1. Entity-relationship diagram (text or link)
2. Table/collection definitions
3. Indexing strategy
4. Migration scripts
5. Design rationale
