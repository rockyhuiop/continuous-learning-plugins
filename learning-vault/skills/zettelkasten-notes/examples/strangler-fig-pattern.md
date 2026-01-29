---
title: Strangler Fig Pattern
created: 2026-01-28
project: canpanion-backend
source: implementation
tags:
  - pattern
  - architecture
  - migration
---

## Definition

The Strangler Fig Pattern incrementally replaces legacy system components by routing traffic through a facade that gradually shifts from old to new implementations, enabling migration without downtime.

## Context

Applied during the modular monolith migration of canpanion-backend. The legacy User service was tightly coupled to the main application, making a big-bang rewrite risky. Using Strangler Fig, we could:
- Migrate one endpoint at a time
- Roll back individual endpoints if issues arose
- Maintain continuous service during 3-sprint migration
- Validate new implementation with real traffic gradually

## Example

Created a facade in `services/userFacade.js` that routes between legacy and new implementations:

```javascript
class UserFacade {
  constructor(legacyService, newService, featureFlags) {
    this.legacy = legacyService
    this.new = newService
    this.flags = featureFlags
  }

  async getUser(id) {
    // Traffic split controlled by feature flag
    if (await this.flags.isEnabled('new-user-service', id)) {
      return this.new.get(id)
    }
    return this.legacy.get(id)
  }

  async updateUser(id, data) {
    // Write to both during transition for data consistency
    if (await this.flags.isEnabled('new-user-service-writes', id)) {
      const result = await this.new.update(id, data)
      // Shadow write to legacy for rollback safety
      await this.legacy.update(id, data).catch(e =>
        logger.warn('Legacy shadow write failed', { id, error: e })
      )
      return result
    }
    return this.legacy.update(id, data)
  }
}
```

**Key insight**: Using user ID as the feature flag key allowed gradual rollout by user cohort, starting with internal users, then beta users, then general population.

## Related

- [[Feature Flags]] - Control mechanism for traffic routing
- [[Legacy Migration Strategies]] - Broader category of migration approaches
- [[Branch by Abstraction]] - Alternative pattern using abstraction layer
- [[Facade Pattern]] - Underlying GoF pattern used here
- [[Modular Monolith]] - Target architecture we were migrating toward

## Questions

- How to handle database schema differences between legacy and new?
- What metrics should trigger automatic rollback?
- How long to maintain dual-write before cutting over completely?
