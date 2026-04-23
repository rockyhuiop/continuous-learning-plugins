---
description: Compare two companies side-by-side across 6 dimensions
argument-hint: "[company A] vs [company B], e.g. Adobe vs Canva"
---

# Enterprise Comparison Analysis

Execute a structured 6-dimension side-by-side comparison of two companies, outputting in Traditional Chinese.

## Input Parsing

Parse `$ARGUMENTS` for two company names separated by "vs", "versus", "和", or "與". If only one company is provided or format is unclear, use `AskUserQuestion` to clarify.

Collect for each company:
- Company name & ticker
- Current price & market cap (dispatch `data-researcher` if not provided)

Optional: comparison context or specific angle to focus on.

## Execution Steps

### Step 1: Gather Data

Dispatch the `data-researcher` agent to collect current financial data, competitive positioning, macro environment, and recent developments for both companies.

### Step 2: Load Comparison Framework

Read the comparison framework at `${CLAUDE_PLUGIN_ROOT}/skills/compare/references/comparison-framework.md`.

### Step 3: Generate Comparison

Produce the 6-dimension comparison in Traditional Chinese:

1. **財務體質對比** — Revenue growth, margins, NRR, FCF, Rule of 40
2. **競爭戰略對比** — Strategic positioning, threat response, offensive vs defensive
3. **護城河強度對比** — Switching costs, network effects, data moats, pricing power
4. **估值水位對比** — P/S, P/E, PEG, relative valuation
5. **情境勝率對比** — Base/bull/bear scenario outcomes for each company
6. **宏觀韌性對比** — Interest rate sensitivity, geopolitical exposure, regulatory risk, sector momentum

### Step 4: Deliver Verdict

Conclude with summary table, overall verdict, flip conditions, and actionable recommendation.
