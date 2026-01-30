---
name: anki-flashcard-creation
description: This skill should be used when the user asks to "create a flashcard", "make an Anki card", "capture this for learning", "add to Anki", "create spaced repetition cards", or when using the /flashcard command. Provides guidance on creating effective flashcards that maximize retention through spaced repetition.
version: 1.0.0
---

# Anki Flashcard Creation

## Overview

Effective flashcards are the foundation of successful spaced repetition learning. This skill provides guidance on creating cards that maximize long-term retention while minimizing review time.

## Core Principles

### Atomic Notes

Each flashcard should test exactly one concept. This principle is fundamental:

**Good (atomic):**
- Card 1: "What does `git rebase` do?" → "Replays commits from one branch onto another"
- Card 2: "When should you avoid `git rebase`?" → "On shared/public branches that others have pulled"

**Bad (non-atomic):**
- "What is `git rebase` and when should you use it?" → [Long answer covering multiple concepts]

Split complex topics into multiple cards. More cards = better learning when each tests one thing.

### Active Recall

Cards should prompt retrieval, not recognition. The question should make the brain work:

**Good (active recall):**
- "What HTTP status code indicates 'Not Found'?" → "404"

**Bad (recognition):**
- "Is 404 the HTTP code for 'Not Found'? Yes/No" → "Yes"

### Minimum Information

Keep cards as simple as possible while remaining accurate:

**Good:**
- "Python list method to add item to end?" → "`append()`"

**Verbose (harder to remember):**
- "What is the Python list method that allows you to add a single item to the end of a list, modifying the list in place?" → "`append(item)`"

## Card Formats

### Basic (Question & Answer)

Best for: Concepts, definitions, "what/why/how" questions

```
Front: What is dependency injection?
Back: A design pattern where dependencies are passed to objects rather than created internally, improving testability and decoupling.
```

**When to use:**
- Explaining concepts
- Defining terms
- Answering "why" questions
- Process descriptions

### Cloze Deletions

Best for: Facts, definitions with key terms, syntax patterns

```
Text: In JavaScript, {{c1::async/await}} is syntactic sugar over {{c2::Promises}}.
```

This creates two cards:
1. "In JavaScript, [...] is syntactic sugar over Promises." → "async/await"
2. "In JavaScript, async/await is syntactic sugar over [...]." → "Promises"

**Cloze syntax:**
- `{{c1::term}}` - First cloze (hides "term")
- `{{c2::another term}}` - Second cloze (separate card)
- Same number = same card: `{{c1::word1}} and {{c1::word2}}`

**When to use:**
- Definitions with key terms
- Fill-in-the-blank facts
- Syntax patterns
- Lists of related items

### Code Cards

Best for: Syntax, commands, code patterns

```
Front: Python: Read entire file to string
Back:
with open('file.txt', 'r') as f:
    content = f.read()
```

**When to use:**
- Command syntax
- API patterns
- Common code snippets
- Tool usage

## Creating Cards from Context

### Identifying Learnable Content

Look for content that benefits from spaced repetition:

1. **New concepts explained** - Technical terms, design patterns, principles
2. **Code patterns shown** - Syntax, API usage, common idioms
3. **Problem solutions** - Debugging approaches, fixes, workarounds
4. **Commands learned** - CLI tools, shortcuts, configurations
5. **Key insights** - Best practices, gotchas, important distinctions

### Extraction Process

1. **Identify the core insight** - What's the one thing to remember?
2. **Formulate as question** - How would you ask about this during review?
3. **Craft minimal answer** - Shortest complete answer
4. **Choose format** - Basic/Cloze/Code based on content type
5. **Add tags** - Categorize by topic, language, project

## Tags Strategy

Tags help organize and filter cards:

**Recommended tag patterns:**
- Language/tool: `python`, `git`, `docker`
- Topic: `testing`, `architecture`, `security`
- Source: `claude-learning`, `project-x`
- Difficulty: `beginner`, `advanced`

## Quality Checklist

Before creating a card, verify:

- [ ] Tests exactly one concept (atomic)
- [ ] Question prompts active recall
- [ ] Answer is concise but complete
- [ ] Card makes sense in isolation (has context)
- [ ] Appropriate format chosen (Basic/Cloze/Code)
- [ ] Relevant tags added

## Common Mistakes

### Mistake: Too Much in One Card

**Problem:** "Explain Python decorators including syntax, use cases, and common examples"

**Solution:** Split into 3+ cards:
1. "What is a Python decorator?" → "A function that wraps another function to extend its behavior"
2. "Python decorator syntax?" → `@decorator_name` above function definition
3. "Common use case for decorators?" → "Logging, timing, authentication"

### Mistake: Hiding Wrong Words in Cloze

**Problem:** "{{c1::The}} Python interpreter runs code line by line"

**Solution:** "The Python {{c1::interpreter}} runs code {{c2::line by line}}"

Hide the meaningful content, not articles or filler words.

### Mistake: Cards Without Context

**Problem:** "What does it do?" → "Reverses the list"

**Solution:** "Python: What does `list.reverse()` do?" → "Reverses the list in place"

Cards should be understandable without remembering the conversation.

## Integration with Anki MCP

### Available Note Types

- **Basic**: Fields: `Front`, `Back`
- **Basic (and reversed card)**: Creates forward and reverse cards
- **Cloze**: Fields: `Text`, `Extra` (optional)

### Creating Cards via MCP

Use `mcp__anki__addNote` with appropriate model and fields:

```json
{
  "deckName": "Target Deck",
  "modelName": "Basic",
  "fields": {
    "Front": "Question here",
    "Back": "Answer here"
  },
  "tags": ["tag1", "tag2"]
}
```

### Syncing

Always sync before and after card operations:
- Before: Ensures latest deck list and card states
- After: Pushes new cards to AnkiWeb for cross-device access
