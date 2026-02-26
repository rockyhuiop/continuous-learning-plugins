---
description: Quickly capture a concept to the + inbox without Zettelkasten questions. Process it later with /learn.
argument-hint: Concept name (e.g., "ONNX Runtime")
allowed-tools: ["AskUserQuestion", "mcp__obsidian__write_note", "mcp__obsidian__list_directory"]
---

# Learn Quick Command

Fast-capture a concept to the `+/` inbox with minimal friction. No Zettelkasten questions — just a titled stub with optional one-line context. Process it into a full Atlas note later with `/learn`.

## Process

1. **Parse the concept name** from `$ARGUMENTS`. If empty, use AskUserQuestion:
   > "What concept do you want to capture?"

2. **Ask for optional context** (one question, keep it fast):
   Use AskUserQuestion:
   > "Any quick context to add? (press Enter to skip)"

3. **Create the stub note** using `mcp__obsidian__write_note`:
   - **Path**: `+/{Title}.md`
   - **Content**: Use the stub template below

4. **Confirm** to the user:
   > "Captured to +/{Title}.md — run `/learn {Title}` when ready to process it."

## Stub Template

```markdown
---
title: {Concept Title}
created: {YYYY-MM-DD}
ace: inbox
status: inbox
---

{Optional one-line context, or leave blank}
```

## Guidelines

- **No Zettelkasten questions** — definition, related, tags, example are all deferred.
- **No routing question** — inbox notes always land in `+/`. Routing happens at `/learn` time.
- **Speed is the priority** — this command should complete in under 30 seconds.
- If `+/` does not exist, Obsidian will create it with the first note.
