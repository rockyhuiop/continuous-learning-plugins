---
description: Capture a technical concept or learning to your Obsidian Knowledge vault as a Zettelkasten-style atomic note
argument-hint: Concept name (e.g., "Strangler Fig Pattern")
allowed-tools: ["Read", "Grep", "Glob", "Bash", "AskUserQuestion", "mcp__obsidian__write_note", "mcp__obsidian__read_note", "mcp__obsidian__search_notes", "mcp__obsidian__list_directory"]
---

# Learn Command

Capture a technical concept, pattern, or learning to the user's Obsidian Knowledge vault using Zettelkasten methodology.

## Process

1. **Parse the concept**: Extract the concept name from `$ARGUMENTS`. If empty, ask the user what they want to capture.

2. **Ensure Knowledge folder exists**: Use `mcp__obsidian__list_directory` to check if `Knowledge/` folder exists. If not, inform user it will be created with the first note.

3. **Check for existing notes**: Search the Knowledge folder for notes about this concept to avoid duplicates:
   - Use `mcp__obsidian__search_notes` with the concept name
   - If similar notes exist, inform the user and ask if they want to:
     - Update the existing note
     - Create a new note with different angle
     - Cancel

4. **Gather context**: Ask the user targeted questions to build the note:
   - What is this concept in one sentence? (Definition)
   - Where did you encounter this / why does it matter? (Context)
   - Can you share an example from your work? (Example)
   - What related concepts should this link to? (Related)

5. **Generate unique note ID**: Create timestamp-based ID:
   - Format: `YYYYMMDDHHMM` (e.g., `202601281430`)
   - Use current date/time

6. **Determine tags**: Based on the concept, suggest appropriate tags from the taxonomy:
   - **Architecture**: `pattern`, `architecture`, `migration`, `refactoring`, `design`, `infrastructure`, `api`, `database`
   - **Learning**: `concept`, `terminology`, `technique`, `lesson-learned`, `best-practice`, `gotcha`, `tool`
   - Present suggestions to user and let them add/remove

7. **Create the note**: Use `mcp__obsidian__write_note` to create the note:
   - Path: `Knowledge/{id}-{kebab-case-title}.md`
   - Content: Use the comprehensive Zettelkasten template below

8. **Confirm creation**: Tell the user the note was created and its path

## Note Template

```markdown
---
id: {timestamp}
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

## Guidelines

- **Atomic notes**: Each note covers ONE concept. If user describes multiple, suggest creating separate notes.
- **Use their words**: Capture the user's understanding, not textbook definitions. This is their learning.
- **Link liberally**: Encourage links to existing notes and suggest potential future notes.
- **Project context**: Extract project name from current working directory for the `project` field.
- **Source field**: Ask where they learned this (implementing code, reading docs, discussion, course).

## Example Interaction

User: `/learn Strangler Fig Pattern`

Assistant should:
1. Search for existing notes about "Strangler Fig"
2. Ask: "What's your one-sentence definition of the Strangler Fig Pattern?"
3. Ask: "Where did you encounter this? What problem does it solve in your context?"
4. Ask: "Can you share a brief example from your work?"
5. Ask: "What concepts should this link to? (e.g., Legacy Migration, Incremental Refactoring)"
6. Suggest tags: `pattern`, `architecture`, `migration`
7. Create note at `Knowledge/202601281430-strangler-fig-pattern.md`
8. Confirm: "Created note: Strangler Fig Pattern. You can find it in your Knowledge folder."
