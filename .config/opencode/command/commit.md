---
description: Generate a commit message
model: opencode/glm-4.6
---

Commit and push

Generate a concise, descriptive git commit message (50 chars max for subject line) based on the staged changes.

GUIDELINES:
1. Format: "<type>: <description>" (e.g., "fix: resolve JSON parsing errors in world generation")
2. Types: feat (feature), fix (bug), refactor (code structure), docs (documentation), style (formatting), test (tests)
3. Subject line: 50 characters max, imperative mood ("add" not "adds" or "added")
4. Be specific about WHAT changed, not HOW
5. Reference issue/PR numbers if applicable
6. Do NOT include period at end of subject line
AVOID: "Update files", "Fix bugs", "Improve code"
