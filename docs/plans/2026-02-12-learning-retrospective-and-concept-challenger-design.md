# Design: Learning Retrospective & Concept Challenger Plugins

**Date**: 2026-02-12
**Status**: Design approved, pending implementation
**Author**: Roc + Claude

## Background

### Current Learning System

Two existing plugins support a continuous learning workflow during vibe coding:

```
found problem → discuss solutions → implement → capture by judgment
                                                  ├── deep concept → learning-vault (sometimes + anki)
                                                  ├── quick fact/syntax → anki only
                                                  └── nothing notable → move on
```

- **learning-vault**: Captures deep concepts as Zettelkasten notes in Obsidian. Commands: `/learn` (capture one concept), `/learn-review` (scan git for learnable concepts). Agent: `learning-discovery` (analyze git history).
- **anki-flashcards**: Creates spaced repetition flashcards. Command: `/flashcard`. Agent: `flashcard-reviewer` (quality check).

### What's Missing

1. **No feedback loop**: Knowledge flows one direction (capture → store). No periodic analysis of what's sticking, what's weak, or what connects.
2. **No application testing**: Anki tests recall ("do you remember this?"). Vault captures understanding at the moment of learning. Nothing tests whether you can *apply* a concept to a novel problem.
3. **No English language practice integration**: Technical explanations in English are a high-value skill for non-native developers, but there's no structured feedback mechanism.

### Design Decisions

- **Vault is the primary concept source**. Anki-only cards are secondary and won't be individually visible to the new plugins (but Anki aggregate stats are used for retention analysis). This keeps the system simple.
- **No overlap with learn-review**. The retrospective references `/learn-review` for discovering uncaptured work rather than duplicating its git-scanning logic.
- **Problem pattern tracking is merged into the retrospective** as a lightweight git signal, not a separate plugin. A standalone problem tracker adds friction without sufficient ROI for this workflow.

---

## Plugin 1: `learning-retrospective`

### Purpose

Periodic bird's-eye analysis of learning activity across Obsidian vault, Anki, and git to surface patterns, retention gaps, and connections.

### Plugin Structure

```
learning-retrospective/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── retro.md
├── agents/
│   └── retro-analyzer.md
└── skills/
    └── learning-retro/
        ├── SKILL.md
        └── references/
            └── digest-format.md
```

### Components

#### plugin.json

```json
{
  "name": "learning-retrospective",
  "version": "0.1.0",
  "description": "Periodic learning analysis across Obsidian vault, Anki, and git history",
  "author": {
    "name": "Roc"
  },
  "keywords": ["learning", "retrospective", "analysis", "spaced-repetition"]
}
```

#### Command: `/learning-retro:retro`

**Frontmatter:**
```yaml
description: Analyze your recent learning activity across vault, Anki, and git
argument-hint: [period: 7d|14d|30d]
allowed-tools: ["Read", "Grep", "Glob", "Bash", "AskUserQuestion", "Task",
  "mcp__obsidian__search_notes", "mcp__obsidian__read_note",
  "mcp__obsidian__list_directory", "mcp__obsidian__write_note",
  "mcp__anki__collection_stats", "mcp__anki__review_stats",
  "mcp__anki__findNotes", "mcp__anki__getTags",
  "mcp__anki__deckActions"]
```

**Workflow:**

1. **Parse period** from `$ARGUMENTS` (default: `7d`). Support `7d`, `14d`, `30d`, or custom date range.

2. **Check MCP availability**: Verify Obsidian and Anki MCP servers are reachable. If either is missing, warn the user and proceed with available data sources only. Provide setup instructions for missing servers.

3. **Dispatch `retro-analyzer` agent** with the time period. The agent gathers data from three sources and returns structured analysis.

4. **Present the digest** in conversation with these sections:
   - Topic clusters (what you learned, grouped by domain)
   - Retention check (Anki review stats, flagged weak areas)
   - Connection suggestions (vault notes that should be linked)
   - Problem signals (git `fix:` commits clustered by area)
   - Uncaptured work reference (suggest running `/learning-vault:learn-review` if significant git activity has no corresponding vault notes)

5. **Ask to save**: Use `AskUserQuestion` to ask if user wants to save the digest to Obsidian as `Retros/YYYY-Www.md`.

6. **If saving**: Check if `Retros/` folder exists. Create digest note via Obsidian MCP with frontmatter (date, period, note count, card count).

#### Agent: `retro-analyzer`

**Frontmatter:**
```yaml
name: retro-analyzer
description: >
  Use this agent to analyze learning activity across Obsidian, Anki, and git.
  Trigger when the /learning-retro:retro command is invoked.

  <example>
  Context: User runs the retrospective command
  user: "/learning-retro:retro 14d"
  assistant: "I'll dispatch the retro-analyzer agent to gather and analyze your learning data from the past 14 days."
  <commentary>
  Command dispatches this agent to do the heavy data gathering and cross-referencing work.
  </commentary>
  </example>

  <example>
  Context: User wants to understand their learning patterns
  user: "What have I been learning lately? Am I retaining it?"
  assistant: "I'll use the retro-analyzer agent to cross-reference your vault notes, Anki stats, and git history."
  <commentary>
  User asking about learning patterns -- this agent provides the analysis.
  </commentary>
  </example>

model: sonnet
color: cyan
tools: ["Read", "Grep", "Glob", "Bash",
  "mcp__obsidian__search_notes", "mcp__obsidian__read_note",
  "mcp__obsidian__list_directory",
  "mcp__anki__collection_stats", "mcp__anki__review_stats",
  "mcp__anki__findNotes", "mcp__anki__getTags",
  "mcp__anki__deckActions"]
```

**Why Sonnet (not Haiku):** Cross-referencing three data sources (vault notes, Anki stats, git history) and synthesizing meaningful clusters requires reasoning capability beyond what Haiku reliably provides. The retro is run weekly at most, so cost is acceptable. (Addresses audit finding R2.)

**System prompt responsibilities:**

1. **Gather vault data**: Search Obsidian for notes created/modified in the period. Read tags, frontmatter dates, `[[links]]` in each note.
2. **Gather Anki data**: Get `collection_stats` and `review_stats` for the period. Find recently created cards with `findNotes` using `added:N` query. Get tag distribution.
3. **Gather git data**: `git log --since="{period}" --oneline` for commit count. `git log --since="{period}" --pretty=format:"%s"` to extract commit message patterns. Count `fix:` prefixed commits and cluster by keywords.
4. **Cross-reference**: Match vault note tags to Anki card tags where possible. Identify vault concepts with corresponding Anki cards vs. vault-only concepts. Flag Anki decks/tags with retention rate below 70%.
5. **Generate structured analysis** following the digest format defined in the skill's `references/digest-format.md`.

**Problem signal heuristics** (addresses audit finding R7):
- Extract commit messages matching patterns: `fix:`, `bug`, `hotfix`, `revert`, `workaround`
- Cluster by keywords extracted from the message (e.g., "fix: async timeout in middleware" → category: `async`)
- Report only if 3+ fix-related commits share a category in the period

#### Skill: `learning-retro`

**SKILL.md description (third-person, with triggers):**
```
This skill should be used when writing learning retrospective digests,
formatting learning analysis reports, or structuring periodic review output.
Applies when the user asks to "review my learning", "what did I learn this week",
"learning retrospective", "analyze my study progress", or "learning digest".
```

**SKILL.md body** (~1,500 words): Core digest structure, section definitions, quality criteria for each section.

**references/digest-format.md**: Detailed template with examples of good vs. bad analysis for each section. Includes:
- Topic cluster format with counts and evidence
- Retention analysis format with thresholds (>85% = strong, 70-85% = adequate, <70% = needs attention)
- Connection suggestion format with specific vault note paths
- Problem signal format with commit evidence

---

## Plugin 2: `concept-challenger`

### Purpose

Test application of learned concepts through novel scenarios with integrated English technical writing feedback.

### Plugin Structure

```
concept-challenger/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   └── challenge.md
└── skills/
    └── concept-challenge/
        ├── SKILL.md
        └── references/
            ├── scenario-design.md
            ├── evaluation-rubric.md
            └── language-rubric.md
```

### Design Decision: No Separate Agent

The original brainstorm proposed a `scenario-generator` agent. After audit, this is unnecessary complexity:

- The `/challenge` command runs in the user's current model context (likely Opus or Sonnet)
- Scenario generation + evaluation are sequential steps in one conversation, not parallelizable
- Spawning an agent adds latency without benefit since the command needs to wait for the scenario, present it, get user response, then evaluate -- all sequential

The command itself handles the full workflow, referencing the skill for scenario design and evaluation rubrics. This is consistent with how `/learning-vault:learn` works -- complex interactive workflow handled by the command, no agent needed.

### Components

#### plugin.json

```json
{
  "name": "concept-challenger",
  "version": "0.1.0",
  "description": "Test concept application through novel scenarios with English writing feedback",
  "author": {
    "name": "Roc"
  },
  "keywords": ["learning", "challenge", "application", "english", "writing"]
}
```

#### Command: `/concept-challenger:challenge`

**Frontmatter:**
```yaml
description: Test your understanding of a concept with a novel scenario and get English writing feedback
argument-hint: [concept name or "random" or "weak"]
allowed-tools: ["Read", "Grep", "Glob", "AskUserQuestion",
  "mcp__obsidian__search_notes", "mcp__obsidian__read_note",
  "mcp__obsidian__list_directory",
  "mcp__anki__review_stats", "mcp__anki__findNotes",
  "mcp__anki__deckActions"]
```

**Workflow:**

1. **Select concept** based on `$ARGUMENTS`:
   - If a concept name is provided: search vault for matching note
   - If `random`: list vault `Knowledge/` notes, pick one pseudo-randomly (use current timestamp to vary selection)
   - If `weak`: query Anki `review_stats` for tags with low retention, find corresponding vault notes
   - If empty: use `AskUserQuestion` with options: Random, Weak areas, Specific topic (text input)

2. **Read the vault note** for the selected concept. Extract: definition, context, example, related concepts, tags.

3. **Check challenge history**: Search Obsidian for `Challenges/{concept-name}.md`. If exists, read past scenarios to avoid repetition. If not, this is the first challenge for this concept.

4. **Generate scenario** following the rubric in `references/scenario-design.md`:
   - Choose a domain DIFFERENT from the vault note's example (avoid: if the note uses a food delivery example, don't use food delivery)
   - Domain rotation: pick from a domain pool (IoT, healthcare, fintech, e-commerce, social media, gaming, logistics, education, media streaming, manufacturing) excluding domains used in past challenges and the vault note
   - Create a realistic problem where the concept applies, but don't name the concept explicitly in advanced difficulty
   - Difficulty defaults to "basic" (apply one concept). User can request harder via argument.

5. **Present the scenario**: Show the scenario, then STOP and wait for user's response. Do NOT evaluate until the user submits their answer.

6. **Evaluate response** in three sections:

   **Section A -- Concept Evaluation:**
   Rate as Strong / Adequate / Needs Review based on rubric in `references/evaluation-rubric.md`:
   - **Strong**: Correctly applies the concept, identifies relevant trade-offs, connects to related concepts from vault
   - **Adequate**: Correctly applies the concept but misses trade-offs or connections
   - **Needs Review**: Misapplies the concept or only recites the definition without application
   Provide specific feedback referencing what the user said.

   **Section B -- Language Review:**
   Following rubric in `references/language-rubric.md`:
   - **Grammar corrections**: List specific errors with rule explanations (e.g., "subject-verb agreement")
   - **Technical writing quality**: Evaluate argument structure (cause-effect flow, transition usage, logical progression)
   - **Vocabulary**: Note good technical vocabulary usage; suggest improvements for vague/informal phrasing
   - **Positive reinforcement**: Explicitly call out what was done well

   **Section C -- Revised Version:**
   Rewrite the user's response with improvements. Rules:
   - **Bold** all changed words/phrases
   - Annotate significant changes with brief explanations in parentheses
   - Keep the revised version within 1.5x the length of the original (addresses audit finding C8)
   - Preserve the user's ideas and structure -- improve expression, not content

7. **Offer follow-up actions** via `AskUserQuestion`:
   - "Try a harder scenario for this concept"
   - "Save this challenge to history" (append to `Challenges/{concept-name}.md`)
   - "Create a vault note for a gap this exposed" (suggest running `/learning-vault:learn`)
   - "Create an Anki card for something I learned" (suggest running `/anki-flashcards:flashcard`)
   - "Done"

8. **Save challenge history** if user chose to save: Append to `Challenges/{concept-name}.md` in Obsidian with date, scenario summary, rating, and key language improvements noted.

#### Skill: `concept-challenge`

**SKILL.md description (third-person, with triggers):**
```
This skill should be used when the user asks to "challenge me on a concept",
"test my understanding", "quiz me on something I learned", "practice technical
explanation", "concept challenge", or wants to test application of knowledge
from their Obsidian vault through scenario-based exercises with English writing
feedback.
```

**SKILL.md body** (~1,800 words): Overview of the challenge methodology, the three-section evaluation structure, how to reference the rubric files, and quality criteria.

**references/scenario-design.md** (~2,000 words):

Detailed scenario generation rubric:
- Domain pool with descriptions (10 domains)
- Scenario structure template: Context (2-3 sentences) → Problem statement (1-2 sentences) → Constraint or complication (1 sentence) → Question prompt
- Difficulty levels:
  - **Basic**: Name the concept in the question. "How would you apply [concept] here?"
  - **Intermediate**: Don't name the concept. "How would you redesign this system?" User must recognize which concept applies.
  - **Advanced**: Present a scenario where 2-3 vault concepts are relevant. User must identify and combine them.
- Novelty rules: Must use different domain from vault note example. Must use different domain from past challenges for same concept.
- Anti-patterns: Scenarios that are too abstract, too trivial, or that can be solved without the concept.

**references/evaluation-rubric.md** (~1,500 words):

Concept evaluation criteria (addresses audit finding C5):
- **Strong** indicators: Uses concept vocabulary naturally. Identifies when the concept does and doesn't apply. Discusses trade-offs specific to the scenario (not generic). References related concepts.
- **Adequate** indicators: Correct application but surface-level. Mentions trade-offs generically. Doesn't connect to related concepts.
- **Needs Review** indicators: Recites definition without applying to scenario. Misidentifies when concept applies. Confuses concept with related but different concept.

**references/language-rubric.md** (~2,000 words):

English evaluation criteria (addresses audit finding C3):

Grammar categories to check:
- Subject-verb agreement
- Article usage (a/an/the) -- common for non-native speakers
- Tense consistency
- Preposition usage
- Countable/uncountable noun distinction
- Conditional structures (if X, then Y)

Technical writing quality criteria:
- **Argument structure**: Does the response follow a logical flow? (claim → evidence → implication)
- **Transition usage**: Does it use connectors? (however, consequently, therefore, specifically, in contrast)
- **Precision**: Does it use specific terms or vague ones? ("this reduces latency by avoiding network hops" vs. "this makes it faster")
- **Conciseness**: Does it say things in minimum words? Flag redundancy.
- **Hedging appropriateness**: Does it hedge when uncertain and assert when confident?

Revised version annotation format:
```
Original: "It will causes the system to slow down because too many request."
Revised: "It **causes** the system to slow down **due to excessive requests**."
(subject-verb agreement: "causes" not "will causes";
 "too many request" → "excessive requests" -- uncountable needs no article,
 plural countable noun; "due to" is more precise than "because" in technical writing)
```

---

## Integration Architecture

### How the Four Plugins Connect

```
                      ┌─── learning-vault (deep concepts)
  found problem       │       ↑ /learn
    → discuss         ├─── anki-flashcards (key facts)
    → implement       │       ↑ /flashcard
    → capture ────────┘
                           ↓ (weekly)
                      learning-retrospective
                      - topic clusters from vault notes
                      - retention check from Anki stats
                      - connection suggestions between vault notes
                      - problem signals from git fix: commits
                      - suggests /learn-review for uncaptured work
                           ↓ (surfaces weak areas or on-demand)
                      concept-challenger
                      - picks concept from vault (random/weak/specific)
                      - generates novel scenario
                      - evaluates concept application + English writing
                      - suggests /learn for gaps, /flashcard for new facts
                           ↓ (feeds back into)
                      learning-vault / anki ← loop closes
```

### Data Flow

| Source | Consumer | Data | Method |
|--------|----------|------|--------|
| Obsidian vault | retro-analyzer | Recent notes, tags, links | Obsidian MCP search/read |
| Obsidian vault | challenge command | Concept notes for scenarios | Obsidian MCP search/read |
| Anki | retro-analyzer | Review stats, retention rates | Anki MCP review_stats |
| Anki | challenge command | Weak areas (low retention tags) | Anki MCP review_stats |
| Git | retro-analyzer | Commit messages, fix patterns | Bash git log |
| Challenge history | challenge command | Past scenarios per concept | Obsidian MCP read_note |

### Cross-Plugin Handoffs

Plugins don't call each other's commands directly. Instead, they **suggest** the user invoke them:

- Retro → suggests: "Run `/learning-vault:learn-review` to capture uncaptured work"
- Retro → suggests: "Review weak Anki cards in these areas"
- Challenger → suggests: "Run `/learning-vault:learn` to capture the gap this exposed"
- Challenger → suggests: "Run `/anki-flashcards:flashcard` to create a card for this insight"

### Shared Conventions

**Tag alignment**: Both new plugins read vault note tags using the taxonomy defined in `learning-vault`'s skill (`pattern`, `architecture`, `concept`, `technique`, etc.). No new tag system introduced.

**Obsidian folder structure**:
```
Vault/
├── Knowledge/          ← learning-vault writes here (existing)
├── Retros/             ← learning-retrospective writes here (new)
└── Challenges/         ← concept-challenger writes here (new)
```

---

## Dependencies & Prerequisites

| Dependency | Required by | Required? |
|------------|-------------|-----------|
| Obsidian MCP Server | Both plugins | Yes |
| Anki MCP Server | Both plugins | Recommended (retro/challenger degrade gracefully without it) |
| Git repository | learning-retrospective | Yes (for problem signals and uncaptured work detection) |
| Existing vault notes | concept-challenger | Yes (needs concepts to challenge on) |

### Graceful Degradation

- **No Anki MCP**: Retro skips retention analysis section. Challenger skips "weak" selection mode. Both warn user and provide Anki MCP setup instructions.
- **No Obsidian MCP**: Both plugins cannot function. Show clear error with setup command.
- **Empty vault**: Challenger shows message: "No concepts found in Knowledge/. Use `/learning-vault:learn` to capture your first concept, then come back for a challenge."

---

## Implementation Priority

1. **`concept-challenger`** -- Higher learning value, more novel. Can be used immediately if vault has notes.
2. **`learning-retrospective`** -- Higher integration value, but benefits grow over time as vault and Anki data accumulate.

### Estimated Scope

| Plugin | Files | Complexity |
|--------|-------|------------|
| concept-challenger | 6 files (plugin.json, command, SKILL.md, 3 reference files) | Medium -- scenario generation rubric is the hard part |
| learning-retrospective | 5 files (plugin.json, command, agent, SKILL.md, 1 reference file) | Medium -- cross-source data gathering is the hard part |

---

## Audit Findings Resolution

| Finding | Resolution |
|---------|-----------|
| R1 (learn-review overlap) | Retro references `/learn-review` for uncaptured work; doesn't duplicate |
| R2 (Haiku insufficient) | Changed to Sonnet for retro-analyzer |
| R3 (missing skill spec) | Skill fully specified with trigger phrases and references |
| R4 (no argument-hint) | Added `[period: 7d\|14d\|30d]` |
| R5 (hardcoded path) | Command checks if Retros/ exists before writing |
| R6 (missing MCP error handling) | Graceful degradation spec added |
| R7 (vague problem signals) | Defined heuristics: commit message patterns, keyword clustering, 3+ threshold |
| C1 (Sonnet agent cost) | Removed agent entirely; command handles workflow directly |
| C2 (novel scenario spec) | Domain rotation pool, exclusion rules, anti-patterns defined |
| C3 (language rubric undefined) | Full rubric in references/language-rubric.md |
| C4 (no challenge history) | Obsidian Challenges/ folder tracks past scenarios per concept |
| C5 (rating criteria unclear) | Strong/Adequate/Needs Review criteria defined with observable indicators |
| C6 (gap creation workflow) | Suggests running existing /learn and /flashcard commands |
| C7 (difficulty scaling) | Three levels defined with concrete rules; defaults to basic |
| C8 (revised version length) | Capped at 1.5x original length |
| C9 (no command argument) | $ARGUMENTS accepts concept name, "random", or "weak" |
| C10 (missing agent examples) | Agent removed; no examples needed |
| X1 (no shared tagging) | Uses learning-vault's existing tag taxonomy |
| X2 (cross-plugin handoff) | Suggest-based handoff, not direct invocation |
| X3 (concept registry) | Vault is primary source; Anki stats used for aggregate analysis only |
