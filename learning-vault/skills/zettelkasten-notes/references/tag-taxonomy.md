# Tag Taxonomy Reference

## Architecture Tags

| Tag | Use For | Examples |
|-----|---------|----------|
| `pattern` | Named design/architecture patterns | Strangler Fig, Circuit Breaker, Saga |
| `architecture` | System design concepts | Microservices, Event-Driven, Hexagonal |
| `migration` | Moving between systems/versions | Database migration, API versioning |
| `refactoring` | Code improvement techniques | Extract method, Replace conditional with polymorphism |
| `design` | Software design principles | SOLID, DRY, Separation of Concerns |
| `infrastructure` | DevOps/platform concepts | Kubernetes, CI/CD, Load balancing |
| `api` | API design and integration | REST, GraphQL, gRPC, Webhooks |
| `database` | Data storage patterns | Indexing, Transactions, Sharding |

## Learning Tags

| Tag | Use For | Examples |
|-----|---------|----------|
| `concept` | Abstract technical concepts | Eventual consistency, Idempotency |
| `terminology` | Technical vocabulary | Backpressure, Throttling, Debouncing |
| `technique` | Specific implementation approaches | Memoization, Lazy loading, Pagination |
| `lesson-learned` | Insights from experience | "Why our caching strategy failed" |
| `best-practice` | Recommended approaches | Error handling, Logging, Testing |
| `gotcha` | Common pitfalls or surprises | Race conditions, Memory leaks |
| `tool` | Software tools or libraries | Redis, Temporal, LangChain |

## Tag Combinations

### Common Patterns

- **Architecture Pattern**: `pattern` + `architecture` + domain tag
  - Example: Strangler Fig → `pattern`, `architecture`, `migration`

- **Resilience Pattern**: `pattern` + `resilience` or `api`
  - Example: Circuit Breaker → `pattern`, `resilience`, `api`

- **Database Technique**: `technique` + `database`
  - Example: Optimistic Locking → `technique`, `database`

- **Tool Learning**: `tool` + relevant domain
  - Example: Redis Caching → `tool`, `infrastructure`, `technique`

### Tag Count Guidelines

- Minimum: 2 tags (one category + one domain)
- Typical: 3-4 tags
- Maximum: 5 tags (more suggests note is too broad)

## Searching by Tags

In Obsidian, search tags with:
- `tag:#pattern` - All patterns
- `tag:#pattern tag:#migration` - Migration patterns
- `tag:#lesson-learned` - All lessons learned

Or use the tag pane for visual browsing.
