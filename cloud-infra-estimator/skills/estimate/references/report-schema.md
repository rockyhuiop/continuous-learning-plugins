# Report Data JSON Schema

The `generate_report.py` script accepts a JSON file with this structure.

---

## Top-Level Structure

```json
{
  "meta": { ... },
  "services": [ ... ],
  "load_model": { ... },
  "cost_summary": { ... },
  "assumptions": [ ... ],
  "architecture_notes": [ ... ]
}
```

---

## `meta` Object

```json
{
  "system_name": "MyApp",
  "target_concurrent_users": 1500,
  "peak_multiplier": 3.0,
  "generated_at": "2026-04-10",
  "cloud_provider": "Azure",
  "region": "East US",
  "repos_analyzed": [
    "/path/to/frontend",
    "/path/to/backend",
    "/path/to/infra"
  ]
}
```

---

## `services` Array

Each element represents one deployable service:

```json
{
  "name": "API Backend",
  "type": "container_app",
  "language": "Node.js",
  "detected_from": "Dockerfile, k8s/deployment.yaml",
  "sizing": {
    "min": {
      "sku": "Container Apps 0.5 vCPU / 1 Gi",
      "replicas": 1,
      "monthly_usd": 18
    },
    "recommended": {
      "sku": "Container Apps 1 vCPU / 2 Gi",
      "replicas": 3,
      "monthly_usd": 72
    },
    "peak": {
      "sku": "Container Apps 2 vCPU / 4 Gi",
      "replicas": 6,
      "monthly_usd": 288
    }
  },
  "notes": "Stateless REST API. Scales horizontally. No persistent storage."
}
```

**`type` values:** `container_app`, `app_service`, `aks_workload`, `function_app`, `static_web_app`, `postgresql`, `mysql`, `cosmos_db`, `redis`, `service_bus`, `event_hubs`, `api_management`, `blob_storage`, `front_door`

---

## `load_model` Object

```json
{
  "concurrent_users": 1500,
  "requests_per_user_per_second": 0.5,
  "services": [
    {
      "name": "API Backend",
      "avg_rps": 1500,
      "peak_rps": 4500,
      "fan_out_ratio": 2.0,
      "cache_hit_ratio": 0.0,
      "notes": "2 API calls per user action"
    },
    {
      "name": "PostgreSQL",
      "avg_qps": 1350,
      "peak_qps": 4050,
      "fan_out_ratio": 3.0,
      "cache_hit_ratio": 0.7,
      "notes": "70% cache hit via Redis reduces effective DB load"
    }
  ]
}
```

---

## `cost_summary` Object

```json
{
  "min_monthly_usd": 420,
  "recommended_monthly_usd": 1240,
  "peak_monthly_usd": 3680,
  "currency": "USD",
  "notes": "Excludes data transfer costs. Add ~10% for egress."
}
```

---

## `assumptions` Array

```json
[
  {
    "category": "Load Model",
    "assumption": "0.5 requests/user/second (one action every 2 seconds)",
    "basis": "Industry default for interactive web apps"
  },
  {
    "category": "Database",
    "assumption": "70% cache hit ratio on Redis",
    "basis": "Typical for read-heavy APIs with standard caching"
  },
  {
    "category": "Peak",
    "assumption": "3× average load for peak tier",
    "basis": "Standard burst headroom for production systems"
  }
]
```

---

## `architecture_notes` Array

```json
[
  {
    "category": "Finding",
    "item": "No caching layer detected",
    "recommendation": "Add Azure Cache for Redis to reduce DB load by ~70%"
  },
  {
    "category": "Cost Optimization",
    "item": "All services on pay-as-you-go",
    "recommendation": "1-year reserved instances save ~35% on compute"
  },
  {
    "category": "Reliability",
    "item": "Single region deployment",
    "recommendation": "Consider active-passive multi-region for >99.9% SLA"
  }
]
```

---

## Minimal Valid Example

```json
{
  "meta": {
    "system_name": "MyApp",
    "target_concurrent_users": 1500,
    "peak_multiplier": 3.0,
    "generated_at": "2026-04-10",
    "cloud_provider": "Azure",
    "region": "East US",
    "repos_analyzed": ["./"]
  },
  "services": [
    {
      "name": "API Backend",
      "type": "container_app",
      "language": "Node.js",
      "detected_from": "Dockerfile",
      "sizing": {
        "min": { "sku": "0.5 vCPU / 1 Gi × 1", "replicas": 1, "monthly_usd": 18 },
        "recommended": { "sku": "1 vCPU / 2 Gi × 3", "replicas": 3, "monthly_usd": 72 },
        "peak": { "sku": "2 vCPU / 4 Gi × 6", "replicas": 6, "monthly_usd": 288 }
      },
      "notes": ""
    }
  ],
  "load_model": {
    "concurrent_users": 1500,
    "requests_per_user_per_second": 0.5,
    "services": [
      { "name": "API Backend", "avg_rps": 750, "peak_rps": 2250, "fan_out_ratio": 1.0, "cache_hit_ratio": 0.0, "notes": "" }
    ]
  },
  "cost_summary": {
    "min_monthly_usd": 18,
    "recommended_monthly_usd": 72,
    "peak_monthly_usd": 288,
    "currency": "USD",
    "notes": ""
  },
  "assumptions": [],
  "architecture_notes": []
}
```
