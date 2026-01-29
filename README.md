# Rocky's Plugins

A personal collection of Claude Code plugins for knowledge management and development workflows.

## Installation

### Add this marketplace

```bash
claude plugins marketplace add github:rockyhuiop/rocky-plugins
```

### Install plugins

```bash
# Install learning-vault
claude plugins install learning-vault@rocky-plugins
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

**Requirements:**
- Obsidian MCP Server configured in Claude Code

```bash
claude mcp add obsidian --scope user -- npx @mauricio.wolff/mcp-obsidian@latest "/path/to/vault"
```

## Creating Your Own Marketplace

This repository follows the Claude Code marketplace structure:

```
rocky-plugins/
├── marketplace.json      # Plugin registry
├── README.md
├── learning-vault/       # Plugin 1
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── commands/
│   ├── agents/
│   └── skills/
└── future-plugin/        # Plugin 2
    └── ...
```

## License

MIT

## Author

Rocky (rockyhuiop@gmail.com)
