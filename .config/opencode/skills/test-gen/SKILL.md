# Test Generation Skill (test-gen)

## Description
Use this skill to generate comprehensive automated test suites (Unit, Integration, E2E) for existing code or derived from a PRD/Specification document. This ensures maximum test coverage and system reliability in the AI DLC workflow.

## When to use
- After implementation is complete and you need to verify functionality.
- Before implementation (TDD approach) based on an approved specification or plan.
- When expanding test coverage for legacy code.

## Workflow

1. **Context Gathering:**
   - Review the target codebase, focusing on public APIs, complex logic, and edge cases.
   - Read relevant specifications, PRDs, or implementation plans.
   - Identify the primary testing framework used in the project (e.g., Pytest, Jest, Mocha, JUnit, RSpec). If none exists, propose an industry-standard framework for the project's language.

2. **Test Strategy Planning:**
   - Create a brief plan outlining:
     - The types of tests to write (Unit, Integration, Mocking strategy).
     - Key scenarios (happy path, edge cases, error handling).
     - Dependencies that require mocking or stubbing.
   - Validate this strategy with the user if the scope is large.

3. **Test Implementation:**
   - Write the test files following the project's naming conventions (e.g., `*.test.js`, `test_*.py`).
   - Implement comprehensive mock objects and fixtures.
   - Ensure tests are deterministic and isolated.

4. **Verification:**
   - Execute the test suite using the appropriate command (e.g., `npm test`, `pytest`, `cargo test`).
   - If tests fail, iterate on the code or tests until the suite passes cleanly.
   - Report test coverage if tools are available.

## Rules & Best Practices
- **STRICT NO PYTHON RULE:** Never use Python or Python-based tools/frameworks (like pytest, unittest, pip) for any generation or execution unless the user explicitly commands it or the project is explicitly a Python codebase.
- **Never test external services directly:** Always mock APIs, databases, and third-party services for unit tests.
- **Isolate tests:** Tests should not depend on the execution order of other tests.
- **Descriptive naming:** Test names should clearly explain *what* is being tested and *under what conditions*.
- **Use Arrange-Act-Assert (AAA):** Structure tests logically.
