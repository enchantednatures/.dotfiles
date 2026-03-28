# Issue Triage and Bug Fixing Skill (issue-triage)

## Description
Use this skill when presented with a bug report, issue description, error log, or GitHub Issue URL. It is a structured process to reproduce, investigate, plan a fix, and implement the resolution.

## When to use
- At the start of fixing a bug from user input or external reports.
- When an error trace is provided by the user.
- To triage, plan, and execute a fix for a known issue.

## Workflow

1. **Context & Triage:**
   - Thoroughly review the provided issue description, stack trace, or URL.
   - Use `webfetch` to read the issue from GitHub/GitLab if a URL is provided.
   - Extract the core problem, expected behavior, and steps to reproduce.
   - Ask clarifying questions if the issue report is incomplete.

2. **Reproduction & Investigation:**
   - Attempt to reproduce the issue locally or via tests.
   - Use the `glob` and `grep` tools or the `explore` subagent to locate the relevant files and functions.
   - Use the `read` tool to carefully analyze the code path.
   - Use `root-cause-tracing` if the bug involves complex state, race conditions, or deep call stacks.

3. **Plan the Fix:**
   - Define a minimal, safe, and robust fix.
   - Check if a new test case is needed to prevent regression.
   - Propose the fix to the user, summarizing the root cause and the planned changes.

4. **Implementation & Verification:**
   - Execute the fix using `edit` or `write`.
   - Implement the regression test.
   - Run the relevant test suite or manually trigger the functionality via `bash` to prove the fix works.
   - Verify that the fix does not break surrounding logic by running the full project test suite.

## Rules & Best Practices
- **STRICT NO PYTHON RULE:** Never use Python or Python-based tools/frameworks (like pytest, unittest, pip) for any generation or execution unless the user explicitly commands it or the project is explicitly a Python codebase.
- **Do no harm:** Avoid sweeping refactoring when fixing a specific bug unless requested. Keep the diff minimal and focused on the issue.
- **Root cause over symptoms:** Always try to fix the underlying logical error rather than just patching the immediate symptom.
- **Regression testing:** A bug fix is not complete without a test that previously failed and now passes.
- **Explain the "Why":** When communicating the fix to the user, explain why the bug occurred and how the fix addresses it.