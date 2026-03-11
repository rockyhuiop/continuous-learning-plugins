---
name: update-wiki
description: "Update or append to existing wiki documentation pages after codebase changes. Optionally scope to specific pages and describe what changed."
argument-hint: "[page-name-or-section] [--describe \"what changed\"]"
allowed-tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob", "Agent", "Skill"]
---

# Update Wiki Pages

Update existing documentation wiki pages to reflect codebase changes. Supports targeted updates to specific pages, auto-detection of changes via git, and user-described change scoping.

## Workflow

### Step 1: Load Existing Wiki State

Read the wiki tracking file and local documentation:

1. **Read `.confluence-ids.json`** from `docs/wiki/.confluence-ids.json`
   - If missing, operate in local-only mode (no Confluence sync)
   - Extract `cloud_id`, `space_key`, and page ID mappings

2. **Inventory existing pages** by scanning `docs/wiki/**/*.md`
   - Build a map: `{ page-name → { local_path, confluence_id, section } }`

If no `docs/wiki/` directory exists, inform the user:
```
No existing wiki found. Run /doc-wiki:doc-wiki first to generate the initial documentation.
```

### Step 2: Determine Update Scope

Resolve which pages need updating based on the arguments provided:

**Mode A — Explicit page/section** (argument provided):
- Match the argument against page names and section names from the inventory
- If no match found, list available pages and ask the user to clarify

**Mode B — Described changes** (`--describe` flag):
- Parse the description to identify affected features, services, or endpoints
- Map described changes to existing wiki pages using file path and feature matching
- Present the affected pages to the user for confirmation

**Mode C — Auto-detect** (no arguments):
- Run `git diff --name-only HEAD~5..HEAD` (or since the last wiki update commit)
- Filter to source files only (exclude tests, docs, config)
- Map changed files to wiki pages using the source file references in each page
- Present the detected changes and affected pages to the user

Display the scope summary:
```
Detected changes affecting N wiki page(s):
| Page | Section | Change Source |
|------|---------|---------------|
| ... | ... | ... |

Proceed with update? (or specify pages to skip)
```

### Step 3: Analyze Changes

For each affected page:

1. **Read the current local Markdown** from `docs/wiki/[section]/[page].md`
2. **Read the source files** referenced by the page (from page metadata or content)
3. **Identify what changed** by comparing current source code against what the page documents

If `--describe` was provided, use the description to focus the analysis:
- Only examine sections of the page relevant to the described change
- Preserve all other sections unchanged

If auto-detected via git, use `git diff` on the relevant source files to understand the nature of changes.

### Step 4: Update Content

For each affected page, choose the appropriate update strategy:

**Full regeneration** — When the page is significantly outdated or the feature was restructured:
- Dispatch `code-documentation:docs-architect` agent with source files
- Generate complete new Markdown following the page template
- Preserve any manual annotations or notes marked with `<!-- manual -->` comments

**Section update** — When only specific sections changed (most common):
- Read the existing page
- Dispatch `code-documentation:docs-architect` agent with specific source files and the instruction to update only the affected sections
- Merge updated sections into the existing page, preserving unchanged sections

**Append** — When new content needs to be added to an existing page:
- Generate new section content via docs-architect agent
- Append to the appropriate location in the existing page
- Update the page's table of contents if present

Present the diff of each updated page to the user before saving:
```
Updated: [Page Name]
- Section "Configuration": Added 3 new feature flags
- Section "API / Protocol": Updated request schema
```

### Step 5: Save Local Files

Write updated Markdown to `docs/wiki/[section]/[page].md` for each changed page.

### Step 6: Sync to Confluence

If `.confluence-ids.json` exists and contains page IDs:

1. **Fetch current Confluence page** using atlassian MCP `getConfluencePage` to get the current version number
2. **Update the page** using atlassian MCP `updateConfluencePage`:
   - `pageId`: From `.confluence-ids.json`
   - `title`: Existing page title (or updated if changed)
   - `contentFormat`: `"markdown"`
   - `content`: Updated Markdown content
   - `version`: Current version + 1

3. **Report results**:
```
Updated N page(s):
| Page | Local | Confluence |
|------|-------|------------|
| [name] | docs/wiki/[path] | [confluence-url] |
```

If Confluence sync fails for any page, save locally and report the error — do not block the entire update.

### Step 7: Summary

Present the final summary:
- Pages updated (with links if Confluence sync succeeded)
- Pages skipped (unchanged)
- Any errors encountered
- Suggest committing the local changes: `git add docs/wiki/ && git commit -m "docs: update wiki pages"`

## Important Notes

- **Always read existing content before updating**. Never blindly overwrite — the page may contain manual edits.
- **Preserve `<!-- manual -->` blocks**. Any content between `<!-- manual -->` and `<!-- /manual -->` markers is user-maintained and must not be modified.
- **Show diffs before saving**. The user should see what changed in each page before it's written.
- **Version tracking**. After updating, Confluence version numbers are managed automatically — always fetch the current version before updating.
- **Local files are the source of truth**. Update local Markdown first, then sync to Confluence.
