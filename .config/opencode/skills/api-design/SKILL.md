---
name: api-design
description: Use when designing REST, GraphQL, or gRPC APIs - ensures consistent, well-designed interfaces that follow best practices and standards
---

# API Design

## Overview

Design APIs that are intuitive, consistent, versioned, and developer-friendly. Good APIs are the contract between systems.

**Core principle:** APIs are forever - design them right the first time.

## When to Use

**Always:**
- Creating new APIs
- Modifying existing APIs
- Adding endpoints
- Designing integrations
- Creating public APIs

**Never skip:**
- "It's just internal"
- "We'll add versioning later"
- "It's obvious how it works"

## The API Design Cycle

```dot
digraph api_design {
    rankdir=LR;
    requirements [label="REQUIREMENTS\nDefine needs", shape=box, style=filled, fillcolor="#ffcccc"];
    model [label="MODEL\nDesign resources", shape=box, style=filled, fillcolor="#ccffcc"];
    endpoints [label="ENDPOINTS\nDefine operations", shape=box, style=filled, fillcolor="#ccccff"];
    spec [label="SPEC\nDocument API", shape=box, style=filled, fillcolor="#ffffcc"];
    validate [label="VALIDATE\nReview design", shape=box, style=filled, fillcolor="#99ff99"];

    requirements -> model -> endpoints -> spec -> validate;
    validate -> model [label="iterate"];
}
```

## API Style Selection

### REST (Representational State Transfer)
**Best for:** CRUD operations, resource-oriented, broad adoption
**Tradeoffs:** Simple but can be chatty

### GraphQL
**Best for:** Flexible queries, mobile apps, reducing round trips
**Tradeoffs:** Learning curve, caching complexity

### gRPC
**Best for:** Internal microservices, high performance, type safety
**Tradeoffs:** Browser support requires gateway

### WebSocket
**Best for:** Real-time, bidirectional communication
**Tradeoffs:** Connection management complexity

### Webhook
**Best for:** Event-driven, async notifications
**Tradeoffs:** Reliability challenges

## REST API Design

### Resource Naming

**Nouns, not verbs:**
```
✅ GET /users
✅ GET /users/123
✅ POST /users

❌ GET /getUsers
❌ GET /fetchUserData
❌ POST /createUser
```

**Plural nouns:**
```
✅ /users
✅ /orders
✅ /products

❌ /user
❌ /order
```

**Hierarchy for relationships:**
```
✅ /users/123/orders
✅ /orders/456/items

❌ /userOrders/123
❌ /orderItems/456
```

### HTTP Methods

| Method | Usage | Idempotent | Safe |
|--------|-------|------------|------|
| GET | Retrieve resource | Yes | Yes |
| POST | Create resource | No | No |
| PUT | Full update | Yes | No |
| PATCH | Partial update | No | No |
| DELETE | Remove resource | Yes | No |
| HEAD | Get headers only | Yes | Yes |
| OPTIONS | Get capabilities | Yes | Yes |

### Response Codes

**Success (2xx):**
- 200 OK - Success
- 201 Created - Resource created
- 202 Accepted - Async processing started
- 204 No Content - Success, no body

**Client Error (4xx):**
- 400 Bad Request - Invalid input
- 401 Unauthorized - Authentication required
- 403 Forbidden - Insufficient permissions
- 404 Not Found - Resource doesn't exist
- 409 Conflict - Resource conflict
- 422 Unprocessable - Validation failed
- 429 Too Many Requests - Rate limited

**Server Error (5xx):**
- 500 Internal Error - Unexpected error
- 502 Bad Gateway - Upstream error
- 503 Service Unavailable - Temporary issue
- 504 Gateway Timeout - Upstream timeout

### Request/Response Format

**JSON Format:**
```json
{
  "id": "uuid",
  "name": "string",
  "createdAt": "2025-01-15T10:30:00Z",
  "metadata": {
    "version": "1.0",
    "source": "api"
  }
}
```

**Consistent Structure:**
```json
{
  "data": { /* resource */ },
  "meta": {
    "page": 1,
    "perPage": 20,
    "total": 100
  },
  "links": {
    "self": "/api/users/123",
    "next": "/api/users?page=2",
    "prev": null
  }
}
```

### Pagination

**Offset-based:**
```
GET /users?page=2&per_page=20
```

**Cursor-based (preferred for large datasets):**
```
GET /users?cursor=abc123&limit=20
```

Response:
```json
{
  "data": [...],
  "pagination": {
    "cursor": "abc123",
    "nextCursor": "def456",
    "hasMore": true
  }
}
```

### Filtering & Sorting

**Filtering:**
```
GET /users?status=active&role=admin
GET /orders?created_after=2025-01-01
GET /products?price_min=10&price_max=100
```

**Sorting:**
```
GET /users?sort=-created_at,name
# -created_at = descending
# name = ascending
```

**Field Selection:**
```
GET /users?fields=id,name,email
```

### Error Responses

**Consistent error format:**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request validation failed",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address",
        "code": "INVALID_EMAIL"
      }
    ],
    "requestId": "req-123-456",
    "timestamp": "2025-01-15T10:30:00Z"
  }
}
```

## GraphQL API Design

### Schema Design

**Types:**
```graphql
type User {
  id: ID!
  email: String!
  name: String
  orders: [Order!]!
  createdAt: DateTime!
}

type Order {
  id: ID!
  user: User!
  items: [OrderItem!]!
  total: Float!
  status: OrderStatus!
}

enum OrderStatus {
  PENDING
  PROCESSING
  SHIPPED
  DELIVERED
  CANCELLED
}
```

**Queries:**
```graphql
type Query {
  user(id: ID!): User
  users(
    filter: UserFilter
    sort: UserSort
    pagination: PaginationInput
  ): UserConnection!
  
  orders(userId: ID!): [Order!]!
}

input UserFilter {
  status: UserStatus
  createdAfter: DateTime
  emailContains: String
}
```

**Mutations:**
```graphql
type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!
  updateUser(id: ID!, input: UpdateUserInput!): UpdateUserPayload!
  deleteUser(id: ID!): DeleteUserPayload!
}

input CreateUserInput {
  email: String!
  name: String
  password: String!
}

type CreateUserPayload {
  user: User
  errors: [UserError!]
}
```

### Best Practices

- Use non-null types (`!`) carefully
- Provide pagination for lists
- Implement DataLoader for N+1
- Document deprecation with @deprecated

## API Versioning

### URL Versioning (Recommended)
```
/api/v1/users
/api/v2/users
```

### Header Versioning
```
Accept: application/vnd.api+json;version=2
```

### Versioning Strategy

**Breaking changes require new version:**
- Removing fields
- Changing field types
- Changing behavior
- Removing endpoints

**Non-breaking changes (same version):**
- Adding fields
- Adding endpoints
- Adding optional parameters
- Performance improvements

## API Documentation

### OpenAPI (Swagger) Specification

```yaml
openapi: 3.0.0
info:
  title: User API
  version: 1.0.0
  description: API for managing users

paths:
  /users:
    get:
      summary: List users
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
      responses:
        '200':
          description: List of users
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/User'

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        name:
          type: string
```

### Documentation Best Practices

- Interactive documentation (Swagger UI)
- Request/response examples
- Error scenarios documented
- Authentication requirements clear
- Rate limits specified
- Code samples in multiple languages

## API Security

### Authentication

**API Keys:**
```
Authorization: Bearer api-key-here
```

**OAuth 2.0:**
```
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```

**JWT:**
- Short expiration (15-30 min)
- Refresh token rotation
- Secure claims (no sensitive data)

### Rate Limiting

**Headers:**
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

**Response when limited:**
```
429 Too Many Requests
Retry-After: 3600
```

### Input Validation

- Validate at API gateway
- Schema validation (JSON Schema, protobuf)
- Size limits (request body, files)
- Content-Type validation
- SQL injection prevention
- XSS prevention

## API Review Checklist

### Design Review
- [ ] Resource naming consistent (nouns, plural)
- [ ] HTTP methods used correctly
- [ ] Status codes appropriate
- [ ] Error format consistent
- [ ] Pagination implemented
- [ ] Filtering/sorting supported
- [ ] Versioning strategy defined

### Security Review
- [ ] Authentication required where needed
- [ ] Authorization checks present
- [ ] Rate limiting implemented
- [ ] Input validation comprehensive
- [ ] Sensitive data not exposed
- [ ] HTTPS enforced

### Documentation Review
- [ ] OpenAPI spec complete
- [ ] Examples provided
- [ ] Error scenarios documented
- [ ] Authentication documented
- [ ] Rate limits specified

### Developer Experience
- [ ] Consistent naming conventions
- [ ] Intuitive endpoint structure
- [ ] Good error messages
- [ ] SDKs provided (if public)
- [ ] Sandbox environment

## API Design Principles

### 1. Consistency
- Same patterns across all endpoints
- Same naming conventions
- Same error format
- Same authentication

### 2. Predictability
- Idempotent operations where possible
- Clear error messages
- Documented behavior
- No surprises

### 3. Evolvability
- Version from the start
- Breaking changes in new versions
- Deprecation notices
- Migration guides

### 4. Simplicity
- Minimal endpoints
- Clear resource model
- No over-engineering
- Solve the problem, not future problems

## Integration with AI-DLC

### Inception Phase
- Define API requirements
- Resource modeling
- Integration needs

### Construction Phase
- API implementation
- Testing and validation
- Documentation generation

### Operations Phase
- API monitoring
- Version management
- Deprecation handling

## Best Practices Summary

**REST:**
- Use nouns, not verbs
- Plural resources
- Proper HTTP methods
- Consistent error format
- Version in URL

**GraphQL:**
- Strong typing
- Pagination for lists
- Mutations return payloads
- DataLoader for N+1

**All APIs:**
- Document thoroughly
- Test comprehensively
- Version carefully
- Secure properly
- Monitor usage

## Final Rule

```
Good APIs are:
- Intuitive (easy to understand)
- Consistent (predictable patterns)
- Documented (clear usage)
- Secure (protected access)
- Versioned (stable contracts)

Skip good API design? You'll support bad APIs forever.
```

No exceptions without your human partner's permission.
