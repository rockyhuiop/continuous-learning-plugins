# Performance & Scalability Controls

Best practice reference for the performance-scalability-auditor. Each control has an ID for traceability in findings.

## Database Performance

### DB-N1-01: N+1 Query Detection
N+1 queries fetch a list then issue individual queries for each item.

**Check patterns by ORM:**
- **Sequelize/TypeORM/Prisma**: Loops calling `.findOne()` or accessing lazy relations inside iterations
- **Django**: Accessing `related_model` in loops without `select_related()`/`prefetch_related()`
- **SQLAlchemy**: Accessing lazy-loaded relationships in loops without `joinedload()`
- **ActiveRecord**: Iterating over collections and accessing associations

**Severity guide:**
- Critical: N+1 in hot paths (listing endpoints, dashboards, batch processing)
- High: N+1 in frequently called API endpoints
- Medium: N+1 in admin or low-traffic endpoints
- Low: N+1 in one-time scripts or migrations

### DB-INDEX-01: Missing Indexes
Columns used in WHERE, JOIN, ORDER BY should be indexed.

**Check patterns:**
- Query patterns in code that filter/sort on non-indexed columns
- Foreign key columns without indexes
- Columns used in `WHERE` clauses of raw SQL queries
- Composite queries that would benefit from multi-column indexes
- Migration files that add columns used in queries but don't add indexes

### DB-UNBOUNDED-01: Unbounded Queries
All list queries should have limits to prevent memory exhaustion.

**Check patterns:**
- `SELECT * FROM table` without `LIMIT`
- ORM `.findAll()` / `.all()` without pagination
- Endpoints returning arrays without pagination parameters
- Streaming endpoints without backpressure

**Severity guide:**
- Critical: Unbounded query on large table in public API
- High: Unbounded query on medium tables in authenticated endpoints
- Medium: Unbounded admin queries
- Low: Unbounded queries on known-small tables

### DB-MIGRATION-01: Migration Safety
Database migrations should be safe for zero-downtime deployments.

**Check patterns:**
- Migrations that lock tables for extended periods (adding columns with defaults in PostgreSQL <11)
- Migrations that rename columns (breaks running code)
- Missing rollback/down migrations
- Data migrations mixed with schema migrations
- Non-idempotent migrations

## Query Optimization

### PERF-QUERY-01: Query Efficiency
Queries should be efficient and avoid common anti-patterns.

**Check patterns:**
- `SELECT *` instead of selecting needed columns
- Multiple queries where a single JOIN would suffice
- Subqueries where JOINs would be more efficient
- Missing query caching for frequently repeated identical queries
- String concatenation in query building (also a security concern)

### PERF-QUERY-02: Connection Pooling
Database connections should be pooled and managed.

**Check patterns:**
- Creating new database connections per request
- No connection pool configuration
- Pool size too small for expected concurrency
- No connection timeout configuration
- Missing connection error handling and reconnection logic

## Memory Management

### MEM-LEAK-01: Memory Leak Patterns
Code should not hold references to objects longer than needed.

**Check patterns:**
- Event listeners added but never removed
- Intervals/timeouts set but never cleared
- Growing Maps/Sets used as caches without eviction
- Closures capturing large objects unnecessarily
- Streams opened but never closed/destroyed

**Severity guide:**
- Critical: Memory leak in long-running server process on hot path
- High: Event listener leak in frequently created components
- Medium: Cache without eviction policy
- Low: Minor closure captures in rarely executed code

### MEM-BUFFER-01: Buffer Management
Large data processing should use streams or chunked processing.

**Check patterns:**
- Reading entire files into memory (`fs.readFileSync` for large files)
- Loading entire database result sets into memory
- String concatenation in loops for large outputs
- No streaming for file uploads/downloads
- Accumulating data in arrays without bounds

## Frontend Performance

### PERF-BUNDLE-01: Bundle Size
Frontend bundles should be optimized for loading performance.

**Check patterns:**
- No code splitting / lazy loading for routes
- Large library imports without tree-shaking (`import _ from 'lodash'` vs `import { map } from 'lodash/map'`)
- Missing bundle analysis in build process
- Images not optimized or lazy-loaded
- No compression (gzip/brotli) configuration

**Severity guide:**
- High: Main bundle >500KB (uncompressed JS)
- Medium: Single library adding >100KB to bundle
- Low: Minor optimization opportunities

### PERF-RENDER-01: Rendering Performance
UI should render efficiently without unnecessary work.

**Check patterns:**
- React: Components re-rendering on every parent render (missing memo/useMemo)
- React: Creating new objects/arrays in render (unstable references)
- React: Missing `key` props or using array index as key for dynamic lists
- Heavy computation in render path without memoization
- Layout thrashing (reading then writing DOM in loops)

### PERF-NETWORK-01: Network Efficiency
API calls should be efficient and well-managed.

**Check patterns:**
- Duplicate API calls for same data (no caching/deduplication)
- Waterfall requests that could be parallelized
- No request cancellation for abandoned navigation
- Missing loading states causing multiple retries
- Over-fetching (requesting all fields when only few needed)

## Caching

### PERF-CACHE-01: Caching Strategy
Frequently accessed, slowly changing data should be cached.

**Check patterns:**
- Repeated identical database queries with no caching layer
- API responses not leveraging HTTP caching headers
- No CDN for static assets
- Session data fetched from database on every request
- Configuration loaded from disk/database on every request

### PERF-CACHE-02: Cache Invalidation
Caches must invalidate correctly to prevent stale data.

**Check patterns:**
- Cache-aside pattern without invalidation on writes
- TTL-only caching for data that changes frequently
- No cache versioning strategy
- Distributed caches without consistent invalidation across instances

## Concurrency

### PERF-ASYNC-01: Async Patterns
Asynchronous operations should be properly managed.

**Check patterns:**
- Sequential awaits where parallel execution is possible (`await a; await b` vs `Promise.all([a, b])`)
- Missing concurrency limits for batch operations
- No backpressure handling for high-throughput streams
- Thread pool exhaustion risks (too many concurrent operations)
- Missing timeouts on async operations

**Severity guide:**
- High: Sequential awaits in hot paths where parallel is possible
- Medium: Missing concurrency limits for batch jobs
- Low: Minor parallelization opportunities

### PERF-ASYNC-02: Resource Cleanup
Async resources should be cleaned up properly.

**Check patterns:**
- Database connections not returned to pool
- File handles not closed after operations
- HTTP connections not terminated
- Temporary files not cleaned up
- Background timers not cancelled on shutdown
