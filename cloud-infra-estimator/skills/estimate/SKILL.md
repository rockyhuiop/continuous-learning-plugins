---
name: Cloud Infrastructure Estimator
description: This skill should be used when the user asks to "estimate cloud infrastructure", "measure infrastructure requirements", "size Azure resources", "calculate cloud capacity", "how many VMs do I need", "infrastructure for N concurrent users", "cloud cost estimate", or "analyze repos for cloud sizing". Guides the full estimation workflow from repo analysis to .xlsx report generation.
version: 0.1.0
---

# Cloud Infrastructure Estimator

Analyze a software system across one or more repositories to estimate the Azure cloud infrastructure required to support a target number of concurrent users. Output a formatted `.xlsx` report.

## Workflow Overview

1. **Gather inputs** — collect repo paths, target scale, and cloud provider
2. **Analyze repos** — scan each repo for services, dependencies, and resource hints
3. **Model load** — translate concurrent users into per-service request rates
4. **Size resources** — map load to Azure SKUs (min / recommended / peak tiers)
5. **Estimate costs** — calculate monthly Azure cost per tier
6. **Generate report** — write `.xlsx` with formatted layout

## Step 1: Gather Inputs

Collect the following before proceeding. If any are missing, ask the user interactively:

| Input | Default | Notes |
|-------|---------|-------|
| Repo paths | Current session repo | Accept multiple local paths or GitHub URLs |
| Concurrent users | Required | e.g. `1500` average |
| Cloud provider | Azure | User may override to AWS or GCP |
| Output path | Current working directory | e.g. `./infra-estimate.xlsx` |
| Peak multiplier | 3× average | For peak tier sizing |

**Interactive prompts to ask if missing:**
- If only a frontend repo is provided: "Is there a backend API or database repo? Please provide paths."
- If no scale given: "What is the target number of average concurrent users?"
- If multiple services detected but no traffic split: "Should I assume equal traffic distribution across services, or do you have a split?"

## Step 2: Analyze Repositories

Use the `repo-analyzer` agent to scan each repo. The agent extracts:

- **Services**: Each independently deployable unit (containers, functions, APIs)
- **Tech stack**: Runtime, framework, language
- **Resource hints**: Memory limits in Dockerfiles, CPU requests in k8s manifests
- **Dependencies**: Databases, caches, queues, external APIs
- **Traffic patterns**: Route counts, middleware, connection pool sizes

Trigger the agent with:
```
Analyze [repo-path] for cloud infrastructure sizing. Extract all services, their tech stacks, resource hints from Dockerfiles/k8s/terraform, and inter-service dependencies.
```

Repeat for each repo. Merge results into a unified service map.

## Step 3: Model Load

Translate concurrent users into per-service request rates using the call graph.

**Base formula:**
```
RPS per service = (concurrent_users × requests_per_user_per_second) × fan_out_ratio
```

**Default assumptions (adjust based on analysis):**
- `requests_per_user_per_second`: 0.5 (one action every 2 seconds)
- Frontend → API fan-out: 1:2 (each user action triggers ~2 API calls)
- API → DB fan-out: 1:3 (each API call triggers ~3 DB queries)
- Cache hit ratio: 70% (reduces DB load by 0.7×)

**Example for 1,500 concurrent users:**
```
Frontend:  1500 × 0.5 = 750 RPS
API:       750 × 2    = 1,500 RPS
Database:  1,500 × 3 × 0.3 = 1,350 QPS (after cache)
Cache:     1,500 × 3 × 0.7 = 3,150 ops/s
```

Document all assumptions in the report's "Scaling Assumptions" sheet.

## Step 4: Size Azure Resources

For each service, produce three tiers:

| Tier | Multiplier | Purpose |
|------|-----------|---------|
| Minimum | 0.7× avg load | Cost floor, dev/staging |
| Recommended | 1.0× avg load | Production baseline |
| Peak | 3.0× avg load | Traffic spikes, safety margin |

**Azure SKU mapping — consult `references/azure-skus.md` for full tables.**

Quick reference:
- **App Service / Container Apps**: Map RPS → vCPU/RAM → SKU tier
- **Azure SQL / PostgreSQL Flexible**: Map QPS → DTUs or vCores
- **Azure Cache for Redis**: Map ops/s → C-tier or P-tier
- **Azure Service Bus / Event Hubs**: Map msg/s → throughput units
- **Azure Kubernetes Service**: Map total vCPU/RAM → node pool SKU + count

## Step 5: Estimate Costs

Use Azure public pricing (East US region as default). Consult `references/azure-pricing.md` for current rates.

Calculate monthly cost per service per tier:
```
monthly_cost = unit_price × quantity × 730 hours
```

Sum across all services for total monthly estimate per tier.

## Step 6: Generate the .xlsx Report

Run the report generation script:

```bash
python3 $CLAUDE_PLUGIN_ROOT/scripts/generate_report.py \
  --data /tmp/infra-estimate-data.json \
  --output ./infra-estimate.xlsx
```

Pass the analysis data as JSON to the script. See `references/report-schema.md` for the expected JSON structure.

The script produces a workbook with these sheets:
1. **Summary** — executive overview, total costs, key assumptions
2. **Services** — per-service sizing table (min/recommended/peak)
3. **Cost Breakdown** — monthly cost per service per tier
4. **Load Model** — RPS/QPS calculations with assumptions
5. **Architecture Notes** — detected dependencies, recommendations

## Additional Resources

- **`references/azure-skus.md`** — Azure SKU tables for all service types
- **`references/azure-pricing.md`** — Current Azure pricing reference
- **`references/report-schema.md`** — JSON schema for report data input
- **`scripts/generate_report.py`** — xlsx generation script (openpyxl)
