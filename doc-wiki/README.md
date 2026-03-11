# doc-wiki

A Claude Code plugin that generates comprehensive internal documentation for any codebase and publishes it as a Confluence wiki.

## What It Does

1. **Analyzes your codebase** — Extracts all features, endpoints, services, workflows, and configuration
2. **Finds documentation gaps** — Compares existing docs against the feature inventory
3. **Designs a page tree** — Creates a logical Confluence page hierarchy grouped by domain
4. **Generates an implementation plan** — Creates a task-per-page plan using `superpowers:write-plans`
5. **Orchestrates writing & publishing** — Uses `docs-architect` agent for content, Atlassian MCP for Confluence

## Prerequisites

Install these Claude Code plugins for full functionality:

- **atlassian** — Direct Confluence publishing via MCP
- **code-documentation** — `docs-architect` agent for technical writing
- **superpowers** — Plan generation and execution

Without these, the plugin still generates local Markdown files.

## Usage

```
/doc-wiki:doc-wiki [space-key] [parent-page-name]
```

Examples:
```
/doc-wiki:doc-wiki CanpanionIwiki my-project-docs
/doc-wiki:doc-wiki ENGINEERING platform-docs
```

## Components

| Component | Type | Purpose |
|-----------|------|---------|
| `doc-wiki` | Command | Main entry point — orchestrates the full workflow |
| `codebase-analyzer` | Agent | Deep codebase analysis for feature extraction |
| `wiki-workflow` | Skill | Workflow knowledge, page templates, publishing patterns |

## Output

- `docs/wiki/` — Local Markdown files (git-tracked source of truth)
- `docs/wiki/.confluence-ids.json` — Confluence page ID mapping
- `docs/plans/[date]-confluence-documentation-wiki.md` — Implementation plan

## How It Works

```
/doc-wiki:doc-wiki
       │
       ▼
┌──────────────────┐
│ codebase-analyzer │  ← Agent extracts feature inventory
│    (agent)        │
└────────┬─────────┘
         ▼
┌──────────────────┐
│  Gap Analysis     │  ← Compare vs existing docs
└────────┬─────────┘
         ▼
┌──────────────────┐
│  Page Tree Design │  ← User confirms structure
└────────┬─────────┘
         ▼
┌──────────────────┐
│  write-plans      │  ← superpowers skill generates plan
│  (skill)          │
└────────┬─────────┘
         ▼
┌──────────────────┐
│  docs-architect   │  ← code-documentation agent writes pages
│  + atlassian MCP  │  ← publishes to Confluence
└──────────────────┘
```
