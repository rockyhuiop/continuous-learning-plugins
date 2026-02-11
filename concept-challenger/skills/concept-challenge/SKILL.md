---
name: concept-challenge
description: This skill should be used when the user asks to "challenge me on a concept", "test my understanding", "quiz me on something I learned", "practice technical explanation", "concept challenge", "test my knowledge", "drill me on", or "review my understanding of", or wants to test application of knowledge from their Obsidian vault through scenario-based exercises with English writing feedback.
version: 0.1.0
---

# Concept Challenge Methodology

Generate novel scenarios that test concept application (not recall) and provide integrated English technical writing feedback. The goal is to verify that a learned concept can be transferred to unfamiliar domains, while simultaneously improving technical communication skills.

## Core Philosophy

Recall-based testing ("define circuit breaker") confirms memorization. Application-based testing ("here's a system with cascading failures -- what would you do?") confirms understanding. This skill focuses exclusively on application.

Every challenge follows a three-part evaluation:
1. **Concept application** -- can the user apply the concept to a new domain?
2. **Language quality** -- is the technical explanation clear, precise, and well-structured?
3. **Revised version** -- a rewritten version showing improvements with annotations

## Challenge Workflow

### Concept Selection

Select a concept from the user's Obsidian `Knowledge/` folder using one of three modes:

- **Specific**: User names a concept directly. Search Obsidian `Knowledge/` for matching notes.
- **Random**: List all notes in `Knowledge/` via Obsidian MCP and pick one using the current timestamp for variation (e.g., index = minute % total_notes).
- **Weak**: Query Anki `review_stats` for tags with retention below 70%, then find corresponding vault notes. Fall back to random if Anki MCP is unavailable.

Read the vault note to extract the concept definition, context, example domain, related concepts, and tags. This material informs scenario generation but must not be repeated back verbatim in the scenario.

### Scenario Generation

Generate a realistic problem scenario in a domain different from the vault note's example. Follow the detailed rubric in `references/scenario-design.md` for:

- Domain selection from a 10-domain rotation pool
- Scenario structure (context, problem, constraint, question)
- Three difficulty levels (basic, intermediate, advanced)
- Novelty rules to prevent repetition
- Anti-patterns to avoid

**Critical rule**: Present the scenario, then stop and wait for the user's response. Never evaluate preemptively.

### Three-Section Evaluation

After receiving the user's response, evaluate using three complementary lenses:

**Section A -- Concept Evaluation**

Rate as Strong, Adequate, or Needs Review using observable indicators defined in `references/evaluation-rubric.md`. Always reference specific parts of the user's response when giving feedback.

**Section B -- Language Review**

Evaluate grammar, technical writing quality, and vocabulary using the detailed criteria in `references/language-rubric.md`. Start with positive reinforcement before corrections. Frame corrections as tips, not judgments.

**Section C -- Revised Version**

Rewrite the user's response with improvements:
- Bold all changed words/phrases
- Annotate significant changes with brief explanations
- Cap length at 1.5x the original
- Preserve the user's ideas -- improve expression only

## Challenge History

Track past challenges per concept in `Challenges/{concept-name}.md` in Obsidian. Each entry records date, domain, difficulty, rating, and key language improvements. History serves two purposes:

1. **Domain exclusion**: Avoid repeating domains for the same concept
2. **Progress tracking**: Show improvement over time

Entry format:

```markdown
## 2026-02-12 -- Fintech

**Difficulty**: basic
**Rating**: Adequate
**Scenario summary**: Payment gateway cascading failures when fraud-detection service becomes unresponsive
**Key language improvements**: Article usage (3 instances), tense consistency in conditional structures
```

## Quality Standards

### Scenario Quality

- Scenario must be realistic and specific, not abstract
- The concept must be genuinely applicable (not forced)
- The scenario must be solvable without the concept being named (for intermediate/advanced)
- Constraints should add realistic complexity, not artificial difficulty

### Evaluation Quality

- Always quote the user's words when praising or correcting
- Concept feedback focuses on this scenario specifically, not generic theory
- Grammar corrections include rule names (e.g., "subject-verb agreement")
- Revised version preserves the user's voice and ideas

### Tone

- Encouraging and constructive
- Language feedback framed as professional development, not error correction
- Celebrate good technical vocabulary and clear reasoning
- Acknowledge when answers demonstrate genuine understanding

## Cross-Plugin Integration

This plugin reads from but does not write to the learning-vault. After evaluation, suggest relevant follow-up actions:

- `/learning-vault:learn` -- to capture a concept gap this challenge exposed
- `/anki-flashcards:flashcard` -- to create a card for a new insight
- Harder difficulty -- to deepen understanding of the same concept

## Reference Files

Consult these reference files for detailed rubrics and criteria:

- **`references/scenario-design.md`** -- Domain pool, scenario structure template, difficulty levels, novelty rules, anti-patterns
- **`references/evaluation-rubric.md`** -- Strong/Adequate/Needs Review indicators, feedback guidelines
- **`references/language-rubric.md`** -- Grammar categories, technical writing quality criteria, revised version annotation format
