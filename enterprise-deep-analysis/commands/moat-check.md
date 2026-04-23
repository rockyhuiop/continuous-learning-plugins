---
description: Quick competitive moat health check with scorecard
argument-hint: "[company name or ticker]"
---

# Quick Moat Health Check

Execute a rapid 4-dimension moat assessment with macro risk flag, outputting a scorecard in Traditional Chinese.

## Input Parsing

Parse `$ARGUMENTS` for the company name/ticker. If empty, use `AskUserQuestion` to ask which company to assess.

Optionally accept a specific concern to focus on (e.g., "Snowflake — worried about Databricks").

## Execution Steps

### Step 1: Gather Data

Dispatch the `data-researcher` agent to collect competitive landscape data, recent developments, and macro context for the company.

### Step 2: Assess Four Moat Dimensions

For each dimension, assign a health rating: 🟢 強健 / 🟡 承壓 / 🔴 危險

| Dimension | Assessment Focus |
|---|---|
| 轉換成本 | Data lock-in, workflow integration, retraining cost |
| 網路效應 | User base interdependency, marketplace dynamics |
| 無形資產 | Brand, patents, regulatory licenses, proprietary data |
| 定價權 | Price increase tolerance, premium vs commodity positioning |

### Step 3: Identify Killer Workflow Threat

Describe the most dangerous alternative workflow, its maturity level (theoretical / emerging / actively displacing), and the company's last line of defense.

### Step 4: Deliver Scorecard

Output the moat scorecard with macro risk flag:

```
## 護城河健康度評分卡：[公司名稱]

| 維度 | 評級 | 關鍵依據 |
|------|------|---------|
| 轉換成本 | 🟢/🟡/🔴 | 一句話說明 |
| 網路效應 | 🟢/🟡/🔴 | 一句話說明 |
| 無形資產 | 🟢/🟡/🔴 | 一句話說明 |
| 定價權   | 🟢/🟡/🔴 | 一句話說明 |

**綜合評級**：[強健 / 承壓 / 危險]
**最大威脅**：[一句話描述]
**外部風險旗標**：[⚠️/✅ 宏觀風險提示]
**建議行動**：[觀察 / 減持 / 深入分析]
```

If moat shows 🔴 on two or more dimensions, recommend running `/enterprise-deep-analysis:analyze` for a full assessment.
