# Page Tree Examples

Example Confluence page hierarchies for different project types. Adapt these to fit the specific codebase being documented.

## Example 1: Full-Stack Web Application

```
Project Documentation
├── 1. System Overview
│   ├── Architecture & Tech Stack
│   ├── Getting Started (Dev Setup)
│   └── Deployment Guide
├── 2. Backend API
│   ├── Authentication & Authorization
│   ├── User Management Endpoints
│   ├── Order Processing Endpoints
│   └── Webhook Integrations
├── 3. Frontend
│   ├── Component Library
│   ├── State Management
│   └── Routing & Navigation
├── 4. Database
│   ├── Schema Reference
│   ├── Migration Guide
│   └── Query Patterns
├── 5. Infrastructure
│   ├── CI/CD Pipeline
│   ├── Monitoring & Alerting
│   └── Environment Configuration
└── 6. Appendix
    ├── Feature Flags Reference
    ├── Error Code Reference
    └── Glossary
```

## Example 2: AI/ML Pipeline Application

```
Project Documentation
├── 1. System Overview
│   ├── Architecture & Data Flow
│   ├── Model Registry
│   └── Getting Started
├── 2. Data Pipeline
│   ├── Ingestion & ETL
│   ├── Feature Engineering
│   └── Data Validation
├── 3. RAG / Retrieval
│   ├── Vector Store & Indexing
│   ├── Query Transformation
│   ├── Hybrid Search Pipeline
│   └── Reranking & Filtering
├── 4. LLM Integration
│   ├── Prompt Engineering
│   ├── Model Selection & Routing
│   ├── Streaming & Generation
│   └── Safety & Guardrails
├── 5. Voice / Real-Time
│   ├── ASR Integration
│   ├── TTS Integration
│   ├── WebSocket Protocol
│   └── Latency Optimization
├── 6. REST API
│   ├── Endpoint Reference
│   ├── Authentication
│   └── Rate Limiting
├── 7. Operations
│   ├── Monitoring & Tracing
│   ├── Feature Flags
│   └── Incident Response
└── 8. Appendix
    ├── Configuration Reference
    ├── Scenario Taxonomy
    └── Glossary
```

## Example 3: Microservices Platform

```
Platform Documentation
├── 1. Platform Overview
│   ├── Service Map
│   ├── Communication Patterns
│   └── Shared Libraries
├── 2. Service: User Service
│   ├── API Reference
│   ├── Data Model
│   └── Configuration
├── 3. Service: Order Service
│   ├── API Reference
│   ├── Saga Patterns
│   └── Event Schemas
├── 4. Service: Payment Service
│   ├── Provider Integration
│   ├── Webhook Handling
│   └── PCI Compliance
├── 5. Infrastructure
│   ├── Kubernetes Setup
│   ├── Service Mesh
│   └── Observability Stack
└── 6. Operations
    ├── Runbooks
    ├── Deployment Procedures
    └── Disaster Recovery
```

## Design Principles

### Grouping Heuristics

| Project Pattern | Group By |
|-----------------|----------|
| Monolith | Functional domain (Auth, Users, Orders) |
| Microservices | Service boundary |
| AI/ML | Pipeline stage (Ingestion → Processing → Serving) |
| Frontend | Feature area or route |
| API-only | Resource type or version |

### Page Count Guidelines

| Project Size | Sections | Pages per Section | Total Pages |
|-------------|----------|-------------------|-------------|
| Small (<10k LOC) | 3-4 | 2-3 | 8-12 |
| Medium (10-50k LOC) | 5-7 | 3-5 | 15-25 |
| Large (50k+ LOC) | 7-10 | 3-7 | 25-50 |

### Section Ordering

1. **System Overview** — always first (orientation)
2. **Core features** — the main value of the system
3. **Supporting features** — infrastructure, utilities
4. **Operations** — deployment, monitoring
5. **Appendix** — reference tables, glossary — always last

### Page Depth

- **Maximum 3 levels deep** (Parent → Section → Feature Page)
- If a feature page exceeds 3,000 words, split into sub-pages
- Prefer flat over deep — easier to navigate
