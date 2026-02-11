# Scenario Design Rubric

Detailed guidelines for generating novel, effective challenge scenarios that test concept application.

## Domain Pool

Select from these 10 domains. Each includes enough context to generate realistic problems for most software engineering concepts:

| Domain | Typical Systems | Good For Testing |
|--------|----------------|------------------|
| **IoT** | Sensor networks, edge computing, device management | Scalability, data pipelines, reliability |
| **Healthcare** | Patient records, telemedicine, medical devices | Data integrity, compliance, fault tolerance |
| **Fintech** | Payment processing, trading platforms, banking APIs | Consistency, security, latency |
| **E-commerce** | Product catalogs, checkout flows, inventory | Caching, eventual consistency, search |
| **Social media** | Feed algorithms, messaging, content moderation | High throughput, fan-out, real-time |
| **Gaming** | Multiplayer servers, leaderboards, matchmaking | Low latency, state sync, concurrency |
| **Logistics** | Fleet tracking, route optimization, warehousing | Distributed systems, event sourcing, geo |
| **Education** | LMS platforms, assessment engines, content delivery | Multi-tenancy, personalization, offline |
| **Media streaming** | Video encoding, CDN, recommendation engines | Throughput, buffering, adaptive quality |
| **Manufacturing** | Production lines, quality control, supply chain | Process orchestration, monitoring, batch |

## Domain Selection Rules

1. **Never use the same domain as the vault note's example.** If the note about Circuit Breaker uses a food delivery example, do not generate a food delivery scenario.
2. **Never repeat a domain used in past challenges for the same concept.** Check challenge history in `Challenges/{concept-name}.md`.
3. **If all 10 domains have been used** for a concept (rare), reset and allow reuse but with a completely different problem setup.
4. **Match domain to concept applicability.** Some concepts fit certain domains more naturally. Prefer domains where the concept solves a real problem, not a forced one.

## Scenario Structure Template

Every scenario follows this four-part structure:

### 1. Context (2-3 sentences)

Set up the situation. Introduce the system, its purpose, and current state. Be specific enough for the user to reason about.

**Good**: "A fintech startup processes 50,000 payment transactions per hour through a microservices architecture. Their payment-gateway service calls three downstream services: fraud-detection, currency-conversion, and ledger-posting. During peak hours, the fraud-detection service occasionally becomes unresponsive for 30-60 seconds."

**Bad**: "Imagine a system with some services that sometimes fail." (Too vague -- no reasoning possible.)

### 2. Problem Statement (1-2 sentences)

Describe what needs to be solved. Make the problem concrete and observable.

**Good**: "When fraud-detection becomes unresponsive, payment requests queue up, causing the gateway's thread pool to exhaust within 15 seconds. This cascades to currency-conversion and ledger-posting, bringing down the entire payment flow even though those services are healthy."

**Bad**: "The system has reliability issues." (Not specific enough to apply a concept.)

### 3. Constraint or Complication (1 sentence)

Add a realistic constraint that prevents the obvious or trivial solution. This forces deeper thinking.

**Good**: "The team cannot modify the fraud-detection service directly, as it's maintained by a separate vendor with a 6-month change request cycle."

**Bad**: "Also, the system needs to be fast." (Too generic, doesn't constrain the solution space.)

### 4. Question Prompt

The question varies by difficulty level (see below).

## Difficulty Levels

### Basic (Default)

Name the concept explicitly. Test whether the user can apply it correctly.

**Question format**: "How would you apply [concept name] to address this problem? Describe your approach, including specific implementation details for this scenario."

**What it tests**: Can the user move from concept definition to concrete application in a new domain?

**Example**: "How would you apply the Circuit Breaker pattern to address the cascading failure in this payment system? Describe your approach, including what triggers the breaker, what happens in the open state, and how the system recovers."

### Intermediate

Don't name the concept. Test whether the user can recognize which concept applies.

**Question format**: "How would you redesign this part of the system to solve the problem? Explain your reasoning and the trade-offs of your approach."

**What it tests**: Can the user recognize a problem pattern and select the right concept without being told?

**Example**: "How would you redesign the gateway's interaction with downstream services to prevent this cascading failure? Explain your reasoning and the trade-offs of your approach."

### Advanced

Present a scenario where 2-3 concepts from the user's vault are relevant. Test whether the user can identify and combine them.

**Question format**: "What architectural changes would you recommend to address this problem comprehensively? Consider multiple patterns and explain how they work together."

**What it tests**: Can the user compose multiple concepts into a coherent solution?

**Setup**: Read 2-3 related vault notes (via `[[...]]` links in the primary note). Design a scenario that requires combining them. For example, a scenario that needs both Circuit Breaker AND Bulkhead patterns.

## Novelty Rules

### What Makes a Scenario "Novel"

A scenario is novel when:
- The domain is different from the vault note's example
- The specific system described is not a variation of the vault example
- The constraint forces thinking beyond the textbook application
- The user cannot answer by simply copying the vault note's example into a different name

### Domain Novelty

If the vault note uses an "e-commerce checkout" example, these are NOT novel:
- "An online store's payment system..." (same domain)
- "A marketplace checkout flow..." (same domain, minor variation)

These ARE novel:
- "A hospital patient admission system..." (different domain entirely)
- "A multiplayer game's matchmaking service..." (different domain entirely)

### Problem Novelty

Even within a new domain, avoid problems that are trivially similar to the vault example. If the vault shows Circuit Breaker protecting a REST API call, don't generate a scenario that's also about protecting a REST API call in a different domain. Instead, use a different manifestation: database connection pools, message queue consumers, file system operations, etc.

## Anti-Patterns

Avoid generating scenarios that have these problems:

### Too Abstract

**Bad**: "Consider a distributed system where Service A depends on Service B. Service B sometimes fails. How would you handle this?"

**Why bad**: No specifics to reason about. The answer is the textbook definition with no application.

### Too Trivial

**Bad**: "A web app calls an external API. Sometimes the API is slow. What would you do?"

**Why bad**: The answer is obvious and doesn't test understanding of trade-offs, failure modes, or implementation details.

### Concept Not Actually Needed

**Bad**: Describing a scenario where the concept doesn't naturally apply, just to test if the user knows it.

**Why bad**: Forces a solution that doesn't fit. Real understanding includes knowing when a concept DOESN'T apply.

### Too Many Moving Parts

**Bad**: A 10-paragraph scenario with 8 services, 4 databases, and 3 external APIs.

**Why bad**: Cognitive overload obscures the concept being tested. The user spends more time parsing the scenario than thinking about the concept.

### Leading Scenario

**Bad**: Using vocabulary from the concept's definition in the scenario description. E.g., describing something as "breaking the circuit" when testing Circuit Breaker.

**Why bad**: Gives away the answer. The scenario should describe symptoms, not solutions.

## Scenario Quality Checklist

Before presenting a scenario, verify:

- [ ] Domain differs from vault note example
- [ ] Domain not used in past challenges for this concept
- [ ] Context provides enough specifics to reason about (numbers, service names, behaviors)
- [ ] Problem is concrete and observable (not "reliability issues")
- [ ] Constraint prevents the trivial solution
- [ ] Concept genuinely applies (not forced)
- [ ] No concept vocabulary leaked into the scenario description
- [ ] Scenario is self-contained (user doesn't need external knowledge of the domain)
- [ ] Length is appropriate (context + problem + constraint fits in one screen)
