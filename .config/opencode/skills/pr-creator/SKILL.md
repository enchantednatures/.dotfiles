# PR Creator & Git Flow Skill (pr-creator)

## Description
Use this skill to autonomously manage the git lifecycle of an implemented feature or fix. It creates atomic commits, writes conventional commit messages, and generates rich, context-aware GitHub/GitLab Pull Request descriptions.

## When to use
- After a feature is complete, tested, and audited.
- To create a pull request directly from the CLI.
- When the user asks to "ship it" or "create a PR."

## Workflow

1. **Review & Stage:**
   - Run `git status` and `git diff` to understand the current working tree.
   - Review the changes against the original plan or specification.
   - Stage the relevant files (`git add`).

2. **Commit:**
   - Generate atomic, conventional commit messages (e.g., `feat(auth): add JWT support`, `fix(ui): resolve button alignment`).
   - Run `git commit -m "..."`.

3. **Push & PR Generation:**
   - If not on a feature branch, create one and push it (`git checkout -b feature/name`, `git push -u origin feature/name`).
   - Analyze the commit history to generate a robust PR summary using `gh pr create`.
   - The PR description should include:
     - **Title:** Clear, concise summary of the change.
     - **Body:**
       - **Description:** What the PR does and why it is needed.
       - **Related Issues:** Link any relevant issues (e.g., "Fixes #42").
       - **Testing Steps:** How a reviewer can manually test the changes.
       - **Checklist:** (e.g., Tests written, Linting passed).

## Rules & Best Practices
- **STRICT NO PYTHON RULE:** Never use Python or Python-based tools/frameworks for any generation or execution unless the user explicitly commands it or the project is explicitly a Python codebase.
- **Atomic Commits:** Prefer multiple small commits over one massive commit if the feature is complex.
- **Descriptive Titles:** The PR title should clearly convey the impact of the changes.
- **Do not overwrite history:** Never `git push --force` unless instructed by the user.