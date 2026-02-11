---
description: Test your understanding of a concept with a novel scenario and get English writing feedback
argument-hint: [concept name or "random" or "weak"]
allowed-tools: ["Read", "Grep", "Glob", "AskUserQuestion",
  "mcp__obsidian__search_notes", "mcp__obsidian__read_note",
  "mcp__obsidian__list_directory",
  "mcp__obsidian__read_multiple_notes",
  "mcp__obsidian__write_note",
  "mcp__anki__review_stats", "mcp__anki__findNotes",
  "mcp__anki__deckActions"]
---

# Concept Challenge

Test whether the user can apply a learned concept to a novel scenario. Evaluate both concept understanding and English technical writing quality.

## Prerequisites Check

Before starting, verify Obsidian MCP is available by calling `mcp__obsidian__list_directory` for the root `/`. If it fails, stop and show:

> Obsidian MCP server is not connected. This plugin requires access to your Obsidian vault.
> Set up the Obsidian MCP server, then try again.

## Step 1: Select Concept

Parse `$ARGUMENTS` to determine concept selection mode:

- **Concept name provided** (e.g., `Circuit Breaker`): Search vault with `mcp__obsidian__search_notes` for notes in `Knowledge/` matching the argument. If no match found, list available notes and ask user to pick one.

- **`random`**: List notes in `Knowledge/` using `mcp__obsidian__list_directory` with path `Knowledge/`. Pick one pseudo-randomly -- use the current minute value to vary selection (e.g., index = minute % total_notes). Show which concept was selected.

- **`weak`**: Check if Anki MCP is available by calling `mcp__anki__deckActions` with action `listDecks`. If available, use `mcp__anki__review_stats` to find tags with retention below 70%. Search vault for notes matching those weak tags. If Anki is unavailable, inform user and fall back to random selection.

- **Empty** (no arguments): Use `AskUserQuestion` with options:
  - "Random concept" -- pick randomly from vault
  - "Weak areas" -- select from low-retention Anki topics
  - "Specific topic" -- let user type a concept name (via Other)

## Step 2: Read the Concept

Read the selected vault note using `mcp__obsidian__read_note`. Extract:
- **Definition**: The core concept definition
- **Context**: When and why it matters
- **Example**: The code/implementation example used in the note
- **Related concepts**: Linked notes (`[[...]]` references)
- **Tags**: From frontmatter

If the note is empty or malformed, inform user and suggest running `/learning-vault:learn` to create a proper note first.

## Step 3: Check Challenge History

Search for an existing challenge history file at `Challenges/{concept-name}.md` using `mcp__obsidian__read_note`. This path uses the note's title (e.g., `Challenges/Circuit Breaker.md`).

- If the file exists: read past scenarios to avoid repeating domains or similar problem setups.
- If not found: this is the first challenge for this concept. Proceed normally.

## Step 4: Generate Scenario

Create a novel scenario following the rubric in the skill's `references/scenario-design.md`. Key rules:

**Domain selection**: Pick from this pool, EXCLUDING:
1. The domain used in the vault note's example
2. Any domains used in past challenges for this concept

Domain pool: IoT, healthcare, fintech, e-commerce, social media, gaming, logistics, education, media streaming, manufacturing.

**Difficulty** (default to basic unless user requests otherwise):
- **Basic**: Name the concept in the question. "How would you apply [concept] here?"
- **Intermediate**: Don't name the concept. "How would you redesign this system?"
- **Advanced**: Present a scenario where 2-3 vault concepts are relevant.

**Scenario structure**:
- Context (2-3 sentences setting up the situation)
- Problem statement (1-2 sentences describing what needs solving)
- Constraint or complication (1 sentence adding realistic difficulty)
- Question prompt (what the user should explain)

## Step 5: Present and Wait

Present the scenario clearly, then add:

> Take your time to write your response. Explain your approach as if writing to a senior engineer. When you're ready, type your answer.

**CRITICAL: STOP HERE. Do NOT generate any evaluation until the user submits their response.** Wait for the user's next message.

## Step 6: Evaluate Response

After receiving the user's answer, evaluate in three sections.

### Section A -- Concept Evaluation

Rate as **Strong**, **Adequate**, or **Needs Review** using criteria from `references/evaluation-rubric.md`:

- **Strong**: Correctly applies the concept, identifies trade-offs specific to the scenario, connects to related concepts from vault
- **Adequate**: Correct application but misses trade-offs or connections
- **Needs Review**: Misapplies the concept, only recites definition without application, or confuses with a different concept

Provide specific feedback referencing what the user wrote. Quote their words when praising or correcting.

### Section B -- Language Review

Following the rubric in `references/language-rubric.md`, evaluate:

1. **Grammar corrections**: List specific errors with rule names (e.g., "subject-verb agreement: 'causes' not 'will causes'")
2. **Technical writing quality**: Evaluate argument structure, transition usage, precision, conciseness
3. **Vocabulary**: Note good technical vocabulary; suggest improvements for vague/informal phrasing
4. **Positive reinforcement**: Explicitly call out what was done well before corrections

### Section C -- Revised Version

Rewrite the user's response with improvements:
- **Bold** all changed words/phrases
- Add brief parenthetical annotations for significant changes
- Keep the revised version within **1.5x the length** of the original
- Preserve the user's ideas and structure -- improve expression, not content

## Step 7: Follow-Up Actions

After the evaluation, use `AskUserQuestion` with these options:

- "Try a harder scenario for this concept" -- restart from Step 4 with next difficulty level
- "Save this challenge to history" -- save to Obsidian (see Step 8)
- "Capture a learning gap" -- suggest running `/learning-vault:learn` to note something this challenge exposed
- "Create an Anki card" -- suggest running `/anki-flashcards:flashcard` for a specific insight
- "Done" -- end the challenge

## Step 8: Save Challenge History

If user chose to save, append to `Challenges/{concept-name}.md` in Obsidian using `mcp__obsidian__write_note` with mode `append`.

If the file doesn't exist yet, create it with this header:

```markdown
---
title: "Challenges: {Concept Name}"
type: challenge-history
concept: "[[{Concept Name}]]"
---

# Challenge History: {Concept Name}
```

Then append a new entry:

```markdown

## {YYYY-MM-DD} -- {Domain}

**Difficulty**: {basic|intermediate|advanced}
**Rating**: {Strong|Adequate|Needs Review}
**Scenario summary**: {1-2 sentence summary of the scenario}
**Key language improvements**: {2-3 notable grammar or writing improvements noted}
```

## Guidelines

- **Be encouraging**: Start evaluation with what the user did well before corrections.
- **Be specific**: Quote the user's words when giving feedback. Don't give generic advice.
- **Don't lecture**: Keep Section A focused on this specific scenario, not a textbook explanation.
- **Language feedback is a bonus, not a judgment**: Frame grammar corrections as helpful tips for technical writing, not as errors to be ashamed of.
- **Respect the user's ideas**: In the revised version, improve how they express ideas, never change what ideas they express.
