# Security Audit Skill (security-audit)

## Description
Use this skill to perform a comprehensive security audit on the codebase before merging or deploying. It identifies common vulnerabilities, hardcoded secrets, and insecure configurations.

## When to use
- As a mandatory gate before initiating the `pr-creator` or `ci-cd` skills.
- When reviewing a PR or large refactor.
- When the user requests a security review.

## Workflow

1. **Dependency Analysis:**
   - Run dependency audit tools native to the project (e.g., `npm audit`, `bun audit`, `cargo audit`).
   - Identify High or Critical CVEs and propose updates.

2. **Static Application Security Testing (SAST):**
   - Search for hardcoded secrets, API keys, and credentials using `grep`.
   - Look for OWASP Top 10 vulnerabilities (e.g., SQL injection, XSS, insecure deserialization).
   - Verify that sensitive endpoints have proper authentication and authorization checks.

3. **Configuration Review:**
   - Check CORS policies, TLS settings, and security headers if applicable.
   - Ensure Dockerfiles do not run as root.

4. **Reporting:**
   - Summarize findings by severity.
   - Provide concrete, actionable remediation steps for each finding.

## Rules & Best Practices
- **STRICT NO PYTHON RULE:** Never use Python or Python-based tools/frameworks (like bandit, safety) for any generation or execution unless the user explicitly commands it or the project is explicitly a Python codebase.
- **Do not expose secrets:** If you find a secret, redact it in your output to the user.
- **Actionable Advice:** Do not just point out a flaw; write the code to fix it.