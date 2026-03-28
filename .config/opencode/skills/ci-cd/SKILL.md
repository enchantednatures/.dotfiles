# CI/CD and Deployment Pipeline Generation Skill (ci-cd)

## Description
Use this skill to autonomously design, create, and configure continuous integration and continuous deployment (CI/CD) pipelines, Dockerfiles, and deployment manifests (Kubernetes, Terraform) for a project.

## When to use
- After project implementation is functionally complete and tested.
- When the user requests containerization of an application (Docker, Podman).
- When the user requests automated testing/deployment pipelines (GitHub Actions, GitLab CI, Jenkins).
- When generating infrastructure-as-code (IaC) or deployment manifests.

## Workflow

1. **Context & Requirement Analysis:**
   - Scan the project structure to identify the technology stack, main entry points, build steps, and testing commands.
   - Look for existing configuration files (`package.json`, `pom.xml`, `requirements.txt`, `Cargo.toml`).
   - Identify the target deployment environment (e.g., Docker Hub, AWS ECS, Kubernetes, Vercel, Heroku).

2. **Pipeline/Dockerfile Design:**
   - Create a robust `Dockerfile` optimized for production (multi-stage builds, minimal base images like alpine/distroless, least-privilege users).
   - Design a CI pipeline (e.g., `.github/workflows/main.yml`) that includes:
     - **Linting & Formatting:** Running code quality tools.
     - **Testing:** Running the test suite.
     - **Build:** Compiling the application or building the Docker image.
     - **Security Scan:** Optional container or dependency vulnerability scanning.
   - Propose the design to the user for confirmation.

3. **Implementation:**
   - Write the `Dockerfile` and/or `.dockerignore`.
   - Write the CI/CD pipeline configuration file.
   - Write any necessary deployment manifests (e.g., `k8s/deployment.yaml`, `docker-compose.yml`).

4. **Validation:**
   - If Docker is available locally, verify the Dockerfile builds successfully using `docker build`.
   - Explain the necessary secrets or environment variables the user needs to set up in their CI provider.

## Rules & Best Practices
- **STRICT NO PYTHON RULE:** Never use Python or Python-based tools/frameworks (like pytest, unittest, pip) for any generation or execution unless the user explicitly commands it or the project is explicitly a Python codebase.
- **Security First:** Never hardcode secrets in Dockerfiles or CI configs. Use CI provider secret management mechanisms.
- **Efficiency:** Utilize layer caching in Dockerfiles and dependency caching in CI workflows.
- **Idempotency:** Ensure deployment scripts and manifests can be run multiple times safely.
- **Fail Fast:** Configure CI pipelines to fail immediately on linting or testing errors before attempting builds.