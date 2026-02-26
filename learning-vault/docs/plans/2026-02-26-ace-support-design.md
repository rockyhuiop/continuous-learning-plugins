# ACE Methodology Support Design

**Date**: 2026-02-26
**Status**: Approved — implementing

## Problem

The plugin hardcodes `Knowledge/` as the note destination. The vault has been restructured to ACE (Atlas / Calendar / Efforts), so notes are being written to the wrong folder. Additionally, the plugin has no understanding of ACE routing (Atlas vs Efforts) or the `+` inbox.

## Approach: Approach B — Add `ace-routing` skill

Extract all ACE folder logic into a single `skills/ace-routing/SKILL.md`. Both commands consume this skill, so folder rules have one source of truth.

## File Changes

| File | Change |
|------|--------|
| `skills/ace-routing/SKILL.md` | **NEW** — ACE folder routing rules |
| `commands/learn-quick.md` | **NEW** — fast capture to `+/` |
| `commands/learn.md` | Add routing step (scan Efforts, ask Atlas vs Efforts) |
| `commands/learn-review.md` | Update folder refs, pre-fill routing from git context |
| `skills/zettelkasten-notes/SKILL.md` | `Knowledge/` → `Atlas/` |
| `agents/learning-discovery.md` | `Knowledge/` → `Atlas/` |
| `.claude-plugin/plugin.json` | Update description + keywords |
| `README.md` | Update docs for new structure and command |

## ACE Routing Rules

- **Atlas/**: permanent, reusable knowledge. Default when no active Effort applies.
- **Efforts/{name}/**: project-specific, loses relevance when Effort completes.
- **+/**: quick capture stub, no Zettelkasten structure, processed later.
- Discover active Efforts by scanning `Efforts/` via `mcp__obsidian__list_directory`.
- Skip routing question if `Efforts/` is empty.

## New Frontmatter Field

All notes gain an `ace` field: `atlas`, `efforts/name`, or `inbox`.
