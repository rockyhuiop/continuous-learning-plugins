---
name: ace-routing
description: ACE folder routing logic for the learning-vault plugin. Use when determining where a note should be saved in an ACE-structured Obsidian vault. Defines the rules for Atlas, Efforts, and + inbox placement.
version: 1.0.0
---

# ACE Folder Routing

Single source of truth for where notes go in an ACE-structured vault.

## Folder Purposes

| Folder | Purpose | Default? |
|--------|---------|----------|
| `Atlas/` | Permanent, reusable reference knowledge | Yes |
| `Efforts/{name}/` | Project-specific material tied to a time-bound goal | No |
| `+/` | Quick capture inbox — no structure yet, processed later | `/learn-quick` only |

## Step 1: Discover Active Efforts

Use `mcp__obsidian__list_directory` on `Efforts/` to get current subfolder names.

- If `Efforts/` is **empty or missing**: skip the routing question — all notes go to `Atlas/`.
- If `Efforts/` has subfolders: present them as routing options alongside Atlas.

## Step 2: Ask the Routing Question

> "Where should this note live?"
>
> Options:
> - **Atlas** — permanent knowledge, reusable across projects
> - **{Effort 1 name}** — specific to this active effort
> - **{Effort 2 name}** — specific to this active effort
> - *(... one option per discovered Effort subfolder)*

**Choose Atlas when:**
- The concept is a general pattern, technique, or methodology
- You'd reference it from multiple future notes or projects
- It remains useful after any current effort ends

**Choose Efforts/{name}/ when:**
- The note serves one specific time-bound goal
- It will lose relevance once that effort is complete
- It's a project-specific technique, reference, or preparation material

## Step 3: Resolve the Destination Path

| User choice | Destination path |
|-------------|-----------------|
| Atlas | `Atlas/{Title}.md` |
| Effort name | `Efforts/{Effort Subfolder Name}/{Title}.md` |
| (quick capture) | `+/{Title}.md` |

## Frontmatter `ace` Field

Every note created by this plugin must include an `ace` field:

```yaml
ace: atlas                              # permanent knowledge
ace: efforts/mtr-interview-preparation  # effort-specific (lowercase, hyphenated)
ace: inbox                              # quick capture in +/
```

Derive the `ace` value by lowercasing the Effort folder name and replacing spaces with hyphens.

This field enables Obsidian Dataview queries to surface notes by their ACE role — for example, finding all inbox notes due for processing, or all notes tied to a specific effort.

## Pre-filling Routing (for `/learn-review`)

When routing is triggered from `/learn-review`, git context may already indicate the right Effort. Pre-select it if:
- The commits being reviewed are from a branch whose name matches an Effort subfolder
- The changed files are inside a directory whose name matches an Effort

In this case, skip the routing question and tell the user which Effort was inferred:
> "Git context suggests this belongs in **Efforts/MTR Interview Preparation/**. Correct?"
> Options: Yes | No, put in Atlas | No, choose a different Effort
