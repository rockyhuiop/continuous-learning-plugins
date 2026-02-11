# Digest Format Reference

Detailed formatting conventions, thresholds, and examples for each section of a learning retrospective digest.

## Complete Digest Template

```markdown
---
type: retrospective
date: 2026-02-12
period: 7d
note_count: 8
card_count: 45
---

## Learning Retrospective — Feb 5 to Feb 12, 2026

### Topic Clusters

- **pattern** (4 notes): Circuit Breaker, Retry Pattern, Bulkhead Isolation, Strangler Fig Pattern
  - Anki coverage: 12 cards / 88% retention
  - Source: 3 implementation, 1 reading
- **architecture** (2 notes): Event-Driven Architecture, CQRS Pattern
  - Anki coverage: 5 cards / 72% retention
  - Source: 2 implementation
- **tool** (1 note): Temporal Workflow Engine
  - Anki coverage: No cards
  - Source: 1 reading
- **gotcha** (1 note): SQLAlchemy Async Session Gotcha
  - Anki coverage: 2 cards / 100% retention
  - Source: 1 implementation

**Summary**: 8 notes across 4 domains. Resilience patterns dominated this period.

### Retention Check

**Needs attention** (<70%):
- `database` — 62% across 28 reviews (declining from 75% last period)

**Adequate** (70-85%):
- `architecture` — 72% across 35 reviews
- `api` — 78% across 42 reviews

**Strong** (>85%):
- `pattern` — 88% across 56 reviews
- `gotcha` — 100% across 8 reviews (small sample)

### Connection Suggestions

1. [[Circuit Breaker]] ↔ [[Retry Pattern]] — Both address resilience; circuit breaker prevents retries on known-failed services
2. [[Event-Driven Architecture]] ↔ [[CQRS Pattern]] — CQRS is commonly implemented with event sourcing in event-driven systems
3. [[Temporal Workflow Engine]] ↔ [[Bulkhead Isolation]] — Temporal provides built-in task queue isolation (a form of bulkheading)

### Problem Signals

- **async** (4 fix commits): "fix: async timeout in middleware", "fix: race condition in async handler", "fix: async session not closing", "fix: await missing in event processor"
  → Consider creating a vault note on async pitfalls in Python

### Uncaptured Work

- Active area: `services/notification/` (12 commits) — No vault notes found for notification system patterns
  → Run `/learning-vault:learn-review` to discover learnable concepts from this work
```

## Section Formatting Details

### Topic Clusters

**Format per cluster:**
```
- **[primary tag]** ([count] notes): [Note Title 1], [Note Title 2], ...
  - Anki coverage: [card count] cards / [retention]% retention | No cards
  - Source: [count] implementation, [count] reading, [count] discussion
```

**Ordering**: Most notes first, then alphabetical for equal counts.

**Good example:**
```
- **pattern** (4 notes): Circuit Breaker, Retry Pattern, Bulkhead Isolation, Strangler Fig
  - Anki coverage: 12 cards / 88% retention
  - Source: 3 implementation, 1 reading
```

**Bad example:**
```
- patterns: learned some resilience stuff
  - some cards exist
```
Why bad: Vague, no counts, no specific note titles, no retention data.

### Retention Check

**Threshold definitions:**
| Rating | Retention | Action |
|--------|-----------|--------|
| Strong | > 85% | No action needed |
| Adequate | 70-85% | Monitor; consider additional cards |
| Needs attention | < 70% | Schedule targeted review; add context-heavy cards |

**Format per entry:**
```
- `[tag]` — [retention]% across [review count] reviews
```

**Include sample size warnings:**
- If fewer than 10 reviews for a tag, append `(small sample)` to flag unreliability
- If retention is declining compared to previous retros, note the trend

**Good example:**
```
**Needs attention** (<70%):
- `database` — 62% across 28 reviews (declining from 75% last period)
```

**Bad example:**
```
Database stuff is weak.
```
Why bad: No percentage, no review count, no trend context.

### Connection Suggestions

**Format per suggestion:**
```
[number]. [[Note A]] ↔ [[Note B]] — [specific reason for linking]
```

**How to identify connections:**
1. Notes sharing 2+ tags without existing `[[links]]`
2. Notes in the same topic cluster without cross-references
3. Notes covering problem and solution (e.g., [[Race Condition]] ↔ [[Mutex Pattern]])
4. Notes covering alternative approaches (e.g., [[REST API]] ↔ [[GraphQL]])

**Limit to 5-7 suggestions maximum.** Prioritize by:
1. Notes with zero outgoing links (orphaned knowledge)
2. Notes with highest shared tag overlap
3. Notes covering complementary concepts

**Good example:**
```
1. [[Circuit Breaker]] ↔ [[Retry Pattern]] — Both address resilience; circuit breaker prevents retries on known-failed services
```

**Bad example:**
```
1. Circuit Breaker and Retry Pattern are related
```
Why bad: No wiki links, no specific reason, not actionable.

### Problem Signals

**Commit message pattern matching:**
Match these patterns (case-insensitive) in commit messages:
- `fix:` or `fix(` — Conventional commit fix prefix
- `bug` — Bug-related work
- `hotfix` — Urgent fixes
- `revert` — Reverted changes (indicates initial approach failed)
- `workaround` — Temporary solutions (indicates incomplete understanding)

**Clustering heuristics:**
Extract a single domain-level keyword from the commit message body (after the prefix). Prefer broad, recognizable terms over compound phrases:
- "fix: async timeout in middleware" → category: `async`
- "fix: database connection pool exhausted" → category: `database`
- "fix: race condition in event handler" → category: `async`
- "fix: incorrect JWT validation logic" → category: `auth`
- "fix: CSS overflow on mobile layout" → category: `frontend`

**Category naming rules:**
- Use a single word (e.g., `async`, `database`, `auth`, `frontend`, `api`)
- Avoid compound phrases like `async-timeout` or `database-connection-pool`
- When a commit could map to multiple categories, prefer the broader domain term
- Merge similar categories (e.g., `concurrent` and `async` → `async`)

Group by the extracted category. Only report clusters with **3 or more** commits.

**Format per cluster:**
```
- **[category]** ([count] fix commits): "[message 1]", "[message 2]", ...
  → [Suggested action: create vault note, review existing note, etc.]
```

**Good example:**
```
- **async** (4 fix commits): "fix: async timeout in middleware", "fix: race condition in async handler", "fix: async session not closing", "fix: await missing in event processor"
  → Consider creating a vault note on async pitfalls in Python
```

**Bad example:**
```
- Found some bugs in the codebase
```
Why bad: No category, no counts, no commit evidence, no action.

### Uncaptured Work

**Detection logic:**
Compare areas with significant git activity (5+ commits) to vault note coverage:
- Map commit paths to topic areas (e.g., `services/notification/` → notification patterns)
- Check if vault notes exist for related technologies or patterns
- Flag gaps where active development has no corresponding captured knowledge

**Format per gap:**
```
- Active area: [directory/feature] ([commit count] commits) — No vault notes found for [technology/pattern]
  → Run `/learning-vault:learn-review` to discover learnable concepts from this work
```

**Important:** Do not list individual commits or try to identify specific concepts. That is `/learn-review`'s job. This section only flags the gap and points to the tool.

**Good example:**
```
- Active area: `services/notification/` (12 commits) — No vault notes found for notification system patterns
  → Run `/learning-vault:learn-review` to discover learnable concepts from this work
```

**Bad example:**
```
- You should have learned about notifications
```
Why bad: Judgmental tone, no evidence, no actionable reference.

## Digest Summary Line

End the Topic Clusters section with a brief summary:

```
**Summary**: [total notes] notes across [cluster count] domains. [One observation about the period's focus.]
```

Examples:
- "8 notes across 4 domains. Resilience patterns dominated this period."
- "3 notes across 2 domains. Light learning week — mostly implementation-focused."
- "12 notes across 6 domains. Broad exploration week with database and API design focus."

## Period-Specific Considerations

### 7-day (weekly)
- Most common cadence. Good baseline for regular reflection.
- Topic clusters may be small (1-3 notes). This is normal.
- Problem signals need 3+ commits in just one week — threshold is meaningful here.

### 14-day (biweekly)
- Good for catching patterns that don't emerge in a single week.
- Connection suggestions become more valuable with more notes to cross-reference.
- Retention trends are more visible with 2 weeks of review data.

### 30-day (monthly)
- Best for big-picture analysis. Topic clusters should be more developed.
- Problem signals with 3+ commits are almost certainly significant at this scale.
- Consider noting which weeks had the most activity.
