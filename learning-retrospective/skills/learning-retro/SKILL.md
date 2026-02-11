---
name: learning-retro
description: This skill should be used when writing learning retrospective digests, formatting learning analysis reports, or structuring periodic review output. Applies when the user asks to "review my learning", "what did I learn this week", "learning retrospective", "analyze my study progress", "learning digest", "where are my knowledge gaps", or needs guidance on structuring cross-source learning analysis combining Obsidian, Anki, and git data.
version: 0.1.0
---

# Learning Retrospective Digest

Structure periodic learning analysis into actionable digests that cross-reference Obsidian vault notes, Anki spaced repetition data, and git commit history.

## Purpose

A learning retrospective digest provides a bird's-eye view of learning activity over a defined period. It answers five questions:

1. **What did I learn?** — Topic clusters from vault notes, grouped by domain
2. **Am I retaining it?** — Anki review stats with flagged weak areas
3. **What connects?** — Vault notes that should link to each other but don't
4. **Where am I struggling?** — Recurring `fix:` commits clustered by problem area
5. **What did I miss?** — Git activity with no corresponding vault notes

## Digest Structure

Every digest contains five sections in order. Each section follows specific formatting rules and quality criteria.

### Section 1: Topic Clusters

Group vault notes by primary tag into clusters. For each cluster, include:
- Tag name and note count
- List of specific note titles
- Whether the cluster has Anki card coverage

**Quality criteria**:
- Clusters with only 1 note are fine — they show emerging topics
- Order clusters by note count (most active first)
- Note the source distribution per cluster (implementation vs. reading vs. discussion)

### Section 2: Retention Check

Present Anki review statistics categorized by retention thresholds:
- **Strong** (>85%): Concepts well-retained, no action needed
- **Adequate** (70-85%): Acceptable but worth monitoring
- **Needs attention** (<70%): Flag for review, suggest targeted study

**Quality criteria**:
- Always include the number of reviews behind each percentage (small sample sizes are unreliable)
- Match Anki tags to vault note tags where possible to connect retention data to captured concepts
- If Anki is unavailable, state "Retention analysis skipped — Anki MCP not available" rather than omitting the section

### Section 3: Connection Suggestions

Identify vault notes that should reference each other based on:
- Shared tags (2+ tags in common)
- Related domain concepts
- Complementary patterns (e.g., a problem and its solution)

**Quality criteria**:
- Suggest specific links with reasons: "[[Circuit Breaker]] should link to [[Retry Pattern]] — both address resilience"
- Limit to 5-7 highest-value suggestions to avoid noise
- Prioritize notes that currently have zero or few outgoing links

### Section 4: Problem Signals

Detect recurring problem areas from git commit history:
- Match commit messages against patterns: `fix:`, `bug`, `hotfix`, `revert`, `workaround`
- Cluster matched commits by extracted keywords
- **Report only clusters with 3+ commits** in the period

**Quality criteria**:
- Include example commit messages as evidence
- Suggest creating a vault note if the problem area represents a learnable concept
- If no clusters meet the threshold, state "No significant fix patterns detected"

### Section 5: Uncaptured Work

Compare git activity to vault coverage:
- Identify areas with significant commit activity but no corresponding vault notes
- Suggest running `/learning-vault:learn-review` for detailed discovery (requires the `learning-vault` plugin)

**Quality criteria**:
- Define "significant" as 5+ commits in an area during the period. In monorepos or high-activity projects, raise this threshold proportionally (e.g., 10+ for projects averaging 50+ commits/week)
- Map commit paths to topic areas by extracting the top-level directory or feature name (e.g., `services/notification/` → "notification patterns")
- Reference the specific commands to capture missing knowledge
- Do not duplicate what `/learn-review` does — just flag the gap and point to the command

## Digest Frontmatter

When saving a digest to Obsidian, use this frontmatter schema:

```yaml
type: retrospective
date: YYYY-MM-DD
period: 7d|14d|30d
note_count: [vault notes analyzed]
card_count: [Anki reviews in period]
```

Save to `Retros/YYYY-Www.md` using ISO week number (e.g., `2026-W07.md`).

## Cross-Source Data Mapping

The key analytical value comes from connecting data across sources:

| Vault Signal | Anki Signal | Git Signal | Interpretation |
|---|---|---|---|
| Many notes, one tag | High retention | Few fix commits | Concept well-learned and applied |
| Many notes, one tag | Low retention | Many fix commits | Knowledge captured but not retained — needs active review |
| No notes | N/A | Many commits | Active work area with uncaptured learnings |
| Notes exist | No cards | N/A | Concept captured but not reinforced with spaced repetition |
| Notes exist | Low retention | Few fix commits | Review habit issue — concepts not being applied, Anki drills falling behind |
| Few notes | High retention | Many commits | Practical expertise outpacing documentation — capture the implicit knowledge |
| Notes exist | High retention | Many fix commits | Retained knowledge but applied incorrectly — may indicate a misconception worth investigating |

Use this mapping to generate insights that no single source could provide alone. Not every combination will appear in every retrospective — focus on the signals that are actually present in the data.

## Common Edge Cases

### Low-Data Periods

When the vault has 0-2 notes in the period:
- Still produce the digest, but acknowledge the light activity
- Topic clusters may be empty or single-note — frame as "emerging" rather than incomplete
- Connection suggestions are less useful with fewer nodes — focus on linking new notes to older ones outside the period
- The digest summary should note: "Light learning week — consider if this reflects reduced coding activity or uncaptured learnings"

### New Anki Users

When Anki has fewer than 50 total reviews in the period:
- Retention percentages are unreliable with small samples — always flag this
- Append "(small sample — N reviews)" to any retention figure below 20 reviews
- Avoid "Needs attention" labels on tags with fewer than 10 reviews — the data isn't meaningful yet
- Suggest building the Anki habit before drawing retention conclusions

### Multi-Repository Work

When the user works across multiple repositories:
- The retro command only analyzes the current working directory's git history
- If vault notes reference work in other repos, those commits won't appear in problem signals or uncaptured work
- Note this limitation in the digest when vault tags suggest broader work than git history reflects
- The user can run the retro from different repos for a complete picture

### Empty Vault (First-Time Use)

When `Knowledge/` has no notes:
- Skip topic clusters and connection suggestions (no data)
- Still produce retention check (if Anki available) and problem signals (from git)
- Uncaptured work section becomes the primary value — everything is uncaptured
- Suggest: "Start capturing concepts with `/learning-vault:learn` to get the most value from future retrospectives"

## Tone and Style

- **Scannable**: Use bullet points, short paragraphs, and clear headers
- **Evidence-based**: Reference specific notes, cards, and commits
- **Actionable**: Every observation should suggest a next step
- **Honest**: State when data is insufficient rather than speculating
- **Encouraging**: Highlight progress and strong areas alongside gaps

## Additional Resources

### Reference Files

For detailed template formatting and section examples, consult:
- **`references/digest-format.md`** — Complete template with good vs. bad examples for each section, retention thresholds, and formatting conventions
