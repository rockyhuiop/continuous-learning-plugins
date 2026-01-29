---
id: 202601271015
title: Circuit Breaker Pattern
created: 2026-01-27
project: canpanion-backend
source: implementation
tags:
  - pattern
  - resilience
  - api
---

## Definition

The Circuit Breaker Pattern prevents cascading failures by wrapping calls to external services with a state machine that trips "open" after repeated failures, failing fast instead of waiting for timeouts.

## Context

Implemented in the AI generation service after DeepSeek API outages caused request pile-ups that exhausted connection pools and crashed the backend. With circuit breaker:
- Requests fail fast (50ms) instead of timing out (60s)
- Backend stays responsive during API outages
- Automatic recovery testing every 30 seconds
- Metrics visibility into external service health

## Example

From `controllers/aigc/shared/resilience.js`:

```javascript
class CircuitBreaker {
  constructor(options = {}) {
    this.failureThreshold = options.failureThreshold || 5
    this.resetTimeout = options.resetTimeout || 30000
    this.state = 'CLOSED'
    this.failures = 0
    this.lastFailure = null
  }

  async execute(fn) {
    if (this.state === 'OPEN') {
      if (Date.now() - this.lastFailure > this.resetTimeout) {
        this.state = 'HALF_OPEN'
      } else {
        throw new CircuitOpenError('Circuit breaker is open')
      }
    }

    try {
      const result = await fn()
      this.onSuccess()
      return result
    } catch (error) {
      this.onFailure()
      throw error
    }
  }

  onSuccess() {
    this.failures = 0
    this.state = 'CLOSED'
  }

  onFailure() {
    this.failures++
    this.lastFailure = Date.now()
    if (this.failures >= this.failureThreshold) {
      this.state = 'OPEN'
    }
  }
}
```

**Usage with AI service**:
```javascript
const aiCircuit = new CircuitBreaker({ failureThreshold: 3, resetTimeout: 30000 })

async function generateContent(prompt) {
  return aiCircuit.execute(() =>
    openai.chat.completions.create({ model: 'deepseek-chat', messages: [...] })
  )
}
```

## Related

- [[Retry with Exponential Backoff]] - Complementary pattern for transient failures
- [[Timeout Pattern]] - Basic building block, circuit breaker adds state
- [[Bulkhead Pattern]] - Isolate resources to prevent cascade
- [[Fallback Pattern]] - What to do when circuit is open

## Questions

- Should circuit state be shared across instances (Redis)?
- How to tune thresholds for different latency SLAs?
- What's the right balance between fast-fail and retry?
