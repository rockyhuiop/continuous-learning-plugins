# cloud-infra-estimator

Analyzes a software system across one or more repositories to estimate the Azure cloud infrastructure required to support a target scale (concurrent users). Outputs a formatted, presentation-ready `.xlsx` report.

## Features

- Multi-repo analysis (frontend, backend, database, infra repos)
- Automatic service topology detection from Dockerfiles, k8s manifests, Terraform/Bicep
- Load modeling: concurrent users → per-service RPS/QPS
- Three-tier sizing: Minimum / Recommended / Peak
- Azure SKU recommendations with monthly cost estimates
- Formatted `.xlsx` report with 5 sheets: Summary, Services, Cost Breakdown, Load Model, Assumptions

## Installation

Install via the Claude Code plugin marketplace or copy this directory to your plugins folder.

**Python dependency** (for report generation):
```bash
pip install openpyxl
```

## Usage

Trigger the estimation workflow by asking:

```
Estimate cloud infrastructure for my system at ./my-repo for 1500 concurrent users
```

Or with multiple repos:
```
Estimate Azure infra for ./frontend ./api ./data-service — target 2000 concurrent users
```

Claude will interactively ask for any missing information (e.g., missing backend repo, no scale target provided).

### Output

The plugin generates `./infra-estimate.xlsx` (or a path you specify) with these sheets:

| Sheet | Contents |
|-------|---------|
| Summary | Executive overview, total cost range, services list |
| Services | Per-service Azure SKU across Min / Recommended / Peak tiers |
| Cost Breakdown | Monthly cost per service per tier + bar chart |
| Load Model | Concurrent users → RPS/QPS calculations |
| Assumptions | All inference notes and scaling assumptions |

## Components

| Component | Purpose |
|-----------|---------|
| `skills/estimate/` | Main estimation workflow skill |
| `skills/xlsx-report/` | Report generation guidance |
| `agents/repo-analyzer.md` | Autonomous repo scanning agent |
| `scripts/generate_report.py` | xlsx generation script (openpyxl) |

## Supported Cloud Providers

- **Azure** (default) — full SKU catalog and pricing
- AWS and GCP — basic sizing supported, Azure SKU mapping used as baseline

## Customization

- **Fan-out ratios**: Adjust in the estimate skill's load modeling section
- **Peak multiplier**: Default 3×; override when prompted
- **Output path**: Specify any writable path; defaults to `./infra-estimate.xlsx`
- **Report layout**: Edit `scripts/generate_report.py` — palette constants at top of file

## Requirements

- Python 3.8+
- `openpyxl` (`pip install openpyxl`)
- Read access to target repositories
