---
name: XLSX Report Generator
description: This skill should be used when the user asks to "generate the xlsx report", "create the Excel file", "write the infrastructure report", "format the Excel output", or when the estimate workflow reaches the report generation step. Guides production of a well-formatted, aesthetically clean .xlsx infrastructure report using openpyxl.
version: 0.1.0
---

# XLSX Report Generator

Produce a formatted, easy-to-read `.xlsx` infrastructure estimation report using the `generate_report.py` script bundled with this plugin.

## Running the Script

Use `uv run` — no manual package installation needed:

```bash
uv run --with openpyxl \
  python3 $CLAUDE_PLUGIN_ROOT/scripts/generate_report.py \
  --data <path-to-data.json> \
  --output <output-path.xlsx>
```

`uv` creates an ephemeral isolated environment on the fly. If `uv` is not available, fall back to:

```bash
pip install openpyxl
python3 $CLAUDE_PLUGIN_ROOT/scripts/generate_report.py \
  --data <path-to-data.json> \
  --output <output-path.xlsx>
```

The `--data` argument accepts a JSON file matching the schema in `references/report-schema.md`.

## Design Principles

The report uses a minimal, professional aesthetic:

- **Color palette**: Azure blue (`#0078D4`) headers, white body, light grey alternating rows (`#F5F5F5`), amber accent (`#FFB900`) for peak tier
- **Typography**: Calibri 11pt body, Calibri 13pt bold headers
- **Layout**: Frozen header rows, auto-fitted column widths, no gridlines on Summary sheet
- **Conditional formatting**: Cost cells > $5,000/mo highlighted amber; > $10,000/mo highlighted red
- **Charts**: Bar chart on Cost Breakdown sheet comparing tiers per service

## Sheet Structure

| Sheet | Purpose | Key columns |
|-------|---------|-------------|
| Summary | One-page executive view | Metric, Value |
| Services | Per-service sizing | Service, Tier, SKU, vCPU, RAM, Replicas, Notes |
| Cost Breakdown | Monthly costs | Service, Min $, Recommended $, Peak $ |
| Load Model | Traffic calculations | Service, Concurrent Users, RPS/QPS, Fan-out, Cache Hit % |
| Architecture Notes | Findings & recommendations | Category, Finding, Recommendation |

## Troubleshooting

- **`ModuleNotFoundError: openpyxl`** — use `uv run --with openpyxl python3 ...` or run `pip install openpyxl`
- **Permission denied on output path** — check write permissions or use `./` prefix
- **Empty sheets** — verify JSON data file matches schema in `references/report-schema.md`

## Additional Resources

- **`references/report-schema.md`** — Full JSON input schema with examples
- **`scripts/generate_report.py`** — The report generation script
