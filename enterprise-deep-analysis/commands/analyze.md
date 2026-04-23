---
description: Run a full 5-chapter enterprise strategy and stock price deep analysis
argument-hint: "[company name or ticker, e.g. Adobe (ADBE)]"
---

# Enterprise Deep Analysis

Execute a structured 5-chapter investment analysis report for a target company, outputting in Traditional Chinese.

## Variable Collection

Parse `$ARGUMENTS` for the company name/ticker. Then collect any missing variables interactively using `AskUserQuestion`:

| Variable | Required | Example |
|---|---|---|
| Company name & ticker | Yes (from args) | Adobe (ADBE) |
| Current price & market cap | Yes | $450, US$200B |
| Core threat | Yes | Open-source AI models threatening creative software dominance |
| Analysis date | Auto-fill today | 2026-04-24 |

If the user provides only a company name, ask for the remaining variables. If price/market cap is unknown, dispatch the `data-researcher` agent to look them up.

## Execution Steps

### Step 1: Gather Data

Dispatch the `data-researcher` agent to collect:
- Latest financial metrics and earnings data
- Analyst consensus and price targets
- Macro environment (Fed rates, sector ETFs, VIX)
- Regulatory and geopolitical developments
- Sector momentum and peer performance
- Upcoming catalysts calendar
- Sentiment signals (insider trading, institutional flows, short interest)

### Step 2: Load Analysis Framework

Read the skill knowledge by triggering the `analyze` skill context, then read the detailed report template at `${CLAUDE_PLUGIN_ROOT}/skills/analyze/references/report-template.md`.

### Step 3: Generate Report

Produce the 5-chapter report in Traditional Chinese following the template structure:

1. **第一章：公司概況與核心財務數據解析** — Market position, catalysts, key financials, macro context
2. **第二章：未來競爭戰略與勝負判定條件** — Strategic response, quantifiable win/loss criteria
3. **第三章：護城河危機與替代工作流推演** — Killer workflow war-gaming, last line of defense
4. **第四章：剩餘價值與市值重估分析** — Residual value floor, comparable analysis
5. **第五章：12-18 個月目標價設定與情境模型** — Three-scenario model, catalyst calendar, risk matrix, weighted target price, investment recommendation

### Step 4: Deliver

Format with Markdown, bold key data points, use tables for metrics and scenarios. Every conclusion must be backed by business logic.
