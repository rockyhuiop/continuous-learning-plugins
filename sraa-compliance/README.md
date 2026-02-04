# SRAA Compliance Audit Plugin

A Claude Code plugin for auditing codebases against Hong Kong's **SRAA (Security Risk Assessment and Audit)** framework, based on the Digital Policy Office's S17 Baseline IT Security Policy, G3 IT Security Guidelines, and ISPG-SM01 Practice Guide.

## Features

- **Comprehensive SRAA Coverage**: Audits all 10 Annex C security domains
- **Specialized Sub-Agents**: Domain-specific auditors with OWASP expertise
- **Persistent Context Memory**: Findings preserved across sessions in local markdown
- **Incremental Audits**: Resume where you left off or start fresh
- **Structured Reports**: Generate executive summaries and detailed findings

## Commands

| Command | Description |
|---------|-------------|
| `/sraa:audit` | Start or resume an SRAA compliance audit |
| `/sraa:report` | Generate audit report from findings |
| `/sraa:status` | Check current audit progress |

### Command Options

**`/sraa:audit`**
- `--fresh` - Start a new audit (ignore previous state)
- `--domain <name>` - Audit specific domain only (security-controls, application-security, policy-compliance, infrastructure)

**`/sraa:report`**
- `--format <md|html>` - Output format (default: md)
- `--domain <name>` - Generate report for specific domain

## Agents

| Agent | Role | Audit Focus |
|-------|------|-------------|
| `sraa-orchestrator` | Coordinates workflow | Dispatches domain auditors |
| `memory-coordinator` | Context persistence | Manages findings & state |
| `security-controls-auditor` | Network/Host security | Firewall, LAN, host hardening |
| `application-security-auditor` | App security | OWASP Top 10, React patterns |
| `policy-compliance-auditor` | Documentation | Policies, procedures, governance |
| `infrastructure-auditor` | Infrastructure | Remote access, CI/CD, cloud |

## Audit Areas (SRAA Annex C)

1. Firewall
2. Internal Network
3. External Network
4. Host Security
5. Internet Security
6. Remote Access
7. Wireless Communication
8. Phone Line/Telecom
9. Web/Mobile Application (OWASP focus)
10. Security Policy, Guidelines & Procedures

## Memory Architecture

Audit state is persisted in your project's `.claude/sraa-audit/` directory:

```
.claude/sraa-audit/
├── audit-state.md          # Progress tracking
├── findings/
│   ├── security-controls.md
│   ├── application-security.md
│   ├── policy-compliance.md
│   └── infrastructure.md
├── evidence/               # Evidence references
└── reports/               # Generated reports
```

## Finding Format

Findings are documented with:
- Severity (Critical/High/Medium/Low)
- SRAA control reference (S17/G3)
- Evidence with file:line locations
- Remediation recommendations

## SRAA Framework Reference

### Core Documents
- **S17** - Baseline IT Security Policy (mandatory minimums)
- **G3** - IT Security Guidelines (detailed controls)
- **ISPG-SM01** - Practice Guide for SRAA (methodology)

### Resources
- [GovCERT.HK Resources](https://www.govcert.gov.hk/en/resources.html)
- [S17 PDF](https://www.govcert.gov.hk/doc/S17_EN.pdf)
- [G3 PDF](https://www.govcert.gov.hk/doc/G3_EN.pdf)
- [ISPG-SM01 Guide](https://metanorma.github.io/hk-ogcio-infosec-docs/documents/ogcio-ispg-sm01.html)

## Installation

This plugin is installed at `~/.claude/plugins/sraa-compliance/`.

To use with Claude Code:
```bash
claude --plugin-dir ~/.claude/plugins/sraa-compliance
```

Or add to your Claude Code settings for automatic loading.

## License

MIT
