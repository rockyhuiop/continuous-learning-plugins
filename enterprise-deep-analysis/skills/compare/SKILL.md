---
name: compare
description: This skill should be used when the user asks to "compare two companies", "side-by-side stock analysis", "compare moats", "which company is better positioned", "比較兩家公司", "對比分析", or wants a structured comparison of two enterprises across financial, strategic, valuation, and macro resilience dimensions. Produces a 6-dimension comparison report in Traditional Chinese.
argument-hint: "[company A] vs [company B], e.g. Adobe vs Canva"
---

# Enterprise Comparison Analysis

Produce a structured side-by-side comparison of two companies across five dimensions, in Traditional Chinese.

## Persona

Same analyst persona as the `analyze` skill — top-tier Wall Street tech stock analyst with expertise in financial analysis, valuation models, moat theory, and disruptive technology assessment.

## Workflow

### Step 1: Collect Inputs

Gather from the user:
- **Company A**: Name, ticker, current price/market cap
- **Company B**: Name, ticker, current price/market cap
- **Comparison context** (optional): Specific angle or threat to focus on (e.g., "both competing in AI-powered design tools")

If the user provides only company names, dispatch the `data-researcher` agent to look up current prices and market caps.

### Step 2: Research Both Companies

Dispatch the `data-researcher` agent to gather current financial data, competitive positioning, and recent developments for both companies.

### Step 3: Generate 6-Dimension Comparison

Read the comparison framework at `${CLAUDE_PLUGIN_ROOT}/skills/compare/references/comparison-framework.md` for the detailed structure.

The six comparison dimensions:

1. **財務體質對比** — Revenue growth, margins, NRR, FCF, Rule of 40
2. **競爭戰略對比** — Strategic positioning, response to threats, offensive vs defensive posture
3. **護城河強度對比** — Switching costs, network effects, data moats, ecosystem lock-in
4. **估值水位對比** — P/S, P/E, PEG ratios, relative valuation to peers
5. **情境勝率對比** — Under base/bull/bear scenarios, which company is better positioned
6. **宏觀韌性對比** — Interest rate sensitivity, geopolitical exposure, regulatory risk, sector momentum alignment

### Step 4: Deliver Verdict

Conclude with:
- A clear comparison table summarizing all five dimensions
- An overall verdict: which company has the stronger position and why
- Specific conditions under which the verdict would flip
- Actionable recommendation for investors choosing between the two

## Output Language

All content in **Traditional Chinese (繁體中文)** with professional financial terminology.

## Reference Files

- **`references/comparison-framework.md`** — Detailed comparison table structure and scoring methodology
