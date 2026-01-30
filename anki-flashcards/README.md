# Anki Flashcards Plugin

Create Anki flashcards from conversation context for continuous learning with spaced repetition.

## Features

- **`/flashcard` command**: Capture valuable learning content as Anki cards
- **Flashcard reviewer agent**: Reviews created cards for learning effectiveness
- **Multiple card formats**: Basic Q&A, Cloze deletions, Code cards
- **Auto-sync**: Automatically syncs with Anki before and after operations

## Requirements

- [Anki](https://apps.ankiweb.net/) desktop application running
- [AnkiConnect](https://ankiweb.net/shared/info/2055492159) add-on installed
- Anki MCP server configured in Claude Code

## Usage

### Creating Flashcards

```
/flashcard
```

The command will:
1. Analyze the conversation for learnable content
2. Ask you to describe what to capture (or auto-identify)
3. Present available Anki decks for selection
4. Ask for card format preference (Basic, Cloze, or Code)
5. Create the cards and show a summary

### Card Formats

- **Basic**: Simple question on front, answer on back
- **Cloze**: Fill-in-the-blank style for definitions and facts
- **Code**: Code snippet on front, explanation/output on back

## Configuration (Optional)

Create `.claude/anki-flashcards.local.md` in your project to set defaults:

```markdown
# Anki Flashcards Settings

## Default Deck
Claude Learning

## Preferred Format
Basic
```

## Tips for Effective Flashcards

- Keep cards atomic (one concept per card)
- Use clear, specific questions
- Include context when needed
- Prefer cloze for definitions and facts
- Use code cards for syntax and patterns
