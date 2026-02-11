---
description: Start or resume a production readiness audit for the current codebase
argument-hint: "[--fresh] [--feature] [--domain <name>]"
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash", "Task"]
---

# Production Readiness Audit Command

Execute a comprehensive production readiness audit on the current codebase. This command coordinates multiple specialized agents to assess engineering quality across code architecture, testing, performance, operations, and feature-specific best practices.

## Arguments

- `--fresh` - Start a new audit, ignoring any existing audit state
- `--feature` - Scope audit to files changed in current branch vs main (git diff-based)
- `--domain <name>` - Audit only a specific domain:
  - `code-architecture` - SOLID, complexity, coupling, design patterns
  - `testing-reliability` - Test coverage, error handling, logging, monitoring
  - `performance-scalability` - N+1, indexes, memory, bundle size, caching
  - `operations-readiness` - CI/CD, dependencies, docs, API contracts
  - `feature-practices` - HyDE-researched domain-specific best practices

## Execution Steps

### Step 1: Check Existing Audit State

1. Check if `.claude/production-audit/audit-state.md` exists
2. If exists and `--fresh` NOT specified:
   - Read the audit state
   - Display current progress summary
   - Offer to resume or start fresh
3. If `--fresh` specified or no existing state:
   - Initialize new audit workspace

### Step 2: Initialize Audit Workspace

If starting fresh or no workspace exists, create the directory structure:

```
.claude/production-audit/
├── audit-state.md
├── stack-profile.md
├── findings/
│   ├── code-architecture.md
│   ├── testing-reliability.md
│   ├── performance-scalability.md
│   ├── operations-readiness.md
│   └── feature-practices.md
├── evidence/
└── reports/
```

Create `audit-state.md` with initial state:
```markdown
# Production Audit State

**Started:** [ISO timestamp]
**Mode:** incremental
**Scope:** [full|feature]
**Project:** [current project name]
**Branch:** [current branch if feature mode]

## Domain Progress

| Domain | Status | Progress | Last Updated | Findings |
|--------|--------|----------|--------------|----------|
| Code & Architecture | pending | 0% | - | 0 |
| Testing & Reliability | pending | 0% | - | 0 |
| Performance & Scalability | pending | 0% | - | 0 |
| Operations Readiness | pending | 0% | - | 0 |
| Feature Practices | pending | 0% | - | 0 |

## Findings Summary

| Severity | Count |
|----------|-------|
| Critical | 0 |
| High | 0 |
| Medium | 0 |
| Low | 0 |

## Audit Log

- [timestamp] Audit initiated
```

### Step 3: Feature Scope (if --feature)

If `--feature` flag is present:
1. Run `git diff --name-only main...HEAD` to get list of changed files
2. Store the file list in the audit state for auditors to reference
3. Add to audit log: "Feature scope: [N] files changed"

### Step 4: Dispatch Audit Agents

If `--domain` specified, only dispatch that domain's agent.

Otherwise, use the Task tool to dispatch the `audit-orchestrator` agent with this prompt:

```
Coordinate a production readiness audit for this codebase.

Audit workspace: .claude/production-audit/
Scope: [full|feature]
[If feature: Changed files: <file list>]

Your responsibilities:
1. Detect the technology stack and write stack-profile.md
2. Detect feature domains (payment, auth, search, etc.)
3. Dispatch domain-specific auditors in parallel:
   - code-architecture-auditor for code quality and design
   - testing-reliability-auditor for testing and error handling
   - performance-scalability-auditor for performance patterns
   - operations-readiness-auditor for CI/CD and deployment
4. For detected features, dispatch best-practice-researcher
5. Track progress in audit-state.md
6. Aggregate findings when complete
```

If `--domain` specified, dispatch only the relevant agent:
- `code-architecture` → Task with `code-architecture-auditor`
- `testing-reliability` → Task with `testing-reliability-auditor`
- `performance-scalability` → Task with `performance-scalability-auditor`
- `operations-readiness` → Task with `operations-readiness-auditor`
- `feature-practices` → Task with `best-practice-researcher`

### Step 5: Report Progress

After agents complete:
1. Update audit-state.md with completion status
2. Display summary of findings by severity
3. Suggest next steps:
   - Use `/production-audit:status` to check detailed progress
   - Use `/production-audit:report` to generate full report

## Output Format

Display a summary table:

```
Production Readiness Audit - [Project Name]
============================================

Status: [In Progress / Complete]
Scope: [Full Project / Feature Branch: branch-name]
Started: [timestamp]

Domain Progress:
+--------------------------+----------+----------+
| Domain                   | Status   | Findings |
+--------------------------+----------+----------+
| Code & Architecture      | ******-- | 3        |
| Testing & Reliability    | ******** | 5        |
| Performance & Scalability| -------- | 0        |
| Operations Readiness     | ****---- | 2        |
| Feature Practices        | ******** | 3        |
+--------------------------+----------+----------+

Findings Summary:
- Critical: 1
- High: 3
- Medium: 5
- Low: 4

Next: Run /production-audit:report to generate full report
```

## Error Handling

- If audit workspace cannot be created, display error and exit
- If an agent fails, mark that domain as "error" and continue with others
- Preserve partial progress even if audit is interrupted
- If `--feature` and not on a branch (or no diff), fall back to full audit with a warning
