# learning-retrospective

Periodic learning analysis across Obsidian vault, Anki, and git history.

## What it does

Generates a learning digest that cross-references three data sources to answer:

- **What did I learn?** Topic clusters from vault notes
- **Am I retaining it?** Anki review stats with flagged weak areas
- **What connects?** Vault notes that should link to each other
- **Where am I struggling?** Recurring fix commits by problem area
- **What did I miss?** Git activity with no vault notes

## Usage

```
/learning-retrospective:retro           # Default: last 7 days, all decks
/learning-retrospective:retro 14d       # Last 14 days
/learning-retrospective:retro 30d       # Last 30 days
/learning-retrospective:retro --deck Japanese    # Filter to specific Anki deck
/learning-retrospective:retro 14d --deck CS      # Combine period and deck filter
```

The digest can optionally be saved to `Retros/YYYY-Www.md` in your Obsidian vault.

## Prerequisites

| Dependency | Required? | Purpose |
|------------|-----------|---------|
| Obsidian MCP Server | Yes | Read vault notes, save digests |
| Anki MCP Server | Recommended | Retention analysis (degrades gracefully without it) |
| Git repository | Yes | Problem signals and uncaptured work detection |
| Existing vault notes | Recommended | More notes = more useful analysis |

## Components

- **Command**: `retro.md` — Entry point, dispatches agent, presents digest
- **Agent**: `retro-analyzer` (Sonnet) — Gathers data from 3 sources, cross-references
- **Skill**: `learning-retro` — Digest format knowledge and quality standards

## Part of the Continuous Learning System

```
learning-vault → capture concepts
anki-flashcards → reinforce with spaced repetition
learning-retrospective → analyze patterns and gaps ← this plugin
concept-challenger → test application
```
