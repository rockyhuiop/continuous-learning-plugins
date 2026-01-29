# Learning Vault Plugin

Capture technical learnings from your development work to your Obsidian vault using the Zettelkasten method. Transform fleeting insights into a connected knowledge network.

## Features

| Component | Description |
|-----------|-------------|
| `/learning-vault:learn` | Capture a concept as an atomic Zettelkasten note |
| `/learning-vault:learn-review` | Analyze recent git history to discover learnable concepts |
| `learning-discovery` agent | Suggests patterns, terminology, and techniques from your work |
| `zettelkasten-notes` skill | Guidance on writing effective atomic notes with links |

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

### Capture a Concept

```bash
/learning-vault:learn Strangler Fig Pattern
```

This will:
1. Check for existing notes on the topic
2. Ask you questions about the concept
3. Create a Zettelkasten note in your `Knowledge/` folder

### Review Recent Work

```bash
/learning-vault:learn-review
```

This will:
1. Analyze your last 7 days of git commits
2. Identify patterns, techniques, and terminology
3. Suggest concepts worth documenting

### Natural Language

You can also ask naturally:
- "What patterns from my recent work should I document?"
- "How should I write good Zettelkasten notes?"

## Note Structure

Notes are created with a comprehensive Zettelkasten template:

```markdown
---
id: 202601281430
title: Strangler Fig Pattern
created: 2026-01-28
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

## Tag Taxonomy

### Architecture Tags
`pattern` `architecture` `migration` `refactoring` `design` `infrastructure` `api` `database`

### Learning Tags
`concept` `terminology` `technique` `lesson-learned` `best-practice` `gotcha` `tool`

## Configuration

Notes are saved to the `Knowledge/` folder in your Obsidian vault. The folder is created automatically with your first note.

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
