# Azure Pricing Reference

Prices are East US region, pay-as-you-go (no reserved instances). Updated April 2026.
Apply a 30–40% discount for 1-year reserved instances, 55–65% for 3-year.

---

## Quick Cost Estimator

### Formula

```
monthly_cost = unit_price × quantity × hours_per_month
hours_per_month = 730
```

### Common Unit Prices

| Resource | Unit | Price |
|---|---|---|
| Container Apps vCPU | per vCPU-second | $0.000024 |
| Container Apps memory | per GiB-second | $0.000003 |
| App Service P1v3 | per instance/month | $81 |
| AKS Standard_D2s_v3 node | per node/month | $70 |
| AKS Standard_D4s_v3 node | per node/month | $140 |
| PostgreSQL D4s vCore | per month | $370 |
| Redis C1 Standard | per month | $55 |
| Redis C2 Standard | per month | $110 |
| Service Bus Standard | per month base | $10 |
| API Management Standard | per month | $700 |
| Static Web Apps Standard | per month | $9 |
| Blob Storage Hot (LRS) | per GB/month | $0.018 |
| Front Door Standard | per month base | $35 |

---

## Cost Tiers by System Size

Use these as sanity checks for total monthly estimates.

| System scale | Concurrent users | Typical monthly range |
|---|---|---|
| Small | < 500 | $200–$800 |
| Medium | 500–2,000 | $800–$3,000 |
| Large | 2,000–10,000 | $3,000–$12,000 |
| Enterprise | > 10,000 | $12,000+ |

---

## Cost Optimization Notes

Include these in the report's Architecture Notes sheet:

- **Reserved Instances**: 1-year saves ~35%, 3-year saves ~55% on compute
- **Spot/Preemptible**: Up to 90% savings for batch/background workloads
- **Auto-scaling**: Container Apps and AKS scale to zero when idle
- **Dev/Test pricing**: ~55% discount on App Service for non-production
- **Azure Hybrid Benefit**: Up to 40% savings if customer has existing Windows Server/SQL licenses
- **Cosmos DB Serverless**: Cheaper than provisioned for < 5M ops/month
- **CDN offloading**: Front Door can reduce origin compute costs by 40–60% for static-heavy apps

---

## Multi-Region Multiplier

If high availability across regions is required:

| HA pattern | Cost multiplier |
|---|---|
| Single region | 1.0× |
| Active-passive (2 regions) | 1.6× |
| Active-active (2 regions) | 2.0× |
| Active-active (3 regions) | 2.8× |
