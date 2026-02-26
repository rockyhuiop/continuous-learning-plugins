---
description: Analyze recent git history to discover learnable concepts, patterns, and terminology worth capturing to your Obsidian vault
argument-hint: Optional number of days to analyze (default: 7)
allowed-tools: ["Read", "Grep", "Glob", "Bash", "AskUserQuestion", "Task", "mcp__obsidian__search_notes", "mcp__obsidian__list_directory"]
---

# Learn Review Command

Analyze the user's recent development work to discover concepts, patterns, and terminology worth capturing as learning notes. ACE-aware: shows which vault folder existing notes live in, and pre-fills routing when git context matches an active Effort.

## Process

1. **Determine time range**:
   - If `$ARGUMENTS` specifies days, use that number
   - Default: last 7 days

2. **Analyze git history**: Run git commands to gather recent work:
   ```bash
   # Get commits from last N days
   git log --since="{N} days ago" --oneline --all

   # Get changed files
   git log --since="{N} days ago" --name-only --pretty=format: | sort -u

   # Get commit messages for context
   git log --since="{N} days ago" --pretty=format:"%s%n%b" --all
   ```

3. **Identify learnable concepts**: Look for indicators of learning opportunities:

   **Architecture Patterns**:
   - New directory structures suggesting patterns (e.g., `/adapters`, `/ports`, `/domain`)
   - Service/controller organization changes
   - New middleware or interceptors
   - Event handlers or message queues

   **Technical Terminology**:
   - Comments with technical terms
   - New dependencies in package.json/requirements.txt
   - Configuration for new tools or services

   **Implementation Techniques**:
   - Error handling patterns
   - Caching implementations
   - Authentication/authorization changes
   - API design patterns
   - Database schema changes

   **Lessons Learned**:
   - Bug fixes with meaningful commit messages
   - Refactoring commits
   - Performance improvements

4. **Discover active Efforts**: Use `mcp__obsidian__list_directory` on `Efforts/` to get the current effort subfolder names. Store these for routing pre-fill in step 6.

5. **Check existing notes**: For each identified concept, search `Atlas/` and `Efforts/` to avoid suggesting duplicates:
   ```
   mcp__obsidian__search_notes with concept keywords
   ```

6. **Present findings**: Show the user a categorized list of discovered concepts:

   ```
   ## Learning Opportunities from Last 7 Days

   ### Architecture Patterns
   - **Strangler Fig Pattern** - Seen in: migration of UserService
     Commits: abc123, def456
     → Suggested: Atlas

   ### New Dependencies
   - **Redis caching** - Added in package.json
     Might be worth documenting: caching strategies
     → Suggested: Atlas

   ### Techniques
   - **Circuit breaker pattern** - Implemented in API client
     File: services/apiClient.js
     → Suggested: Atlas

   ### Already Documented
   - Event sourcing → Atlas/Event Sourcing.md
   - STAR Interview Format → Efforts/MTR Interview Preparation/STAR Interview Format.md
   ```

7. **Offer to capture**: Ask user which concepts they want to capture:
   - Provide numbered list
   - User selects one or more
   - For each selected, trigger the `/learn` workflow with routing pre-filled when git context matches an active Effort (see ACE Routing Pre-fill below)

## Discovery Heuristics

**Strong indicators of learnable concepts**:
- Commit messages containing: "implement", "add", "introduce", "migrate", "refactor"
- New files in patterns directories
- Configuration for external services
- Comments with "TODO: document" or technical explanations
- Multiple files changed with consistent naming pattern

**Weaker indicators** (mention but don't emphasize):
- Routine CRUD operations
- Simple bug fixes
- Dependency updates without architectural impact
- Formatting/linting changes

## Output Format

Present findings in a clear, actionable format:

```
# Learning Review: {date range}

Found {N} potential learning opportunities from your recent work.

## Recommended to Capture

1. **{Concept Name}** [{suggested tags}]
   - Evidence: {where seen}
   - Why: {brief explanation of learning value}

2. **{Concept Name}** [{suggested tags}]
   ...

## Already in Your Vault
- {Concept}: {link to existing note}

## Lower Priority
- {Minor concepts that might not need full notes}

---

Which concepts would you like to capture? (Enter numbers, e.g., "1, 3")
```

## ACE Routing Pre-fill

When passing a concept to `/learn`, pre-fill the routing step if git context suggests an Effort:

- **Branch name match**: if the current branch name contains words from an Effort subfolder name (case-insensitive), pre-select that Effort and confirm with the user:
  > "Git context suggests this belongs in **Efforts/MTR Interview Preparation/**. Correct?"
  > Options: Yes | No, put in Atlas | No, choose different Effort

- **No clear match**: pass to `/learn` with routing question unanswered — the user decides normally.

## Integration with /learn

When user selects concepts to capture:
1. For each selected concept, gather the relevant context from git
2. Pre-fill as much as possible (project, source=implementation, example from actual code, ACE routing if inferrable)
3. Ask only the essential questions (definition, related concepts)
4. Create notes efficiently

## Example

User: `/learn-review`

Output:
```
# Learning Review: Jan 21-28, 2026

Found 4 potential learning opportunities from your recent work.

## Recommended to Capture

1. **Strangler Fig Pattern** [pattern, architecture, migration]
   - Evidence: Created /adapters directory, gradual service migration in commits
   - Why: Core pattern for your legacy modernization work
   - → Suggested: Atlas

2. **Circuit Breaker** [pattern, resilience, api]
   - Evidence: New resilience.js with timeout/retry logic
   - Why: Production reliability pattern worth documenting
   - → Suggested: Atlas

3. **Server-Sent Events (SSE)** [technique, api, streaming]
   - Evidence: Multiple endpoints now use SSE for AI streaming
   - Why: Key technique for real-time features
   - → Suggested: Atlas

## Already in Your Vault
- Event Sourcing → Atlas/Event Sourcing.md
- STAR Interview Format → Efforts/MTR Interview Preparation/STAR Interview Format.md

## Lower Priority
- JWT refresh token flow (routine auth update)

---

Which concepts would you like to capture? (Enter numbers, e.g., "1, 3")
```
