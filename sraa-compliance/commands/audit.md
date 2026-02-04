---
description: Start or resume an SRAA (Security Risk Assessment and Audit) compliance audit for the current codebase
argument-hint: "[--fresh] [--domain <name>]"
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash", "Task"]
---

# SRAA Compliance Audit Command

Execute a comprehensive SRAA compliance audit on the current codebase. This command coordinates multiple specialized agents to assess security across all Annex C audit domains.

## Arguments

- `--fresh` - Start a new audit, ignoring any existing audit state
- `--domain <name>` - Audit only a specific domain:
  - `security-controls` - Network, firewall, host security
  - `application-security` - OWASP, code security
  - `policy-compliance` - Documentation, procedures
  - `infrastructure` - Remote access, CI/CD, cloud

## Execution Steps

### Step 1: Check Existing Audit State

1. Check if `.claude/sraa-audit/audit-state.md` exists
2. If exists and `--fresh` NOT specified:
   - Read the audit state
   - Display current progress summary
   - Offer to resume or start fresh
3. If `--fresh` specified or no existing state:
   - Initialize new audit workspace

### Step 2: Initialize Audit Workspace

If starting fresh or no workspace exists, create the directory structure:

```
.claude/sraa-audit/
├── audit-state.md
├── findings/
│   ├── security-controls.md
│   ├── application-security.md
│   ├── policy-compliance.md
│   └── infrastructure.md
├── evidence/
└── reports/
```

Create `audit-state.md` with initial state:
```markdown
# SRAA Audit State

**Started:** [ISO timestamp]
**Mode:** incremental
**Project:** [current project name]

## Domain Progress

| Domain | Status | Progress | Last Updated |
|--------|--------|----------|--------------|
| Security Controls | pending | 0% | - |
| Application Security | pending | 0% | - |
| Policy Compliance | pending | 0% | - |
| Infrastructure | pending | 0% | - |

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

### Step 3: Dispatch Audit Agents

If `--domain` specified, only dispatch that domain's agent.

Otherwise, use the Task tool to dispatch the `sraa-orchestrator` agent with this prompt:

```
Coordinate an SRAA compliance audit for this codebase.

Audit workspace: .claude/sraa-audit/

Your responsibilities:
1. Review the codebase structure
2. Dispatch domain-specific auditors in parallel:
   - security-controls-auditor for network/host security
   - application-security-auditor for OWASP/code security
   - policy-compliance-auditor for documentation review
   - infrastructure-auditor for remote access/CI/CD
3. Track progress in audit-state.md
4. Aggregate findings when complete
```

If `--domain` specified, dispatch only the relevant agent:
- `security-controls` → Task with `security-controls-auditor`
- `application-security` → Task with `application-security-auditor`
- `policy-compliance` → Task with `policy-compliance-auditor`
- `infrastructure` → Task with `infrastructure-auditor`

### Step 4: Report Progress

After agents complete:
1. Update audit-state.md with completion status
2. Display summary of findings by severity
3. Suggest next steps:
   - Use `/sraa:status` to check detailed progress
   - Use `/sraa:report` to generate full report

## Output Format

Display a summary table:

```
SRAA Compliance Audit - [Project Name]
=====================================

Status: [In Progress / Complete]
Started: [timestamp]

Domain Progress:
┌─────────────────────┬──────────┬──────────┐
│ Domain              │ Status   │ Findings │
├─────────────────────┼──────────┼──────────┤
│ Security Controls   │ ██████░░ │ 3        │
│ Application Security│ ████████ │ 5        │
│ Policy Compliance   │ ░░░░░░░░ │ 0        │
│ Infrastructure      │ ████░░░░ │ 2        │
└─────────────────────┴──────────┴──────────┘

Findings Summary:
- Critical: 1
- High: 2
- Medium: 4
- Low: 3

Next: Run /sraa:report to generate full report
```

## Error Handling

- If audit workspace cannot be created, display error and exit
- If an agent fails, mark that domain as "error" and continue with others
- Preserve partial progress even if audit is interrupted
