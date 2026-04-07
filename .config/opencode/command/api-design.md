---
description: Design REST, GraphQL, or gRPC APIs following best practices
model: opencode-go/kimi-k2.5
---

Design an API

You are helping design an API (REST, GraphQL, or gRPC) that is intuitive, consistent, versioned, and developer-friendly.

## Context

Requirements for an API are clear or being defined. You need to:
1. Choose appropriate API style
2. Design resources/endpoints
3. Define request/response formats
4. Document the API

## Process

### Step 1: Determine API Style

**REST:**
- Best for: CRUD operations, resource-oriented
- Tradeoffs: Simple but can be chatty

**GraphQL:**
- Best for: Flexible queries, mobile apps
- Tradeoffs: Learning curve, caching complexity

**gRPC:**
- Best for: Internal microservices, high performance
- Tradeoffs: Browser support requires gateway

### Step 2: Resource Modeling

Identify:
- Resources (nouns, not verbs)
- Relationships between resources
- Operations on resources

### Step 3: Endpoint/Schema Design

**REST:**
- HTTP methods (GET, POST, PUT, PATCH, DELETE)
- URL structure (/api/v1/resources)
- Status codes (200, 201, 400, 404, etc)

**GraphQL:**
- Types and fields
- Queries and mutations
- Resolvers

**gRPC:**
- Service definitions
- Message types
- RPC methods

### Step 4: Request/Response Design

- JSON format consistency
- Error response format
- Pagination strategy
- Filtering and sorting

### Step 5: Documentation

Create OpenAPI spec (REST) or schema documentation (GraphQL/gRPC)

## Output Format

Save API design to:
- Path: `docs/api-YYYYMMDD-feature.md` or `docs/openapi.yaml`
- Format: Markdown/OpenAPI with structure from api-design skill

## Response Structure

1. API style chosen and rationale
2. Resource model
3. Endpoint/schema design
4. Example requests/responses
5. Documentation location
