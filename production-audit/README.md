# Production Audit Plugin

A Claude Code plugin for comprehensive production readiness auditing. Acts as the final engineering quality gate before shipping — covering code architecture, testing, performance, operations readiness, and feature-specific best practices.

Complements the [sraa-compliance](../sraa-compliance/) plugin, which handles security-focused audits.

## Features

- **Multi-Domain Auditing**: Four static analysis domains plus dynamic feature-specific research
- **Auto Stack Detection**: Automatically detects technology stack (Node.js, Python, Go, Rust, Java, etc.)
- **HyDE-Powered Research**: Uses Hypothetical Document Embedding to research domain-specific best practices
- **Persistent State**: Findings preserved across sessions in local markdown
- **Incremental Audits**: Resume where you left off, audit specific domains, or scope to feature branches

## Commands

| Command | Description |
|---------|-------------|
| `/production-audit:audit` | Start or resume a production readiness audit |
| `/production-audit:report` | Generate audit report from findings |
| `/production-audit:status` | Check current audit progress |

### Command Options

**`/production-audit:audit`**
- `--fresh` — Start a new audit (ignore previous state)
- `--feature` — Scope to files changed in current branch vs main
- `--domain <name>` — Audit specific domain only:
  - `code-architecture` — SOLID, complexity, coupling, design patterns
  - `testing-reliability` — Test coverage, error handling, logging, monitoring
  - `performance-scalability` — N+1, indexes, memory, bundle size, caching
  - `operations-readiness` — CI/CD, dependencies, docs, API contracts
  - `feature-practices` — HyDE-researched domain-specific best practices

**`/production-audit:report`**
- `--format <md|html>` — Output format (default: md)
- `--domain <name>` — Report for specific domain only

## Agents

| Agent | Role | Focus |
|-------|------|-------|
| `audit-orchestrator` | Workflow coordination | Stack detection, feature detection, agent dispatch |
| `code-architecture-auditor` | Code quality | SOLID, complexity, coupling, design patterns, layering |
| `testing-reliability-auditor` | Testing & reliability | Coverage, test quality, error handling, logging |
| `performance-scalability-auditor` | Performance | N+1 queries, indexes, memory, bundle size, caching |
| `operations-readiness-auditor` | Operations | CI/CD, dependencies, docs, API contracts, deployment |
| `best-practice-researcher` | Feature practices | HyDE-powered research for domain-specific patterns |
| `memory-coordinator` | State persistence | Findings aggregation, cross-session context |

## Severity Framework

| Severity | Meaning | Response Timeline | Example |
|----------|---------|-------------------|---------|
| **Critical** | Must fix before production | Immediate | No tests for core business logic, N+1 in hot path |
| **High** | Should fix before production | Before launch | Low coverage on critical paths, missing CI pipeline |
| **Medium** | Fix soon after launch | 1-2 sprints | Code duplication, missing API versioning |
| **Low** | Improve in next cycle | Backlog | Minor naming inconsistencies, missing JSDoc |

## Finding Format

Each finding follows a structured format:

```markdown
### [XX-NNN] Finding Title

**Severity:** Critical | High | Medium | Low
**Category:** Domain-specific category
**File(s):** path/to/file
**Line(s):** N-M

**Finding:** Description of the issue
**Evidence:** What was observed
**Recommendation:** How to fix it
**Best Practice:** Reference to the relevant standard
```

Finding ID prefixes by domain:
- `CA-###` — Code & Architecture
- `TR-###` — Testing & Reliability
- `PS-###` — Performance & Scalability
- `OR-###` — Operations Readiness
- `FP-###` — Feature Practices

## Audit Workspace

State is persisted in your project's `.claude/production-audit/` directory:

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

## Reference Materials

The plugin includes detailed control matrices and pattern libraries:

| Reference | Content |
|-----------|---------|
| `code-architecture-controls.md` | SOLID checks, complexity thresholds, coupling metrics |
| `testing-reliability-controls.md` | Coverage targets, test quality patterns, error handling |
| `performance-scalability-controls.md` | Query patterns, memory checks, caching strategies |
| `operations-readiness-controls.md` | CI/CD checks, dependency health, API contract validation |
| `stack-specific-patterns.md` | Technology-specific checks (React, Express, Django, etc.) |
| `feature-detection-patterns.md` | HyDE research methodology for domain best practices |

## License

MIT
