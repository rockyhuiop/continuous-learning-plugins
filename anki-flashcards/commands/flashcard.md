---
description: Create Anki flashcards from conversation context
argument-hint: [optional description of what to capture]
---

Create Anki flashcards from the current conversation context for spaced repetition learning.

**Workflow:**

1. **Sync with Anki** - Use `mcp__anki__sync` to ensure latest data

2. **Identify learnable content** - Analyze the conversation for valuable learning material:
   - If user provided a description in $ARGUMENTS, focus on that specific content
   - Otherwise, identify technical concepts, code patterns, key insights, problem solutions, or commands learned
   - Look for content that would benefit from spaced repetition review

3. **Determine card format for each piece of content:**
   - **Basic (Q&A)**: For conceptual questions, definitions, "what/why/how" questions
   - **Cloze**: For definitions, facts, syntax patterns (fill-in-the-blank style)
   - **Code**: For code snippets with explanations, syntax examples, command patterns

4. **Get deck selection** - Use `mcp__anki__list_decks` to show available decks, then use `AskUserQuestion` to let user select the target deck

5. **Create the flashcards** using the Anki MCP tools:
   - For Basic cards: Use model "Basic" with "Front" and "Back" fields
   - For Cloze cards: Use model "Cloze" with "Text" field containing {{c1::content}} syntax
   - For Code cards: Use model "Basic" with code on Front, explanation on Back

6. **Sync again** - Use `mcp__anki__sync` after creating cards

7. **Show summary** - Display a brief summary of cards created:
   - Number of cards created
   - Card types used
   - Target deck
   - Brief preview of each card's front/question

**Card Creation Best Practices:**

- Keep cards atomic (one concept per card)
- Use clear, specific questions
- For cloze: highlight the key term to remember ({{c1::term}})
- For code: include minimal context needed to understand
- Add relevant tags based on content (e.g., "python", "git", "architecture")

**Example card formats:**

Basic:
- Front: "What is the purpose of dependency injection?"
- Back: "To decouple object creation from object use, making code more testable and maintainable by passing dependencies as parameters rather than creating them internally."

Cloze:
- Text: "In Python, {{c1::asyncio}} is the standard library for writing asynchronous code using {{c2::coroutines}}."

Code:
- Front: "How to create a virtual environment with uv?"
- Back: "`uv venv` - Creates a new virtual environment in the current directory"
