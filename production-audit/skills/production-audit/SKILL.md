---
name: Production Audit
description: This skill should be used when the user asks to "audit my codebase", "production readiness audit", "pre-production checklist", "code quality audit", "architecture review", "is this ready for production", "check if this is production ready", "review before deploying", "software engineering audit", "engineering best practices audit", or needs to assess whether a codebase meets engineering standards before shipping. Covers code quality, architecture, testing, performance, reliability, operations readiness, and feature-specific best practices via HyDE-powered research.
version: 1.0.0
---

# Production Readiness Audit Framework

## Overview

The Production Audit framework provides a comprehensive engineering quality assessment for codebases before they ship to production. It complements security-focused audits (such as SRAA compliance) by covering the non-security engineering concerns that determine whether software will perform reliably, scale appropriately, and remain maintainable in production.

## Audit Scope

### Four Domain Auditors (Static Analysis)

| Domain | Agent | Finding Prefix | Focus |
|--------|-------|----------------|-------|
| Code & Architecture | code-architecture-auditor | `CA-###` | SOLID, complexity, coupling, design patterns, layering |
| Testing & Reliability | testing-reliability-auditor | `TR-###` | Coverage, test quality, error handling, logging, monitoring |
| Performance & Scalability | performance-scalability-auditor | `PS-###` | N+1 queries, indexes, memory, bundle size, caching |
| Operations Readiness | operations-readiness-auditor | `OR-###` | CI/CD, dependencies, docs, API contracts, deployment |

### Feature-Specific Research (Dynamic Analysis)

| Agent | Finding Prefix | Focus |
|-------|----------------|-------|
| best-practice-researcher | `FP-###` | HyDE-powered research for domain-specific best practices |

### Supporting Agents

| Agent | Role |
|-------|------|
| audit-orchestrator | Stack detection, feature detection, workflow coordination, agent dispatch |
| memory-coordinator | State persistence, findings aggregation, cross-session context |

## Severity Framework

| Severity | Meaning | Response Timeline | Example |
|----------|---------|-------------------|---------|
| **Critical** | Must fix before production | Immediate | No tests for core business logic, N+1 in hot path |
| **High** | Should fix before production | Before launch | Low coverage on critical paths, missing CI pipeline |
| **Medium** | Fix soon after launch | 1-2 sprints | Code duplication, missing API versioning |
| **Low** | Improve in next cycle | Backlog | Minor naming inconsistencies, missing JSDoc |

## Multi-Stack Detection

The orchestrator automatically detects the technology stack by scanning for indicator files (package.json, pyproject.toml, go.mod, Cargo.toml, pom.xml, etc.) and adjusts audit checks accordingly. Stack-specific patterns are layered on top of universal engineering best practices.

For detailed stack-specific checks, consult `references/stack-specific-patterns.md`.

## Feature Detection and HyDE Research

The orchestrator identifies feature domains (payment processing, authentication, search, real-time, etc.) by scanning for domain-specific keywords in the codebase. Detected features trigger the best-practice-researcher agent to find authoritative industry standards.

For feature detection signals, consult `references/feature-detection-patterns.md`.

## Audit Workflow

The standard audit execution follows this sequence:

1. **Initialize** — Create workspace in `.claude/production-audit/` or resume from existing state
2. **Detect Stack** — Scan for indicator files (package.json, pyproject.toml, go.mod, etc.) to identify language, framework, and database. Write results to `stack-profile.md`
3. **Detect Features** — Grep source files for domain-specific keywords (payment, auth, search, etc.) to identify feature areas requiring specialized research
4. **Scope** — If feature mode, run `git diff --name-only main...HEAD` to limit audit to changed files
5. **Dispatch Static Auditors** — Launch the four domain auditors in parallel. Each consults its reference control matrix and writes findings to its domain file
6. **Dispatch HyDE Researcher** — For each detected feature domain, the best-practice-researcher generates a hypothesis, validates via web search against authoritative sources, and produces findings with citations
7. **Aggregate** — Memory coordinator collects all findings, validates IDs, updates severity counts
8. **Report** — Generate consolidated report with findings sorted by severity and a remediation roadmap

When a finding spans multiple domains, assign it to the primary domain and note the cross-domain impact in the description.

## Audit Modes

### Full Project Audit
Assess the entire codebase across all domains. Start with `/production-audit:audit`.

### Feature-Scoped Audit
Audit only files changed in the current branch vs main. Start with `/production-audit:audit --feature`. Uses `git diff --name-only main...HEAD` to determine scope.

### Domain-Specific Audit
Audit a single domain. Start with `/production-audit:audit --domain <name>`.

## Workspace Structure

All audit state persists in `.claude/production-audit/`:

```
.claude/production-audit/
├── audit-state.md              # Master state tracking
├── stack-profile.md            # Detected tech stack
├── findings/
│   ├── code-architecture.md    # CA-### findings
│   ├── testing-reliability.md  # TR-### findings
│   ├── performance-scalability.md  # PS-### findings
│   ├── operations-readiness.md # OR-### findings
│   └── feature-practices.md    # FP-### findings (from research)
├── evidence/
└── reports/
```

## Using This Plugin

### Start an Audit
```
/production-audit:audit                    # Resume or start full audit
/production-audit:audit --fresh            # Start new audit
/production-audit:audit --feature          # Audit current branch changes only
/production-audit:audit --domain testing-reliability  # Specific domain
```

### Check Progress
```
/production-audit:status
```

### Generate Report
```
/production-audit:report
/production-audit:report --domain code-architecture
```

## Additional Resources

### Reference Files

For detailed control matrices and check patterns, consult:
- **`references/code-architecture-controls.md`** - SOLID, Clean Code, complexity metrics
- **`references/testing-reliability-controls.md`** - Testing pyramid, FIRST principles, error handling, monitoring readiness
- **`references/performance-scalability-controls.md`** - Database optimization, memory management, frontend performance, caching
- **`references/operations-readiness-controls.md`** - DORA, Twelve-Factor, SemVer, licensing
- **`references/stack-specific-patterns.md`** - Per-stack best practice checks
- **`references/feature-detection-patterns.md`** - Feature domain indicators and HyDE methodology

### Example Files

Working examples in `examples/`:
- **`examples/sample-findings.md`** - Example finding documentation format across all domains
