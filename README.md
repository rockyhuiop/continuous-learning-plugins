# Rocky's Plugins

A personal collection of Claude Code plugins for knowledge management, security compliance, and engineering quality.

## Installation

### Add this marketplace

```bash
claude plugins marketplace add github:rockyhuiop/continuous-learning-plugins
```

### Install plugins

```bash
# Install individual plugins
claude plugins install learning-vault@continuous-learning-plugins
claude plugins install anki-flashcards@continuous-learning-plugins
claude plugins install sraa-compliance@continuous-learning-plugins
claude plugins install production-audit@continuous-learning-plugins
```

## Available Plugins

### learning-vault

**Capture technical learnings to Obsidian vault using Zettelkasten method.**

| Component | Description |
|-----------|-------------|
| `/learning-vault:learn` | Capture a concept as an atomic Zettelkasten note |
| `/learning-vault:learn-review` | Analyze recent git history to discover learnable concepts |
| `learning-discovery` agent | Suggests patterns and techniques from your work |
| `zettelkasten-notes` skill | Guidance on writing effective atomic notes |

**Requirements:** Obsidian MCP Server configured in Claude Code

```bash
claude mcp add obsidian --scope user -- npx @mauricio.wolff/mcp-obsidian@latest "/path/to/vault"
```

### anki-flashcards

**Create Anki flashcards from conversation context for spaced repetition learning.**

| Component | Description |
|-----------|-------------|
| `/anki-flashcards:flashcard` | Create flashcards from conversation context |
| `flashcard-reviewer` agent | Reviews cards for learning effectiveness |
| `anki-flashcard-creation` skill | Best practices for card design |

**Requirements:** Anki desktop + AnkiConnect add-on + Anki MCP server

### sraa-compliance

**SRAA compliance auditing for Hong Kong security standards (S17, G3, ISPG-SM01).**

| Component | Description |
|-----------|-------------|
| `/sraa-compliance:audit` | Start or resume a compliance audit |
| `/sraa-compliance:report` | Generate audit report from findings |
| `/sraa-compliance:status` | Check current audit progress |
| 6 specialized agents | Security controls, app security, policy, infrastructure, orchestrator, memory |

Audits codebases against all 10 SRAA Annex C security domains with persistent findings across sessions.

### production-audit

**Production-grade engineering quality audit — the final gate before shipping.**

| Component | Description |
|-----------|-------------|
| `/production-audit:audit` | Start or resume a production readiness audit |
| `/production-audit:report` | Generate audit report from findings |
| `/production-audit:status` | Check current audit progress |
| 7 specialized agents | Code architecture, testing, performance, operations, best-practice research, orchestrator, memory |

Covers code quality, architecture, testing, performance, operations readiness, and feature-specific best practices via HyDE-powered research. Complements sraa-compliance for non-security engineering concerns.

## Plugin Pairing

The **sraa-compliance** and **production-audit** plugins are designed as complementary audit tools:

| Concern | Plugin |
|---------|--------|
| Security compliance (OWASP, encryption, access control) | sraa-compliance |
| Engineering quality (architecture, testing, performance, ops) | production-audit |

Run both before production deployment for comprehensive coverage.

## Repository Structure

```
continuous-learning-plugins/
├── .claude-plugin/
│   └── marketplace.json
├── README.md
├── learning-vault/
├── anki-flashcards/
├── sraa-compliance/
└── production-audit/
```

Each plugin follows the standard Claude Code plugin layout with `agents/`, `commands/`, `skills/`, and `hooks/` directories.

## License

MIT

## Author

Rocky Hui (rockyhui.operation@gmail.com)
