---
description: Capture a technical concept or learning to your Obsidian vault as a Zettelkasten-style atomic note. Routes to Atlas/ (permanent knowledge) or Efforts/ (project-specific) based on your active efforts.
argument-hint: Concept name (e.g., "Strangler Fig Pattern")
allowed-tools: ["Read", "Grep", "Glob", "Bash", "AskUserQuestion", "mcp__obsidian__write_note", "mcp__obsidian__read_note", "mcp__obsidian__search_notes", "mcp__obsidian__list_directory"]
---

# Learn Command

Capture a technical concept, pattern, or learning to the user's Obsidian vault using Zettelkasten methodology. Notes are routed to `Atlas/` (permanent knowledge) or `Efforts/{name}/` (project-specific) based on the ACE folder framework.

## Process

1. **Parse the concept**: Extract the concept name from `$ARGUMENTS`. If empty, use AskUserQuestion to ask what they want to capture.

2. **Check for existing notes**: Use `mcp__obsidian__search_notes` with the concept name. If similar notes exist, use AskUserQuestion to ask if they want to update existing or create new.

3. **Resolve destination (ACE routing)**:
   - Use `mcp__obsidian__list_directory` on `Efforts/` to discover active effort subfolders.
   - If **no Efforts exist**: destination is `Atlas/`. Skip to step 4.
   - If **Efforts exist**: use AskUserQuestion:
     > "Where should this note live?"
     > Options: **Atlas** (permanent knowledge) | **{Effort 1}** | **{Effort 2}** | ...
   - Set `destination` to `Atlas/` or `Efforts/{Subfolder Name}/` based on the answer.
   - Set `ace_field` to `atlas` or `efforts/{subfolder-name-lowercased-hyphenated}`.

4. **Gather context using AskUserQuestion**: You MUST use the AskUserQuestion tool to ask questions interactively. Ask in batches:

   **First batch** (use AskUserQuestion with these questions):
   - Definition: "What is [concept] in one sentence?"
   - Source: "Where did you learn this?" (options: implementation, reading, discussion, course)

   **Second batch** (use AskUserQuestion):
   - Related: "What concepts should this link to?"
   - Tags: "Suggested tags: [suggestions]. Add or remove any?"

5. **Ask for example**: After the structured questions, ask the user to provide an example from their work (code snippet, implementation detail, etc.)

6. **Create the note**: Use `mcp__obsidian__write_note` to create:
   - **Path**: `{destination}/{Title With Spaces}.md` (e.g., `Atlas/Strangler Fig Pattern.md`)
   - **Content**: Use the template below with user's answers

7. **Confirm creation**: Tell the user the note was created and its full path

## Note Template

```markdown
---
title: {Concept Title}
created: {YYYY-MM-DD}
ace: {atlas|efforts/effort-name}
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
- **Quick capture first**: If the user seems to be in a flow state, remind them that `/learn-quick` exists for fast inbox capture without questions.

## Example Interaction

User: `/learn Strangler Fig Pattern`

1. Check for existing notes about "Strangler Fig"
2. Scan `Efforts/` — finds: "EKS Certification", "MTR Interview Preparation"
   Use AskUserQuestion:
   ```
   "Where should this note live?"
   Options: Atlas (permanent knowledge) | EKS Certification | MTR Interview Preparation
   ```
   User picks: Atlas → destination = `Atlas/`, ace_field = `atlas`
3. Use AskUserQuestion:
   ```
   Question 1: "What is the Strangler Fig Pattern in one sentence?"
   Question 2: "Where did you learn this?"
   Options: Implementation, Reading, Discussion, Course
   ```
4. Use AskUserQuestion:
   ```
   Question: "What concepts should this link to?"
   Question: "Suggested tags: pattern, architecture, migration. Adjust?"
   ```
5. Ask for example code/details
6. Create note at `Atlas/Strangler Fig Pattern.md`
7. Confirm: "Created Atlas/Strangler Fig Pattern.md"
