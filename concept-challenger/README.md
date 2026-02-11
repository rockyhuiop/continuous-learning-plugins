# Concept Challenger Plugin

Test whether you can apply learned concepts to novel scenarios. Combines concept comprehension testing with English technical writing feedback.

## Features

| Component | Description |
|-----------|-------------|
| `/concept-challenger:challenge` | Interactive challenge workflow: select concept, generate scenario, evaluate response |
| `concept-challenge` skill | Scenario design methodology and evaluation rubrics |

## Installation

### Option 1: From Marketplace

```bash
claude plugins install concept-challenger@continuous-learning-plugins
```

### Option 2: Manual Installation

1. Clone or copy the plugin to `~/.claude/plugins/concept-challenger/`
2. Add to `~/.claude/plugins/installed_plugins.json`
3. Restart Claude Code

## Prerequisites

### 1. Obsidian MCP Server (Required)

The plugin reads concepts from your Obsidian vault's `Knowledge/` folder and saves challenge history to `Challenges/`.

```bash
claude mcp add obsidian --scope user -- npx @mauricio.wolff/mcp-obsidian@latest "/path/to/your/vault"
```

### 2. Existing Vault Notes (Required)

You need at least one concept note in `Knowledge/` to challenge on. Use `/learning-vault:learn` to create notes.

### 3. Anki MCP Server (Optional)

Enables the "weak areas" selection mode, which picks concepts based on low Anki retention rates.

## Usage

### Challenge a Specific Concept

```bash
/concept-challenger:challenge Circuit Breaker
```

### Random Concept

```bash
/concept-challenger:challenge random
```

### Focus on Weak Areas

```bash
/concept-challenger:challenge weak
```

Selects concepts linked to Anki tags with retention below 70%.

### Interactive Selection

```bash
/concept-challenger:challenge
```

Prompts you to choose between random, weak areas, or a specific topic.

## How It Works

1. **Concept selected** from your Obsidian vault
2. **Novel scenario generated** in a different domain from your vault note's example
3. **You write your response** explaining how to apply the concept
4. **Three-section evaluation**:
   - **Concept**: Strong / Adequate / Needs Review rating with specific feedback
   - **Language**: Grammar corrections, technical writing quality, vocabulary suggestions
   - **Revised version**: Your response rewritten with improvements bolded and annotated
5. **Follow-up options**: harder scenario, save history, capture gaps, create flashcard

## Challenge History

Past challenges are saved to `Challenges/{concept-name}.md` in your Obsidian vault, tracking domain, difficulty, rating, and language improvements over time. This prevents domain repetition and shows your progress.

## Difficulty Levels

| Level | Description |
|-------|-------------|
| **Basic** (default) | Concept named in the question. "How would you apply [concept] here?" |
| **Intermediate** | Concept not named. "How would you redesign this system?" |
| **Advanced** | Multiple concepts relevant. "What architectural changes would you recommend?" |

## Integration

Part of the [continuous-learning-plugins](../) ecosystem:

- **learning-vault**: Source of concepts to challenge on
- **anki-flashcards**: Create cards for insights from challenges
- **learning-retrospective**: Surfaces weak areas to challenge

## License

MIT

## Author

Roc
