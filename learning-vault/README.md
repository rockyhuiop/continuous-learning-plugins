# Learning Vault Plugin

Capture technical learnings from your development work to your Obsidian vault using the Zettelkasten method and the ACE folder framework. Transform fleeting insights into a connected knowledge network routed to the right place automatically.

## Features

| Component | Description |
|-----------|-------------|
| `/learning-vault:learn` | Capture a concept as an atomic Zettelkasten note — routes to Atlas/ or Efforts/ |
| `/learning-vault:learn-quick` | Fast inbox capture to +/ with no questions — process later with `/learn` |
| `/learning-vault:learn-review` | Analyze recent git history to discover learnable concepts |
| `learning-discovery` agent | Suggests patterns, terminology, and techniques from your work |
| `zettelkasten-notes` skill | Guidance on writing effective atomic notes with links |
| `ace-routing` skill | ACE folder routing rules (Atlas, Efforts, + inbox) |

## ACE Folder Framework

Notes are organised using the ACE structure:

| Folder | Purpose |
|--------|---------|
| `Atlas/` | Permanent, reusable reference knowledge (default destination) |
| `Efforts/{name}/` | Project-specific notes tied to a time-bound goal |
| `+/` | Quick capture inbox — process later with `/learn` |
| `Archive/` | Completed efforts (managed manually) |

The `/learn` command automatically scans your `Efforts/` folder and asks where a note belongs. `/learn-quick` always drops to `+/` with no questions.

## Installation

### Option 1: From Marketplace (Recommended)

```bash
claude plugins install learning-vault@rocky-plugins
```

### Option 2: From GitHub

```bash
claude plugins install github:rockyhuiop/learning-vault
```

### Option 3: Manual Installation

1. Clone or copy the plugin to `~/.claude/plugins/learning-vault/`
2. Add to `~/.claude/plugins/installed_plugins.json`:
   ```json
   "learning-vault@local": [
     {
       "scope": "user",
       "installPath": "/Users/YOUR_USERNAME/.claude/plugins/learning-vault",
       "version": "1.0.0",
       "installedAt": "2026-01-28T00:00:00.000Z",
       "lastUpdated": "2026-01-28T00:00:00.000Z"
     }
   ]
   ```
3. Restart Claude Code

## Prerequisites

### 1. Obsidian MCP Server (Required)

Configure the Obsidian MCP server to enable vault access:

```bash
claude mcp add obsidian --scope user -- npx @mauricio.wolff/mcp-obsidian@latest "/path/to/your/vault"
```

### 2. Git Repository (For `/learn-review`)

The review command analyzes git history, so run it from a git repository.

## Usage

### Capture a Concept (full workflow)

```bash
/learning-vault:learn Strangler Fig Pattern
```

This will:
1. Check for existing notes on the topic
2. Scan `Efforts/` and ask: Atlas (permanent) or a specific Effort?
3. Ask Zettelkasten questions (definition, source, related, tags, example)
4. Create the note in `Atlas/` or `Efforts/{name}/`

### Quick Capture (no questions)

```bash
/learning-vault:learn-quick ONNX Runtime
```

This will:
1. Optionally ask for a one-line context note
2. Drop a stub to `+/ONNX Runtime.md` immediately
3. Process it into a full Atlas note later with `/learn ONNX Runtime`

### Review Recent Work

```bash
/learning-vault:learn-review
```

This will:
1. Analyze your last 7 days of git commits
2. Identify patterns, techniques, and terminology
3. Show which vault folder each concept should go to
4. Pre-fill ACE routing when git context matches an active Effort

### Natural Language

You can also ask naturally:
- "What patterns from my recent work should I document?"
- "How should I write good Zettelkasten notes?"

## Note Structure

Full notes (created by `/learn`) use the Zettelkasten template with an `ace` field:

```markdown
---
title: Strangler Fig Pattern
created: 2026-01-28
ace: atlas
project: canpanion-backend
source: implementation
tags:
  - pattern
  - architecture
  - migration
---

## Definition
[One clear sentence defining the concept]

## Context
[Why this matters, when encountered, problem it solves]

## Example
[Code snippet or implementation details from your work]

## Related
- [[Related Concept 1]]
- [[Related Concept 2]]

## Questions
[Open questions or areas to explore further]
```

Inbox stubs (created by `/learn-quick`) are minimal:

```markdown
---
title: ONNX Runtime
created: 2026-02-26
ace: inbox
status: inbox
---

Optional one-line context
```

## Tag Taxonomy

### Architecture Tags
`pattern` `architecture` `migration` `refactoring` `design` `infrastructure` `api` `database`

### Learning Tags
`concept` `terminology` `technique` `lesson-learned` `best-practice` `gotcha` `tool`

## Configuration

Notes are saved to `Atlas/` (permanent knowledge) or `Efforts/{name}/` (project-specific) based on your answer to the routing question. Quick-capture notes land in `+/`. All folders are created automatically on first use.

## Troubleshooting

### Plugin not loading
- Ensure it's registered in `~/.claude/plugins/installed_plugins.json`
- Restart Claude Code after installation

### Obsidian MCP not connected
- Check MCP status: `claude mcp list`
- Verify vault path is correct

### Commands not appearing
- Try `/help` to see all available commands
- Ensure plugin scope is "user" for global access

## License

MIT

## Author

Rocky
