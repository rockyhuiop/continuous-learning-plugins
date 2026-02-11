# Testing & Reliability Controls

Best practice reference for the testing-reliability-auditor. Each control has an ID for traceability in findings.

## Testing Pyramid

### TEST-PYRAMID-01: Test Distribution
Follow the testing pyramid: many unit tests, fewer integration tests, minimal E2E tests.

**Healthy ratios:**
- Unit tests: 70-80% of total test count
- Integration tests: 15-25%
- E2E tests: 5-10%

**Detection patterns:**
- Count test files by type/location
- Check for projects with only E2E tests (inverted pyramid)
- Projects with only unit tests but no integration tests (missing middle)

### TEST-COVERAGE-01: Test File Coverage
Every source file with business logic should have a corresponding test file.

**Check patterns:**
- For each source file in `src/`, check for corresponding test file
- Common test file patterns: `*.test.ts`, `*.spec.ts`, `*_test.py`, `*_test.go`, `Test*.java`
- Test directories: `__tests__/`, `tests/`, `test/`, `spec/`

**Severity guide:**
- Critical: Core business logic (payments, auth, data processing) with zero tests
- High: Important services with less than 30% file coverage
- Medium: Supporting modules with no tests
- Low: Utility code or configuration with no tests

### TEST-COVERAGE-02: Branch Coverage
Critical paths should have branch coverage testing.

**Check patterns:**
- Look for error handling paths that are never tested
- Conditional logic with only happy-path tests
- Edge cases: empty arrays, null inputs, boundary values, concurrent access

## Test Quality (FIRST Principles)

### TEST-FIRST-F: Fast
Tests should execute quickly.

**Check patterns:**
- Tests with `setTimeout`/`sleep` calls (flaky timing)
- Tests making real network calls without mocking
- Tests depending on database state without proper setup/teardown
- Test suites taking >30 seconds to run

### TEST-FIRST-I: Independent
Tests should not depend on execution order.

**Check patterns:**
- Shared mutable state between tests
- Tests that fail when run in isolation but pass in suite
- Global setup that multiple tests rely on modifying
- Test files modifying global/module-level state

### TEST-FIRST-R: Repeatable
Tests should produce the same result every time.

**Check patterns:**
- Tests depending on current date/time without mocking
- Tests depending on random values without seeding
- Tests depending on external services without mocking
- File system dependencies without cleanup

### TEST-FIRST-S: Self-Validating
Tests should have clear pass/fail assertions.

**Check patterns:**
- Tests with no assertions (just calling code)
- Tests using only `console.log` for verification
- Tests with overly broad assertions (`toBeTruthy()` instead of specific values)
- Snapshot tests as the only testing strategy for logic

**Severity guide:**
- High: Test suite exists but has no meaningful assertions
- Medium: Tests with weak assertions (truthy/falsy only)
- Low: Tests that could have more specific assertions

### TEST-FIRST-T: Timely
Tests should be written alongside or before the code.

**Check patterns:**
- Large source files added with no corresponding test files in same commit
- Test files significantly newer than source files they test

## Error Handling

### ERR-BOUNDARY-01: Error Boundaries
Errors should be caught at appropriate boundaries.

**Check patterns:**
- Unhandled promise rejections (missing `.catch()` or try/catch on await)
- React components without error boundaries
- Express/Koa routes without error middleware
- Background jobs without error handling

**Severity guide:**
- Critical: Unhandled errors in payment/auth/data-mutation flows
- High: API endpoints without error handling
- Medium: Background processes without error recovery
- Low: Non-critical utilities without error handling

### ERR-PROPAGATION-01: Error Propagation
Errors should propagate meaningful context up the call stack.

**Check patterns:**
- Catch-and-ignore blocks (`catch (e) {}`)
- Catch blocks that only log and re-throw without wrapping
- Error messages that don't include context (just "Error occurred")
- Swallowed errors in callbacks

**Severity guide:**
- Critical: Silently swallowed errors in data mutation paths
- High: Catch-and-ignore in business logic
- Medium: Generic error messages without context
- Low: Minor error context missing in non-critical paths

### ERR-TYPING-01: Error Types
Use typed/structured errors rather than generic ones.

**Check patterns:**
- Throwing raw strings (`throw "error"`)
- Only using generic `Error` class for all error types
- No error classification (user error vs system error vs validation error)
- Inconsistent error shapes across the codebase

### ERR-RECOVERY-01: Graceful Degradation
Systems should degrade gracefully rather than crash completely.

**Check patterns:**
- No fallback for external service failures
- No circuit breaker patterns for unreliable dependencies
- No timeout configurations for network calls
- Missing retry logic for transient failures
- No graceful shutdown handling (SIGTERM/SIGINT)

## Logging

### LOG-STRUCTURE-01: Structured Logging
Use structured (JSON) logging rather than unstructured text.

**Check patterns:**
- `console.log()` with string concatenation in production code
- `print()` statements instead of proper logging framework
- Missing request/correlation IDs in log entries
- Inconsistent log formats across services

### LOG-LEVELS-01: Log Levels
Use appropriate log levels (debug, info, warn, error).

**Check patterns:**
- All logs at the same level (everything is `console.log`)
- Error conditions logged at info level
- Debug-level verbosity in production configuration
- No way to change log levels without code changes

### LOG-SENSITIVE-01: Sensitive Data in Logs
Never log passwords, tokens, or PII.

**Check patterns:**
- Logging request bodies that may contain passwords
- Logging full user objects with email/phone
- Logging authentication tokens or API keys
- Logging credit card or financial data

**Severity guide:**
- Critical: Logging passwords, tokens, or financial data
- High: Logging PII (emails, phone numbers, addresses)
- Medium: Logging full request/response bodies without filtering
- Low: Excessive debug logging in production config

## Monitoring Readiness

### MON-HEALTH-01: Health Check Endpoints
Production services should expose health check endpoints.

**Check patterns:**
- No `/health` or `/healthz` endpoint
- Health endpoint that doesn't check downstream dependencies
- No liveness vs readiness distinction in Kubernetes deployments

### MON-METRICS-01: Application Metrics
Key business and technical metrics should be instrumented.

**Check patterns:**
- No request duration tracking
- No error rate metrics
- No business metric instrumentation (orders, signups, etc.)
- No memory/CPU instrumentation hooks

### MON-ALERTING-01: Alerting Configuration
Critical conditions should trigger alerts.

**Check patterns:**
- No alerting configuration files
- No on-call documentation
- Missing runbooks for known failure scenarios
- No SLO/SLA definitions

**Severity guide:**
- High: No health endpoints in a production service
- Medium: Health endpoints that don't check dependencies
- Medium: No metrics instrumentation
- Low: Missing alerting config (may be managed externally)
