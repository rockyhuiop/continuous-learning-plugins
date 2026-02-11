---
description: Analyze your recent learning activity across vault, Anki, and git
argument-hint: [period: 7d|14d|30d] [--deck DeckName]
allowed-tools: ["Read", "Grep", "Glob", "Bash", "AskUserQuestion", "Task",
  "mcp__obsidian__search_notes", "mcp__obsidian__read_note",
  "mcp__obsidian__list_directory", "mcp__obsidian__write_note",
  "mcp__anki__collection_stats", "mcp__anki__review_stats",
  "mcp__anki__findNotes", "mcp__anki__getTags",
  "mcp__anki__deckActions"]
---

# Learning Retrospective

Generate a periodic learning digest by analyzing activity across the Obsidian vault, Anki spaced repetition data, and git commit history.

## Process

### 1. Parse Arguments

Extract the time period and optional deck filter from `$ARGUMENTS`:

- **Period**: Accept `7d` (default), `14d`, or `30d`. If unrecognized, default to `7d` and inform the user.
- **Deck filter**: If `--deck DeckName` is present, pass that deck name to the retro-analyzer agent. Otherwise, the agent queries all decks.

Compute the start date by subtracting the period from today's date.

### 2. Check MCP Availability

Verify data sources are reachable:

- **Obsidian MCP**: Try `mcp__obsidian__list_directory` on `/`. If it fails, stop and show:
  > Obsidian MCP server is not available. This plugin requires the Obsidian MCP server to function.
  > Setup: Add an Obsidian MCP server to your `.mcp.json` configuration.

- **Anki MCP**: Try `mcp__anki__deckActions` with `listDecks`. If it fails, warn:
  > Anki MCP server is not available. The retrospective will proceed without retention analysis.
  > Setup: Install the Anki MCP server for spaced repetition tracking.
  Set a flag to skip Anki-related analysis sections.

### 3. Dispatch retro-analyzer Agent

Use the Task tool to launch the `retro-analyzer` agent with a prompt containing:
- The computed time period and start date
- The deck filter (if any), or "all decks"
- Whether Anki MCP is available
- The current working directory (for git log)

Wait for the agent to return its structured analysis.

### 4. Present the Digest

Display the agent's analysis in conversation using this structure:

```
## Learning Retrospective — [start date] to [today]

### Topic Clusters
[Grouped learning topics with vault note counts and evidence]

### Retention Check
[Anki review stats, flagged weak areas — or "Skipped: Anki not available"]

### Connection Suggestions
[Vault notes that should be linked but aren't]

### Problem Signals
[Git fix: commit clusters — or "No significant fix patterns detected"]

### Uncaptured Work
[Suggestion to run /learning-vault:learn-review if significant git activity
has no corresponding vault notes]
```

Follow the digest format defined in the `learning-retro` skill's `references/digest-format.md` for quality standards and section formatting.

### 5. Offer to Save

Use `AskUserQuestion` to ask:

**Question**: "Save this digest to your Obsidian vault?"
**Options**:
- "Save to Retros/" — Save as `Retros/YYYY-Www.md` using ISO week number
- "Don't save" — End the retrospective

### 6. Save Digest (if requested)

If saving:
1. Check if `Retros/` folder exists via `mcp__obsidian__list_directory`. If not, it will be created with the first note.
2. Compute the ISO week filename: `YYYY-Www.md` (e.g., `2026-W07.md`)
3. Write the digest to Obsidian via `mcp__obsidian__write_note` with:
   - **Path**: `Retros/YYYY-Www.md`
   - **Frontmatter**:
     ```yaml
     type: retrospective
     date: YYYY-MM-DD
     period: 7d|14d|30d
     note_count: [number of vault notes in period]
     card_count: [number of Anki cards reviewed in period]
     ```
   - **Content**: The full digest in markdown

Confirm the save location to the user.

## Guidelines

- **Do NOT duplicate learn-review**: If git activity suggests uncaptured learnings, suggest running `/learning-vault:learn-review` rather than listing individual commits.
- **Graceful degradation**: If Anki is unavailable, produce the digest without retention sections. Never fail silently — always explain what was skipped and why.
- **Be concise**: The digest should be scannable. Use bullet points and short paragraphs. Detailed evidence belongs in the saved note, not the conversation summary.
