# Azure SKU Reference

All SKUs use East US region as default. Adjust for other regions (~5–15% variance).

---

## Azure Container Apps

Sizing basis: vCPU + memory per replica, replica count driven by RPS.

| Workload RPS | vCPU/replica | Memory/replica | Min replicas | Recommended replicas |
|---|---|---|---|---|
| < 100 | 0.5 | 1 Gi | 1 | 2 |
| 100–500 | 1.0 | 2 Gi | 2 | 3 |
| 500–2,000 | 2.0 | 4 Gi | 3 | 5 |
| 2,000–5,000 | 4.0 | 8 Gi | 5 | 8 |
| > 5,000 | 4.0 | 8 Gi | 8 | scale horizontally |

Pricing: $0.000024/vCPU-second, $0.000003/GiB-second (Consumption plan)

---

## Azure App Service

| Plan | vCPU | RAM | Monthly (USD) | Use case |
|---|---|---|---|---|
| B1 | 1 | 1.75 GB | $13 | Dev/test |
| B2 | 2 | 3.5 GB | $26 | Low traffic |
| B3 | 4 | 7 GB | $52 | Medium traffic |
| P1v3 | 2 | 8 GB | $81 | Production |
| P2v3 | 4 | 16 GB | $162 | High traffic |
| P3v3 | 8 | 32 GB | $324 | Very high traffic |

---

## Azure Kubernetes Service (AKS)

Node pool sizing — choose node SKU then set count.

| Node SKU | vCPU | RAM | Monthly/node |
|---|---|---|---|
| Standard_D2s_v3 | 2 | 8 GB | $70 |
| Standard_D4s_v3 | 4 | 16 GB | $140 |
| Standard_D8s_v3 | 8 | 32 GB | $280 |
| Standard_D16s_v3 | 16 | 64 GB | $560 |

**Node count formula:**
```
nodes = ceil((total_vCPU_needed × 1.3) / node_vCPU)  # 1.3 = 30% headroom
```

---

## Azure Database for PostgreSQL Flexible Server

| Tier | vCores | RAM | IOPS | Monthly (USD) |
|---|---|---|---|---|
| Burstable B1ms | 1 | 2 GB | 640 | $25 |
| Burstable B2s | 2 | 4 GB | 1,280 | $50 |
| General Purpose D2s | 2 | 8 GB | 3,200 | $185 |
| General Purpose D4s | 4 | 16 GB | 6,400 | $370 |
| General Purpose D8s | 8 | 32 GB | 12,800 | $740 |
| Memory Optimized E4s | 4 | 32 GB | 6,400 | $460 |
| Memory Optimized E8s | 8 | 64 GB | 12,800 | $920 |

**QPS → vCore mapping:**
- < 500 QPS: Burstable B2s
- 500–2,000 QPS: General Purpose D4s
- 2,000–5,000 QPS: General Purpose D8s
- > 5,000 QPS: Memory Optimized E8s + read replicas

Storage: $0.115/GB/month. Add 20% for WAL/temp.

---

## Azure SQL Database

| Tier | DTUs / vCores | Monthly (USD) | Max QPS (approx) |
|---|---|---|---|
| Basic | 5 DTU | $5 | ~50 |
| Standard S2 | 50 DTU | $75 | ~500 |
| Standard S4 | 200 DTU | $300 | ~2,000 |
| General Purpose 4 vCore | 4 vCore | $370 | ~3,000 |
| General Purpose 8 vCore | 8 vCore | $740 | ~6,000 |
| Business Critical 4 vCore | 4 vCore | $1,120 | ~5,000 (HA) |

---

## Azure Cosmos DB

Pricing basis: Request Units per second (RU/s).

**RU estimation:**
- Point read (1 KB): 1 RU
- Write (1 KB): 5 RU
- Query (cross-partition): 10–100 RU

| RU/s | Monthly (Provisioned) | Monthly (Serverless equiv.) |
|---|---|---|
| 400 | $23 | ~$5 (low traffic) |
| 1,000 | $58 | — |
| 5,000 | $292 | — |
| 10,000 | $584 | — |
| 50,000 | $2,920 | — |

Use Serverless for < 5M ops/month; Provisioned for predictable high load.

---

## Azure Cache for Redis

| Tier | Memory | Max connections | Monthly (USD) |
|---|---|---|---|
| C0 Basic | 250 MB | 256 | $16 |
| C1 Standard | 1 GB | 1,000 | $55 |
| C2 Standard | 6 GB | 2,000 | $110 |
| C3 Standard | 13 GB | 5,000 | $220 |
| P1 Premium | 6 GB | 7,500 | $330 |
| P2 Premium | 13 GB | 7,500 | $660 |

**Ops/s → tier mapping:**
- < 10,000 ops/s: C1 Standard
- 10,000–50,000 ops/s: C2 Standard
- 50,000–100,000 ops/s: C3 Standard
- > 100,000 ops/s: P1 Premium

---

## Azure Service Bus

| Tier | Throughput | Monthly base | Per million ops |
|---|---|---|---|
| Basic | 256 KB msg | $0.10 | $0.05 |
| Standard | 256 KB msg | $10 | $0.05 |
| Premium 1 MU | 1 MB msg | $677 | Included |

Use Standard for < 10M msgs/month; Premium for high throughput or large messages.

---

## Azure Event Hubs

| Tier | Throughput Units | Ingress | Monthly |
|---|---|---|---|
| Basic 1 TU | 1 MB/s in, 2 MB/s out | 1M events | $22 |
| Standard 1 TU | 1 MB/s in, 2 MB/s out | 1M events | $22 |
| Standard 10 TU | 10 MB/s in | 10M events | $220 |
| Premium 1 PU | 1 MB/s in | Unlimited | $731 |

---

## Azure API Management

| Tier | Monthly (USD) | RPS limit | Notes |
|---|---|---|---|
| Consumption | $3.50/1M calls | Unlimited | Pay-per-call |
| Developer | $50 | 500 | Dev/test only |
| Basic | $140 | 1,000 | Small production |
| Standard | $700 | 2,500 | Production |
| Premium | $2,800 | 4,000+ | Multi-region |

---

## Azure Static Web Apps

| Tier | Monthly | Bandwidth | Notes |
|---|---|---|---|
| Free | $0 | 100 GB | Personal projects |
| Standard | $9 | 100 GB | Production |

---

## Azure Blob Storage

| Tier | Storage | Operations | Monthly estimate |
|---|---|---|---|
| Hot LRS | $0.018/GB | $0.004/10K ops | Frequently accessed |
| Cool LRS | $0.01/GB | $0.01/10K ops | Infrequent access |
| Archive | $0.00099/GB | $0.0025/10K ops | Backup/archive |

---

## Azure Front Door (CDN)

| Tier | Monthly base | Data transfer | Notes |
|---|---|---|---|
| Standard | $35 | $0.087/GB (first 10 TB) | Global CDN |
| Premium | $330 | $0.087/GB | WAF + advanced routing |
