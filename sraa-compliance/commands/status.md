---
name: status
description: Check current SRAA compliance audit progress and statistics
allowed-tools: ["Read", "Glob"]
---

# SRAA Status Command

Display the current status of an SRAA compliance audit, including progress by domain and finding statistics.

## Execution Steps

### Step 1: Check Audit State

1. Check if `.claude/sraa-audit/audit-state.md` exists
2. If not exists, display:
   ```
   No active SRAA audit found.

   Run /sraa:audit to start a new compliance audit.
   ```
3. If exists, read the audit state file

### Step 2: Read Findings

Read all finding files to get current counts:
- `.claude/sraa-audit/findings/security-controls.md`
- `.claude/sraa-audit/findings/application-security.md`
- `.claude/sraa-audit/findings/policy-compliance.md`
- `.claude/sraa-audit/findings/infrastructure.md`

Parse each file to count findings by severity.

### Step 3: Display Status

Format and display the status dashboard:

```
╔══════════════════════════════════════════════════════╗
║           SRAA Compliance Audit Status               ║
╠══════════════════════════════════════════════════════╣
║ Project: [Project Name]                              ║
║ Started: [Date/Time]                                 ║
║ Mode: [incremental|fresh]                            ║
╚══════════════════════════════════════════════════════╝

Domain Progress
───────────────────────────────────────────────────────
Security Controls      [██████░░░░] 60%  ⚠ 3 findings
Application Security   [██████████] 100% ✓ 5 findings
Policy Compliance      [░░░░░░░░░░] 0%   ○ pending
Infrastructure         [████░░░░░░] 40%  ⚠ 2 findings

Findings Summary
───────────────────────────────────────────────────────
┌──────────┬───────┬─────────────────────────────────┐
│ Severity │ Count │ Distribution                    │
├──────────┼───────┼─────────────────────────────────┤
│ Critical │   1   │ ████                            │
│ High     │   2   │ ████████                        │
│ Medium   │   4   │ ████████████████                │
│ Low      │   3   │ ████████████                    │
├──────────┼───────┼─────────────────────────────────┤
│ Total    │  10   │                                 │
└──────────┴───────┴─────────────────────────────────┘

Status by Domain
───────────────────────────────────────────────────────
Security Controls:
  • Crit: 0  High: 1  Med: 1  Low: 1

Application Security:
  • Crit: 1  High: 1  Med: 2  Low: 1

Policy Compliance:
  • (audit not started)

Infrastructure:
  • Crit: 0  High: 0  Med: 1  Low: 1

Recent Activity
───────────────────────────────────────────────────────
• [timestamp] Application security audit completed
• [timestamp] Found: APP-002 (Critical) - JWT validation
• [timestamp] Security controls audit started
• [timestamp] Audit initiated

Next Steps
───────────────────────────────────────────────────────
• Continue audit: /sraa:audit
• Generate report: /sraa:report
• View specific domain: /sraa:audit --domain policy-compliance
```

### Status Indicators

Use these indicators for domain status:
- `○` - Not started (pending)
- `◐` - In progress
- `✓` - Completed (no critical/high findings)
- `⚠` - Completed (has findings)
- `✗` - Error during audit

### Progress Calculation

Calculate progress based on:
- Pending: 0%
- In progress: Based on checks completed
- Completed: 100%
- Error: Show percentage at time of error

### Finding Distribution

Show visual distribution using bar characters:
- Use proportional bars based on finding count
- Maximum bar width: 30 characters

## Compact Mode

If the terminal is narrow or if many findings exist, use compact format:

```
SRAA Audit Status - [Project]
Started: [Date] | Mode: incremental

Domains: SC[60%] AS[100%✓] PC[0%] IN[40%]
Findings: 1C 2H 4M 3L = 10 total

Run /sraa:report for full details
```

## Error Handling

- If audit state file is corrupted, attempt to reconstruct from findings
- If findings files are missing, show 0 findings for that domain
- Display helpful error messages with recovery suggestions
