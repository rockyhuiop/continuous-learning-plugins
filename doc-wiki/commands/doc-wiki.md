---
name: doc-wiki
description: "Analyze a codebase, extract features, design a Confluence wiki page tree, generate an implementation plan, and orchestrate documentation writing and publishing."
argument-hint: "[confluence-space-key] [parent-page-name]"
allowed-tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob", "Agent", "Skill"]
---

# Documentation Wiki Generator

Generate comprehensive internal documentation for a codebase and publish it as a Confluence wiki.

## Workflow

Follow these steps in order. Each step builds on the previous.

### Step 1: Gather Configuration

Parse arguments for Confluence space key and parent page name. If not provided, ask the user:
- **Space key**: The Confluence space to publish to (e.g., `CanpanionIwiki`)
- **Parent page name**: The root page all documentation lives under (e.g., `my-project-docs`)

Also determine:
- The project root directory (current working directory)
- Whether the atlassian plugin is installed (check for atlassian MCP tools)
- Whether the code-documentation plugin is installed (check for docs-architect agent)

If either plugin is missing, inform the user:
```
This workflow works best with these Claude Code plugins installed:
- atlassian (for direct Confluence publishing)
- code-documentation (for docs-architect agent)

Without them, local Markdown files will still be generated.
```

### Step 2: Codebase Feature Extraction

Dispatch the `doc-wiki:codebase-analyzer` agent to perform deep codebase analysis. The agent will return a structured feature inventory covering:

- Architecture overview (frameworks, patterns, entry points)
- All API endpoints (REST, WebSocket, GraphQL)
- Services and business logic modules
- Configuration and feature flags
- Database models and schemas
- Key workflows and pipelines

### Step 3: Existing Documentation Gap Analysis

Search for existing documentation in the project:

```
Glob patterns to check:
- docs/**/*.md
- docs/**/*.html
- README.md
- **/README.md
- docs/demos/**/*.html
- wiki/**/*.md
```

Compare the feature inventory from Step 2 against existing docs. Identify:
- **Documented features**: Features with adequate existing documentation
- **Partially documented**: Features mentioned but lacking detail
- **Undocumented features**: Features with no documentation at all

Present the gap analysis as a table to the user.

### Step 4: Design Page Tree

Based on the feature inventory and gap analysis, design a Confluence page hierarchy. Follow these principles:

**Grouping**: Organize by functional domain, not by file structure.
- Group related features into sections (e.g., "Voice Endpoints", "REST API", "Safety & Crisis")
- Each section becomes a parent page with child pages per feature

**Page Template** (each feature page should follow this structure):
```markdown
# [Feature Name]

## Overview
Brief description of what this feature does and why it exists.

## Architecture
How the feature is structured. Include diagrams where helpful.

## How It Works
Step-by-step explanation of the feature's workflow.

## Configuration
Feature flags, environment variables, and settings.

## API / Protocol
Endpoints, WebSocket messages, request/response formats.

## Integration Points
How this feature connects to other parts of the system.

## Troubleshooting
Common issues and how to resolve them.
```

**Naming**: Use clear, descriptive page titles (e.g., "Cantonese Voice Call Pipeline" not "voice_call_yue.py").

Present the proposed page tree to the user for confirmation before proceeding.

### Step 5: Generate Implementation Plan

Invoke the `superpowers:writing-plans` skill to create a detailed implementation plan. The plan should include:

- One task per documentation page (or group of closely related pages)
- Each task specifies: source files to read, page title, parent page, key sections to cover
- Tasks grouped into parallelization batches where pages are independent
- Estimated effort per task

The plan file should be saved to `docs/plans/[date]-confluence-documentation-wiki.md`.

**Plan task template**:
```markdown
### Task N: [Page Title]
- **Section**: [Parent section]
- **Source files**: [List of source files to analyze]
- **Key topics**: [What the page must cover]
- **Depends on**: [Any prerequisite tasks]

**Steps**:
1. Dispatch `code-documentation:docs-architect` agent to read source files and generate Markdown
2. Review generated content for accuracy
3. Save to `docs/wiki/[section]/[page-name].md`
4. Publish to Confluence using atlassian MCP `createConfluencePage`
5. Record page ID in `docs/wiki/.confluence-ids.json`
```

### Step 6: Create Local Directory Structure

Create the `docs/wiki/` directory tree matching the page hierarchy:

```bash
mkdir -p docs/wiki/[section-name]  # for each section
```

Create a `.confluence-ids.json` file to track page IDs:
```json
{
  "cloud_id": "",
  "space_key": "[from Step 1]",
  "pages": {}
}
```

### Step 7: Present Summary

Present the complete plan to the user:
- Total pages to write
- Estimated parallelization groups
- Local file tree
- Confluence page hierarchy
- Next steps (execute the plan using `superpowers:executing-plans` or manually)

Remind the user:
```
To execute this plan:
1. Run /superpowers:execute-plan to work through tasks systematically
2. Each task will use the docs-architect agent for content generation
3. Pages will be published to Confluence as they're completed
4. Progress is tracked in the plan file with checkboxes
```

## Important Notes

- **Never generate documentation without reading source code first**. The docs-architect agent must analyze actual source files.
- **Preserve existing documentation**. If good docs already exist, reference or link to them rather than rewriting.
- **Ask the user to confirm the page tree** before generating the plan. The structure is hard to change after pages are created.
- **Track Confluence page IDs**. Store them in `.confluence-ids.json` so pages can be updated later.
- **Local files are the source of truth**. Markdown files in `docs/wiki/` are committed to git. Confluence pages are published copies.
