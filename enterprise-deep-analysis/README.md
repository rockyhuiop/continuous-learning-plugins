# Enterprise Deep Analysis

Wall Street-grade enterprise strategy and stock price deep analysis plugin for Claude Code. Produces structured investment reports in Traditional Chinese with competitive moat assessment, valuation modeling, and three-scenario price targets.

## Features

- **5-Chapter Analysis Reports** — Full-depth company analysis covering financials, strategy, moat durability, residual value, and price targets
- **Company Comparison** — Side-by-side 5-dimension comparison of two companies
- **Quick Moat Check** — Rapid competitive moat health assessment with scorecard
- **Live Data Research** — Autonomous agent gathers current financial data via web search

## Usage

### Full Analysis

```
/enterprise-deep-analysis:analyze Adobe (ADBE)
```

Produces a structured 5-chapter report. Claude will ask for any missing inputs (stock price, market cap, core threat).

### Compare Two Companies

```
/enterprise-deep-analysis:compare Adobe vs Canva
```

Side-by-side comparison across financial health, strategy, moat strength, valuation, and scenario outcomes.

### Quick Moat Check

```
/enterprise-deep-analysis:moat-check Snowflake
```

Rapid 4-dimension moat scorecard with threat assessment.

## Components

| Component | Type | Purpose |
|-----------|------|---------|
| `analyze` | Skill | Core 5-chapter analysis framework |
| `compare` | Skill | Two-company comparison |
| `moat-check` | Skill | Quick moat health assessment |
| `data-researcher` | Agent | Gathers current financial data via web search |

## Output Language

All analysis output is in **Traditional Chinese (繁體中文)** using professional financial terminology.

## Installation

```bash
claude --plugin-dir /path/to/enterprise-deep-analysis
```
