---
description: Conduct security-focused code review to identify vulnerabilities
model: opencode/kimi-k2.5
---

Perform a security review

You are conducting a comprehensive security review to identify vulnerabilities and validate security controls are properly implemented.

## Context

Code is ready for review. You need to identify security vulnerabilities before deployment.

## Process

### Step 1: Threat Modeling

Identify:
- What data is sensitive?
- Who are the potential attackers?
- What are the attack vectors?
- What could go wrong?

### Step 2: Review Areas

**1. Input Validation**
- SQL injection prevention
- XSS prevention
- Command injection prevention
- File upload validation

**2. Authentication**
- Password policy
- Session management
- Token lifecycle
- Brute force protection

**3. Authorization**
- Access control checks
- Privilege escalation prevention
- IDOR vulnerabilities

**4. Data Protection**
- Encryption at rest
- Encryption in transit
- Sensitive data handling
- Secrets management

**5. Dependencies**
- Vulnerable packages
- Supply chain risks
- License compliance

**6. Infrastructure**
- Network security
- Container security
- Cloud security posture

### Step 3: OWASP Top 10 Assessment

Check each OWASP category:
- Broken Access Control
- Cryptographic Failures
- Injection
- Insecure Design
- Security Misconfiguration
- Vulnerable Components
- Auth Failures
- Data Integrity Failures
- Logging Failures
- SSRF

### Step 4: Document Vulnerabilities

For each finding:
- Severity (Critical/High/Medium/Low)
- Location in code
- Exploitation scenario
- Remediation steps
- CVSS score (if applicable)

## Output Format

Save security review to:
- Path: `reviews/security-YYYYMMDD-feature.md`
- Format: Markdown with structure from security-review skill

## Response Structure

1. Overall risk level (Critical / High / Medium / Low)
2. Vulnerability summary
3. Critical and high findings
4. OWASP Top 10 assessment
5. Remediation plan
6. Location where review was saved
