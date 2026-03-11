---
name: wiki-workflow
description: "This skill should be used when the user asks to 'create documentation wiki', 'generate confluence docs', 'document this codebase', 'create internal docs', 'build a wiki for this project', or mentions creating comprehensive documentation from code. Provides the workflow knowledge for analyzing codebases and producing structured Confluence wiki pages."
---

# Documentation Wiki Workflow

## Overview

Orchestrate comprehensive internal documentation creation for any codebase. The workflow extracts features from source code, identifies documentation gaps, designs a Confluence page hierarchy, generates an implementation plan, and coordinates documentation writing and publishing.

## Prerequisites

**Required plugins** (Claude Code):
- `atlassian` — Confluence publishing via MCP (createConfluencePage, getConfluencePage)
- `code-documentation` — docs-architect agent for technical writing

**Required information** from user:
- Confluence space key (e.g., `CanpanionIwiki`)
- Parent page name (e.g., `my-project-docs`)

## Core Workflow

### Phase 1: Feature Extraction

Dispatch the `doc-wiki:codebase-analyzer` agent (defined in the plugin's `agents/` directory) to produce a structured feature inventory. The agent analyzes:
- Entry points and framework detection
- API surface (REST, WebSocket, GraphQL)
- Services and business logic
- Workflows and pipelines
- Configuration and feature flags
- Database models

### Phase 2: Gap Analysis

Search for existing documentation and compare against the feature inventory.

**Search patterns**:
- `docs/**/*.md`, `docs/**/*.html`
- `README.md`, `**/README.md`
- `docs/demos/**/*.html`
- `wiki/**/*.md`

Classify each feature as: **documented**, **partially documented**, or **undocumented**.

### Phase 3: Page Tree Design

Group features into logical sections by functional domain. Follow these principles:

- **Group by domain** (Voice Endpoints, REST API, Safety) not by file path
- **5-10 top-level sections** with 2-5 child pages each
- **Clear page titles** using human-readable names, not file names
- **Present to user for confirmation** before proceeding

### Phase 4: Plan Generation

Invoke the `superpowers:writing-plans` skill to create a task-per-page implementation plan. Each task specifies source files, target page title, parent section, and execution steps.

**Parallelization**: Group independent pages into batches. Pages within the same section can often be written in parallel.

### Phase 5: Execution

For each task in the plan:

1. **Write**: Dispatch `code-documentation:docs-architect` agent with source files → generates Markdown
2. **Review**: Check accuracy against source code
3. **Save**: Write to `docs/wiki/[section]/[page].md`
4. **Publish**: Use atlassian MCP `createConfluencePage` with parent page ID
5. **Track**: Record Confluence page ID in `.confluence-ids.json`

## Page Template

Each documentation page should follow this structure:

```markdown
# [Feature Name]

## Overview
What this feature does and why it exists.

## Architecture
Structural design. Diagrams where helpful (Mermaid).

## How It Works
Step-by-step workflow explanation.

## Configuration
Feature flags, environment variables, settings table.

## API / Protocol
Endpoints, message formats, request/response schemas.

## Integration Points
Connections to other system components.

## Troubleshooting
Common issues and resolutions.
```

Omit sections that don't apply to a given feature. Add feature-specific sections as needed.

## Confluence Publishing

### Page Creation

Use the atlassian MCP `createConfluencePage` tool:
- `cloudId`: From `getAccessibleAtlassianResources`
- `spaceKey`: User-provided space key
- `title`: Page title from the page tree
- `parentPageId`: Parent section's Confluence page ID
- `contentFormat`: `"markdown"`

### ID Tracking

Maintain `docs/wiki/.confluence-ids.json`:
```json
{
  "cloud_id": "abc-123",
  "space_key": "MYSPACE",
  "pages": {
    "parent": "12345",
    "sections": {
      "system-overview": "12346",
      "voice-endpoints": "12347"
    },
    "features": {
      "cantonese-voice-call": "12348"
    }
  }
}
```

### Page Updates

To update an existing page, use `updateConfluencePage` with the stored page ID. Always increment the version number.

## Dual-Output Pipeline

Local Markdown files in `docs/wiki/` are the **source of truth** (version-controlled in git). Confluence pages are **published copies**. This ensures:
- Documentation is code-reviewed via PRs
- History is tracked in git
- Confluence stays in sync via republishing

## Additional Resources

### Reference Files

For detailed guidance, consult:
- **`references/page-tree-examples.md`** — Example page hierarchies for different project types
