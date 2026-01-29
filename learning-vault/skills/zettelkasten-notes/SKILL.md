---
name: zettelkasten-notes
description: Use this skill when writing learning notes, creating knowledge documentation, or organizing technical concepts in a connected note system. Applies to questions about "how to write good notes", "atomic notes", "linking notes", "Zettelkasten method", "knowledge management", or when creating notes for the Obsidian vault.
version: 1.0.0
---

# Zettelkasten Notes for Technical Learning

Write effective atomic notes that build a connected knowledge network for software development learning.

## Core Principles

### Atomicity

Each note covers exactly ONE concept. Signs a note is too broad:
- Multiple "## Definition" sections needed
- Unrelated examples
- Title contains "and" or comma-separated items

**Good**: "Strangler Fig Pattern"
**Too Broad**: "Migration Patterns and Strategies"

Split broad topics into linked atomic notes.

### Connection Over Collection

Notes gain value through links. Every note should:
- Link to 2-5 related concepts
- Be linkable from future notes
- Use meaningful link text: `[[Circuit Breaker|resilience pattern]]` not just `[[Circuit Breaker]]`

### Your Understanding

Capture YOUR understanding, not textbook definitions:
- Use your words, not Wikipedia
- Include your specific context
- Reference your actual code
- Note your questions and gaps

## Note Structure

### Frontmatter (Required)

```yaml
---
id: 202601281430
title: Strangler Fig Pattern
created: 2026-01-28
project: canpanion-backend
source: implementation
tags:
  - pattern
  - architecture
  - migration
---
```

**Fields**:
- `id`: Timestamp YYYYMMDDHHMM (enables sorting, uniqueness)
- `title`: Human-readable concept name
- `created`: ISO date
- `project`: Where you learned/applied this
- `source`: How you learned it (implementation, reading, discussion, course)
- `tags`: From the taxonomy (see below)

### Definition Section

One clear sentence. Test: Could you explain this to a colleague in one breath?

```markdown
## Definition

The Strangler Fig Pattern incrementally replaces legacy system components by routing traffic through a facade that gradually shifts from old to new implementations.
```

### Context Section

Why this matters to YOU:
- What problem were you solving?
- When would you use this again?
- What made you notice this concept?

```markdown
## Context

Encountered while modernizing the UserService from the monolith. Needed to migrate without downtime while maintaining data consistency. The pattern let us move one endpoint at a time over 3 sprints.
```

### Example Section

Real code from your work. This is the most valuable part for future reference.

```markdown
## Example

In `services/userFacade.js`, we created a routing layer:

\`\`\`javascript
async getUser(id) {
  // Feature flag controls traffic split
  if (await featureFlags.isEnabled('new-user-service', id)) {
    return this.newUserService.get(id)
  }
  return this.legacyUserService.get(id)
}
\`\`\`

Key insight: Using user ID as feature flag key enabled gradual rollout by user cohort.
```

### Related Section

Link to connected concepts. Think:
- What concepts does this build on?
- What concepts build on this?
- What's the opposite or alternative?

```markdown
## Related

- [[Feature Flags]] - Control mechanism for traffic routing
- [[Legacy Migration Strategies]] - Broader category this belongs to
- [[Branch by Abstraction]] - Alternative pattern for similar problems
- [[Facade Pattern]] - Underlying design pattern used
```

### Questions Section (Optional)

Open questions for future exploration:

```markdown
## Questions

- How does this interact with database migrations?
- What's the rollback strategy if the new service fails?
- How do we handle in-flight requests during switchover?
```

## Tag Taxonomy

Use consistent tags for discoverability:

### Architecture Tags
- `pattern` - Design or architecture pattern
- `architecture` - System design concept
- `migration` - Moving between systems/versions
- `refactoring` - Code improvement techniques
- `design` - Software design principles
- `infrastructure` - DevOps/platform concepts
- `api` - API design and integration
- `database` - Data storage patterns

### Learning Tags
- `concept` - Abstract technical concept
- `terminology` - Technical vocabulary
- `technique` - Specific implementation approach
- `lesson-learned` - Insight from experience
- `best-practice` - Recommended approach
- `gotcha` - Common pitfall or surprise
- `tool` - Software tool or library

### Combining Tags

Notes typically have 2-4 tags:
- One category tag (`pattern`, `technique`, `concept`)
- One or more domain tags (`architecture`, `api`, `database`)

Example: Strangler Fig → `pattern`, `architecture`, `migration`

## Writing Guidelines

### Be Specific

**Vague**: "This pattern is useful for migrations"
**Specific**: "Use when migrating services that handle >1000 req/s and can't afford downtime"

### Include Failure Modes

What can go wrong? What did you learn the hard way?

```markdown
**Gotcha**: If the legacy and new services share a database, ensure they use the same transaction isolation level or you'll get inconsistent reads during the transition.
```

### Link Generously

When writing, ask: "What other concept does this remind me of?"
Create placeholder links for notes you haven't written yet: `[[Database Transactions]]`
Obsidian will show these as unlinked references.

### Update Over Time

Notes are living documents:
- Add new examples as you apply the concept
- Refine definitions as understanding deepens
- Add links to new related concepts
- Move questions to their own notes when answered

## Examples

See the `examples/` directory for complete note templates:
- `strangler-fig-pattern.md` - Architecture pattern example
- `circuit-breaker.md` - Resilience technique example
- `sse-streaming.md` - Implementation technique example

## Quick Reference

**Creating a new note**:
1. Generate ID: current timestamp YYYYMMDDHHMM
2. Write one-sentence definition
3. Add your context and example
4. Link to 2-5 related concepts
5. Add 2-4 tags from taxonomy

**Checking note quality**:
- [ ] Covers exactly one concept?
- [ ] Definition is one clear sentence?
- [ ] Example from real work?
- [ ] At least 2 links to related notes?
- [ ] Tags from the taxonomy?
