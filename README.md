# Rocky's Plugins

A personal collection of Claude Code plugins for continuous learning, security compliance, and engineering quality.

## Installation

### Add this marketplace

```bash
claude plugins marketplace add github:rockyhuiop/continuous-learning-plugins
```

### Install plugins

```bash
# Learning system (install all four for the full loop)
claude plugins install learning-vault@continuous-learning-plugins
claude plugins install anki-flashcards@continuous-learning-plugins
claude plugins install learning-retrospective@continuous-learning-plugins
claude plugins install concept-challenger@continuous-learning-plugins

# Audit tools
claude plugins install sraa-compliance@continuous-learning-plugins
claude plugins install production-audit@continuous-learning-plugins
```

## The Learning System

Four plugins form an integrated learning loop for developers who learn by building:

```
found problem → discuss → implement → capture by judgment
                                        ├── deep concept → learning-vault
                                        ├── quick fact   → anki-flashcards
                                        └── nothing notable → move on
                                             ↓ (weekly)
                                        learning-retrospective
                                        - what did I learn?
                                        - what's sticking? what's weak?
                                        - what connects? what did I miss?
                                             ↓ (surfaces weak areas)
                                        concept-challenger
                                        - can I APPLY this concept?
                                        - English writing feedback
                                        - gaps feed back into vault/anki
```

### learning-vault

**Capture technical learnings to Obsidian vault using Zettelkasten method.**

| Component | Description |
|-----------|-------------|
| `/learning-vault:learn` | Capture a concept as an atomic Zettelkasten note |
| `/learning-vault:learn-review` | Analyze recent git history to discover learnable concepts |
| `learning-discovery` agent | Suggests patterns and techniques from your work |
| `zettelkasten-notes` skill | Guidance on writing effective atomic notes |

**Requirements:** Obsidian MCP Server

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

### learning-retrospective

**Periodic learning analysis across Obsidian vault, Anki, and git history.**

| Component | Description |
|-----------|-------------|
| `/learning-retro:retro` | Generate a learning digest for a time period (7d/14d/30d) |
| `retro-analyzer` agent | Cross-references vault notes, Anki stats, and git commits |
| `learning-retro` skill | Digest formatting and cross-source analysis guidance |

Surfaces topic clusters, retention gaps, connection suggestions between vault notes, recurring problem signals from git, and uncaptured work areas. Saves digests to Obsidian as `Retros/YYYY-Www.md`.

**Requirements:** Obsidian MCP Server (required), Anki MCP Server (recommended), Git repository

### concept-challenger

**Test concept application through novel scenarios with English writing feedback.**

| Component | Description |
|-----------|-------------|
| `/concept-challenger:challenge` | Challenge yourself on a vault concept (specific, random, or weak areas) |
| `concept-challenge` skill | Scenario design rubrics, evaluation criteria, language rubric |

Picks a concept from your Obsidian vault, generates a realistic problem in a different domain, and evaluates your response in three sections: concept application rating (Strong/Adequate/Needs Review), English language review with grammar and technical writing feedback, and a revised version of your answer with annotated improvements.

**Requirements:** Obsidian MCP Server (required), Anki MCP Server (optional, for weak-area selection)

## Audit Tools

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

**Production-grade engineering quality audit -- the final gate before shipping.**

| Component | Description |
|-----------|-------------|
| `/production-audit:audit` | Start or resume a production readiness audit |
| `/production-audit:report` | Generate audit report from findings |
| `/production-audit:status` | Check current audit progress |
| 7 specialized agents | Code architecture, testing, performance, operations, best-practice research, orchestrator, memory |

Covers code quality, architecture, testing, performance, operations readiness, and feature-specific best practices. Complements sraa-compliance for non-security engineering concerns.

### Audit pairing

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
├── learning-vault/            ← capture deep concepts
├── anki-flashcards/           ← capture quick facts
├── learning-retrospective/    ← periodic analysis
├── concept-challenger/        ← application testing
├── sraa-compliance/           ← security audit
├── production-audit/          ← engineering audit
└── docs/plans/                ← design documents
```

Each plugin follows the standard Claude Code plugin layout with `agents/`, `commands/`, and `skills/` directories.

## License

MIT

## Author

Rocky Hui (rockyhui.operation@gmail.com)
