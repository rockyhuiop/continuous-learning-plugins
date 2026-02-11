# Feature Detection Patterns & HyDE Research Methodology

Reference for the audit-orchestrator (feature detection) and best-practice-researcher (HyDE methodology).

## Feature Domain Detection

The orchestrator scans the codebase for domain-specific keywords to identify feature areas that warrant specialized best practice research. Detection uses Grep across source files.

### Detection Matrix

| Feature Domain | Search Patterns (case-insensitive) | Confidence Threshold |
|---|---|---|
| **Payment/Billing** | `stripe`, `paypal`, `braintree`, `payment`, `invoice`, `billing`, `checkout`, `subscription`, `refund`, `charge` | 3+ matches across 2+ files |
| **Authentication** | `auth`, `login`, `signup`, `jwt`, `oauth`, `session`, `token`, `password`, `credentials`, `2fa`, `mfa` | 4+ matches across 3+ files |
| **Search** | `elasticsearch`, `algolia`, `meilisearch`, `typesense`, `full.text.search`, `search.index`, `relevance` | 2+ matches |
| **File Upload/Storage** | `upload`, `multipart`, `s3`, `blob`, `storage`, `file.system`, `presigned`, `cloudinary` | 3+ matches across 2+ files |
| **Real-time** | `websocket`, `socket.io`, `sse`, `server.sent`, `pubsub`, `realtime`, `live.update`, `push.notification` | 2+ matches |
| **Caching** | `redis`, `memcached`, `cache.invalidat`, `ttl`, `cache.aside`, `write.through`, `cdn` | 3+ matches across 2+ files |
| **Queue/Async Processing** | `rabbitmq`, `kafka`, `bull`, `celery`, `sidekiq`, `queue`, `worker`, `job`, `background.task` | 3+ matches across 2+ files |
| **Email/Notifications** | `smtp`, `sendgrid`, `mailgun`, `ses`, `notification`, `email.template`, `push.notification` | 3+ matches across 2+ files |
| **Rate Limiting** | `rate.limit`, `throttl`, `token.bucket`, `sliding.window`, `api.limit` | 2+ matches |
| **Internationalization** | `i18n`, `l10n`, `locale`, `translation`, `intl`, `gettext`, `formatMessage` | 3+ matches across 2+ files |
| **Analytics/Tracking** | `analytics`, `tracking`, `event.track`, `mixpanel`, `amplitude`, `segment`, `gtag` | 3+ matches across 2+ files |
| **Data Export/Import** | `csv`, `excel`, `export`, `import`, `bulk.upload`, `data.migration`, `etl` | 3+ matches across 2+ files |
| **Multi-tenancy** | `tenant`, `organization`, `workspace`, `multi.tenant`, `row.level.security` | 2+ matches |
| **Scheduling/Cron** | `cron`, `schedule`, `recurring`, `periodic`, `agenda`, `node-cron`, `APScheduler` | 2+ matches |
| **API Gateway** | `api.gateway`, `proxy`, `load.balanc`, `reverse.proxy`, `nginx`, `kong`, `envoy` | 2+ matches |

### Detection Process

1. Run Grep searches for each feature domain's patterns
2. Count matches and unique files
3. Features meeting the confidence threshold are flagged for research
4. Report detected features in `stack-profile.md`

## HyDE (Hypothetical Document Embedding) Research Methodology

When the best-practice-researcher agent is dispatched for a detected feature domain, it follows this process:

### Step 1: Hypothesize

Generate a detailed hypothesis of what an ideal production implementation of this feature should include. Base this on training knowledge about established patterns.

**Template for hypothesis generation:**
```
For a production [FEATURE DOMAIN] implementation, the ideal system should include:

1. [Core requirement 1 with brief rationale]
2. [Core requirement 2 with brief rationale]
3. [Core requirement 3 with brief rationale]
...

Common anti-patterns to avoid:
1. [Anti-pattern 1]
2. [Anti-pattern 2]

Key decisions to consider:
1. [Decision point 1]
2. [Decision point 2]
```

### Step 2: Search and Validate

Use WebSearch to find authoritative sources that confirm, expand, or correct the hypothesis.

**Search query templates:**
- `"[feature domain] production best practices [year]"`
- `"[feature domain] engineering checklist"`
- `"[specific technology] [feature domain] implementation guide"`
- `"[feature domain] common mistakes production"`

**Authoritative source priority:**
1. Official documentation (Stripe docs, AWS docs, etc.)
2. Engineering blogs from major companies (Netflix, Stripe, Shopify, Uber)
3. RFCs and technical standards
4. Well-known technical authors (Martin Fowler, etc.)
5. Conference talks from major conferences (QCon, StrangeLoop, etc.)

**Filter out:**
- Tutorial sites without production context
- Stack Overflow answers without authoritative backing
- Blog posts from unknown sources without citations
- Outdated content (>3 years old for fast-moving areas)

### Step 3: Synthesize

Cross-reference the hypothesis with search results to produce a validated checklist.

**Synthesis format:**
```markdown
## [Feature Domain] Production Best Practices

### Validated Requirements
1. [Requirement] — Source: [Authoritative citation]
2. [Requirement] — Source: [Authoritative citation]

### Additional Requirements (from research)
1. [Requirement not in hypothesis] — Source: [Citation]

### Removed from Hypothesis
1. [Requirement] — Reason: [Why it was removed/modified]

### Decision Points
1. [Decision] — Recommended: [Option] because [Rationale]
```

### Step 4: Audit

Compare actual codebase against the validated checklist. Produce findings with the `FP-###` prefix.

**Finding format for researched best practices:**
```markdown
## Finding: FP-[SEQ]

**Severity:** [Critical|High|Medium|Low]
**Domain:** [Feature Domain]
**Best Practice Reference:** [Source citation with URL]
**Status:** Open

### Description
[What was found and why it falls short of industry best practice]

### Evidence
- File: `[path:line]`
- Current implementation: [Brief description]
- Expected practice: [What authoritative source recommends]

### Recommendation
[Specific remediation based on authoritative source]

### Source
[URL or reference to the authoritative source]

### Remediation
[Pending]

---
```

## Example: Payment Processing Feature

### Hypothesis
```
For a production payment processing implementation, the ideal system should include:
1. Idempotency keys on all payment mutation endpoints
2. Webhook signature verification for payment provider callbacks
3. Decimal precision handling (avoid floating point for money)
4. Retry logic with exponential backoff for payment API calls
5. Audit trail for all financial transactions
6. PCI DSS compliance (never store raw card data)
7. Proper error handling with user-friendly payment failure messages
8. Currency handling with proper formatting
```

### Search Queries
- `"payment processing production best practices 2025"`
- `"Stripe integration production checklist"`
- `"idempotent payment endpoints"`
- `"PCI DSS developer requirements software"`

### Synthesized Checklist (abbreviated)
1. Idempotency keys — Source: Stripe API docs
2. Webhook signature verification — Source: Stripe webhook docs
3. Use integer cents, not float dollars — Source: Martin Fowler "Money" pattern
4. Test mode vs live mode separation — Source: Stripe testing docs
5. Handle all possible payment states — Source: Stripe payment intents lifecycle
6. Log transaction IDs, never card details — Source: PCI DSS requirement 3

### Findings Generated
- FP-001: Payment endpoint `/api/charges` lacks idempotency key support
- FP-002: Webhook handler does not verify Stripe signature
- FP-003: Using `parseFloat()` for monetary calculations
