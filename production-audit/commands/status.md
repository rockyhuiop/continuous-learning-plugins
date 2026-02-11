---
description: Check current production readiness audit progress and statistics
allowed-tools: ["Read", "Glob"]
---

# Production Audit Status Command

Display the current status of a production readiness audit, including progress by domain, finding statistics, and detected technology stack.

## Execution Steps

### Step 1: Check Audit State

1. Check if `.claude/production-audit/audit-state.md` exists
2. If not exists, display:
   ```
   No active production audit found.

   Run /production-audit:audit to start a new production readiness audit.
   ```
3. If exists, read the audit state file
4. Also read `stack-profile.md` if it exists

### Step 2: Read Findings

Read all finding files to get current counts:
- `.claude/production-audit/findings/code-architecture.md`
- `.claude/production-audit/findings/testing-reliability.md`
- `.claude/production-audit/findings/performance-scalability.md`
- `.claude/production-audit/findings/operations-readiness.md`
- `.claude/production-audit/findings/feature-practices.md`

Parse each file to count findings by severity.

### Step 3: Display Status

Format and display the status dashboard:

```
+======================================================+
|         Production Readiness Audit Status             |
+======================================================+
| Project: [Project Name]                               |
| Started: [Date/Time]                                  |
| Scope: [Full Project | Feature: branch-name]          |
| Stack: [Language] / [Framework]                        |
+======================================================+

Domain Progress
-------------------------------------------------------
Code & Architecture      [======----] 60%  ! 3 findings
Testing & Reliability    [==========] 100% v 5 findings
Performance & Scalability[----------] 0%   o pending
Operations Readiness     [====------] 40%  ! 2 findings
Feature Practices        [==========] 100% v 3 findings

Findings Summary
-------------------------------------------------------
+----------+-------+---------------------------------+
| Severity | Count | Distribution                    |
+----------+-------+---------------------------------+
| Critical |   1   | ====                            |
| High     |   3   | ============                    |
| Medium   |   5   | ====================            |
| Low      |   4   | ================                |
+----------+-------+---------------------------------+
| Total    |  13   |                                 |
+----------+-------+---------------------------------+

Status by Domain
-------------------------------------------------------
Code & Architecture:
  Crit: 0  High: 1  Med: 1  Low: 1

Testing & Reliability:
  Crit: 1  High: 1  Med: 2  Low: 1

Performance & Scalability:
  (audit not started)

Operations Readiness:
  Crit: 0  High: 1  Med: 0  Low: 1

Feature Practices:
  Crit: 0  High: 0  Med: 2  Low: 1
  Domains researched: Payment Processing, Authentication

Recent Activity
-------------------------------------------------------
- [timestamp] Feature practices research completed
- [timestamp] Found: TR-001 (Critical) - Payment module untested
- [timestamp] Code & architecture audit started
- [timestamp] Audit initiated

Next Steps
-------------------------------------------------------
- Continue audit: /production-audit:audit
- Generate report: /production-audit:report
- Audit specific domain: /production-audit:audit --domain performance-scalability
```

### Status Indicators

Use these indicators for domain status:
- `o` - Not started (pending)
- `~` - In progress
- `v` - Completed (no critical/high findings)
- `!` - Completed (has critical or high findings)
- `x` - Error during audit

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
Production Audit Status - [Project]
Started: [Date] | Scope: [full|feature] | Stack: [TS/Next.js]

Domains: CA[60%] TR[100%v] PS[0%] OR[40%] FP[100%v]
Findings: 1C 3H 5M 4L = 13 total
Features: Payment, Auth

Run /production-audit:report for full details
```

## Error Handling

- If audit state file is corrupted, attempt to reconstruct from findings
- If findings files are missing, show 0 findings for that domain
- Display helpful error messages with recovery suggestions
