# Repository Context Mapping Skill (onboard)

## Description
Use this skill when initializing the AI agent in a new, undocumented, or massive codebase. It crawls the repository, identifies frameworks, core data models, routing, and state management, and generates an `.ai-architecture.md` file to act as the single source of truth for future tasks, dramatically reducing context window usage and search time.

## When to use
- At the start of a project or after cloning a large repository.
- When the AI is confused about the structure of the application.
- When the user explicitly requests onboarding or architecture documentation.

## Workflow

1. **Discovery Phase:**
   - Scan root configuration files (`package.json`, `docker-compose.yml`, `Cargo.toml`, `go.mod`).
   - Identify the primary languages, frameworks (e.g., Next.js, Express, Spring Boot), and key dependencies (e.g., Prisma, Redis, Kafka).
   - Use `glob` and `grep` to find:
     - Entry points (e.g., `src/main.ts`, `app/page.tsx`).
     - Core data models/schemas.
     - State management (e.g., Redux, Zustand, Context API).
     - Routing logic.

2. **Synthesis Phase:**
   - Compile the findings into a clear, structured document.
   - Describe the high-level architecture (e.g., Monolithic, Microservices, Serverless).
   - Map the critical data flows and module dependencies.

3. **Generation:**
   - Write the findings to `.ai-architecture.md` at the project root.
   - Present a concise summary of the architecture to the user.

## Rules & Best Practices
- **STRICT NO PYTHON RULE:** Never use Python or Python-based tools/frameworks for any generation or execution unless the user explicitly commands it or the project is explicitly a Python codebase.
- **Keep it Brief & Scannable:** The `.ai-architecture.md` file should be dense with facts, not conversational filler.
- **Update Existing Docs:** If an `.ai-architecture.md` already exists, read it first, append new findings, and do not overwrite it destructively.