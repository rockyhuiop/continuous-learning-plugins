---
description: Capture a technical concept or learning to your Obsidian Knowledge vault as a Zettelkasten-style atomic note
argument-hint: Concept name (e.g., "Strangler Fig Pattern")
allowed-tools: ["Read", "Grep", "Glob", "Bash", "AskUserQuestion", "mcp__obsidian__write_note", "mcp__obsidian__read_note", "mcp__obsidian__search_notes", "mcp__obsidian__list_directory"]
---

# Learn Command

Capture a technical concept, pattern, or learning to the user's Obsidian Knowledge vault using Zettelkasten methodology.

## Process

1. **Parse the concept**: Extract the concept name from `$ARGUMENTS`. If empty, use AskUserQuestion to ask what they want to capture.

2. **Ensure Knowledge folder exists**: Use `mcp__obsidian__list_directory` to check if `Knowledge/` folder exists. If not, inform user it will be created with the first note.

3. **Check for existing notes**: Use `mcp__obsidian__search_notes` with the concept name. If similar notes exist, use AskUserQuestion to ask if they want to update existing or create new.

4. **Gather context using AskUserQuestion**: You MUST use the AskUserQuestion tool to ask questions interactively. Ask in batches:

   **First batch** (use AskUserQuestion with these questions):
   - Definition: "What is [concept] in one sentence?"
   - Source: "Where did you learn this?" (options: implementation, reading, discussion, course)

   **Second batch** (use AskUserQuestion):
   - Related: "What concepts should this link to?"
   - Tags: "Suggested tags: [suggestions]. Add or remove any?"

5. **Ask for example**: After the structured questions, ask the user to provide an example from their work (code snippet, implementation detail, etc.)

6. **Create the note**: Use `mcp__obsidian__write_note` to create:
   - **Path**: `Knowledge/{Title With Spaces}.md` (e.g., `Knowledge/Strangler Fig Pattern.md`)
   - **Content**: Use the template below with user's answers

7. **Confirm creation**: Tell the user the note was created and its path

## Note Template

```markdown
---
title: {Concept Title}
created: {YYYY-MM-DD}
project: {current project name from working directory}
source: {implementation|reading|discussion|course}
tags:
  - {tag1}
  - {tag2}
---

## Definition

{One clear sentence defining the concept}

## Context

{Why this matters, when encountered, problem it solves}

## Example

{Code snippet or implementation details from their work}

## Related

- [[{Related Concept 1}]]
- [[{Related Concept 2}]]

## Questions

{Open questions or areas to explore further - can be empty}
```

## Tag Taxonomy

Suggest tags from these categories:
- **Architecture**: `pattern`, `architecture`, `migration`, `refactoring`, `design`, `infrastructure`, `api`, `database`
- **Learning**: `concept`, `terminology`, `technique`, `lesson-learned`, `best-practice`, `gotcha`, `tool`

## Guidelines

- **MUST use AskUserQuestion**: Do NOT just print questions as text. Use the AskUserQuestion tool for interactive Q&A.
- **Filename**: Use the exact title with spaces, e.g., `Claude Plugin Skills.md`, NOT kebab-case or timestamp IDs.
- **Atomic notes**: Each note covers ONE concept. If user describes multiple, suggest creating separate notes.
- **Use their words**: Capture the user's understanding, not textbook definitions.
- **Link liberally**: Encourage links to existing notes and suggest potential future notes.

## Example Interaction

User: `/learn Strangler Fig Pattern`

1. Check for existing notes about "Strangler Fig"
2. Use AskUserQuestion:
   ```
   Question 1: "What is the Strangler Fig Pattern in one sentence?"
   Options: [suggested definitions] + Other

   Question 2: "Where did you learn this?"
   Options: Implementation, Reading, Discussion, Course
   ```
3. Use AskUserQuestion:
   ```
   Question: "What concepts should this link to?"
   Options: Legacy Migration, Feature Flags, Incremental Refactoring + Other

   Question: "Suggested tags: pattern, architecture, migration. Adjust?"
   Options: Use suggested, Add more, Remove some
   ```
4. Ask for example code/details
5. Create note at `Knowledge/Strangler Fig Pattern.md`
6. Confirm: "Created note: Strangler Fig Pattern"
