# Operations Readiness Controls

Best practice reference for the operations-readiness-auditor. Each control has an ID for traceability in findings.

## CI/CD Pipeline (DORA-aligned)

### OPS-CI-01: Pipeline Completeness
CI/CD pipeline should cover the full delivery lifecycle.

**Required stages:**
1. Lint / Static Analysis
2. Unit Tests
3. Integration Tests
4. Build
5. (Optional) E2E Tests
6. Deploy to Staging
7. Deploy to Production

**Check patterns:**
- Look for CI config files: `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`, `.circleci/`
- Verify pipeline includes lint, test, build stages
- Check for automated deployment configuration
- Missing staging/preview environment

**Severity guide:**
- Critical: No CI/CD pipeline at all
- High: Pipeline exists but missing test stage
- Medium: Pipeline missing lint or build stage
- Low: No automated deployment (manual deploy acceptable for some projects)

### OPS-CI-02: Pipeline Security
CI/CD pipeline should follow security best practices.

**Check patterns:**
- Secrets hardcoded in CI config (should use CI secrets/variables)
- Unpinned action versions (e.g., `uses: actions/checkout@main` instead of `@v4`)
- No branch protection rules for main/production branches
- Pipeline allows deployment without approvals
- Pipeline uses `sudo` or elevated permissions unnecessarily

### OPS-CI-03: Build Reproducibility
Builds should be deterministic and reproducible.

**Check patterns:**
- Missing lock files (package-lock.json, yarn.lock, poetry.lock, go.sum)
- Unpinned dependency versions (`"express": "*"` or `">=4.0"`)
- Build depending on external resources that may change
- No Dockerfile or containerization for deployment
- Missing `.nvmrc`/`.python-version`/`.tool-versions` for runtime version pinning

## Dependency Management

### DEP-OUTDATED-01: Outdated Dependencies
Dependencies should be reasonably current.

**Check patterns:**
- Major version behind latest (e.g., React 16 when 18 is current)
- Dependencies with known CVEs (check against advisory databases)
- Dependencies that are deprecated or unmaintained
- Development dependencies in production bundle

**Severity guide:**
- Critical: Dependency with known critical CVE
- High: Major version behind with security implications
- Medium: Several major versions behind
- Low: Minor/patch versions behind

### DEP-LICENSE-01: License Compliance
All dependencies should have compatible licenses.

**Check patterns:**
- Dependencies with copyleft licenses (GPL, AGPL) in proprietary projects
- Dependencies with no declared license
- License incompatibilities between dependencies
- Missing license documentation for the project itself

**Severity guide:**
- High: GPL/AGPL dependency in proprietary/commercial project
- Medium: Dependencies with unclear or missing licenses
- Low: License not explicitly documented in project

### DEP-UNUSED-01: Unused Dependencies
Remove dependencies that are no longer used.

**Check patterns:**
- Packages listed in package.json but never imported
- Requirements listed but never used in Python code
- Transitive dependencies that could be removed
- Development tools included as production dependencies

### DEP-SECURITY-01: Dependency Security
Dependencies should be vetted for security.

**Check patterns:**
- No `npm audit` / `pip audit` / `cargo audit` in CI pipeline
- No automated dependency update tool (Dependabot, Renovate)
- Dependencies downloading code at install time (postinstall scripts)
- Dependencies with very low download counts or single maintainer

## Documentation

### DOC-README-01: README Completeness
Project README should cover essential information.

**Required sections:**
1. Project description and purpose
2. Prerequisites and setup instructions
3. Development workflow (how to run locally)
4. Testing instructions
5. Deployment process
6. Environment variables documentation

**Severity guide:**
- High: No README at all
- Medium: README exists but missing setup or deployment instructions
- Low: README missing minor sections

### DOC-API-01: API Documentation
Public APIs should be documented.

**Check patterns:**
- No OpenAPI/Swagger spec for REST APIs
- No GraphQL schema documentation
- API endpoints without documented request/response shapes
- Missing error response documentation
- No API changelog or versioning documentation

### DOC-ARCHITECTURE-01: Architecture Documentation
System architecture should be documented for onboarding and maintenance.

**Check patterns:**
- No architecture decision records (ADRs)
- No high-level system diagram
- No documentation of data flow
- Missing documentation of external service dependencies
- No explanation of key design decisions

### DOC-CHANGELOG-01: Change Tracking
Changes should be tracked for users and maintainers.

**Check patterns:**
- No CHANGELOG.md or equivalent
- No semantic versioning
- Commit messages with no conventional format
- Release notes missing from releases

## API Design

### API-VERSION-01: API Versioning
APIs should be versioned to allow evolution without breaking clients.

**Check patterns:**
- No version prefix in API routes (`/api/v1/`)
- No versioning strategy documented
- Breaking changes without version bumps
- Multiple incompatible clients consuming unversioned API

### API-ERROR-01: Error Response Consistency
API error responses should follow a consistent format.

**Check patterns:**
- Different error shapes from different endpoints
- Missing HTTP status codes (always returning 200 or 500)
- Error messages exposing internal details (stack traces, database errors)
- No error code system for programmatic handling

**Standard error format:**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable message",
    "details": [...]
  }
}
```

### API-CONTRACT-01: Backward Compatibility
API changes should not break existing clients.

**Check patterns:**
- Required fields added to request bodies without version bump
- Response field types changed (string to number)
- Endpoints removed without deprecation period
- No API contract testing (consumer-driven contracts)

## Deployment Readiness

### DEPLOY-HEALTH-01: Health Checks
Applications should expose health check endpoints.

**Check patterns:**
- No `/health` or `/healthz` endpoint
- No readiness probe distinct from liveness probe
- Health check not verifying downstream dependencies
- No startup probe for slow-starting applications

### DEPLOY-SHUTDOWN-01: Graceful Shutdown
Applications should handle termination signals gracefully.

**Check patterns:**
- No SIGTERM/SIGINT handler
- No connection draining before shutdown
- No cleanup of temporary resources on shutdown
- Immediate process exit without finishing in-flight requests

### DEPLOY-CONFIG-01: Configuration Management
Configuration should be externalized and validated.

**Check patterns:**
- Hardcoded URLs, ports, or feature flags
- Environment variables accessed without validation
- No configuration schema or defaults documentation
- Secrets in configuration files (should use secret managers)
- Different config formats across environments

**Severity guide:**
- High: Hardcoded production URLs or credentials
- Medium: Environment variables without validation/defaults
- Low: Minor configuration inconsistencies

### DEPLOY-ROLLBACK-01: Rollback Strategy
Deployments should be reversible.

**Check patterns:**
- No documented rollback procedure
- Database migrations that can't be reversed
- Deployment process that can't revert to previous version
- No blue-green or canary deployment capability
- No feature flags for gradual rollout

## Twelve-Factor App Alignment

### 12F-CODEBASE-01: Single Codebase
One codebase tracked in version control, many deploys.

### 12F-DEPS-01: Explicit Dependencies
All dependencies explicitly declared and isolated.

### 12F-CONFIG-01: Config in Environment
Store config in environment variables, not in code.

### 12F-BACKING-01: Backing Services as Resources
Treat databases, queues, caches as attached resources.

### 12F-BUILD-01: Build, Release, Run
Strictly separate build and run stages.

### 12F-PROCESSES-01: Stateless Processes
Execute the app as stateless processes; persist state in backing services.

### 12F-PORT-01: Port Binding
Export services via port binding.

### 12F-CONCURRENCY-01: Scale via Processes
Scale out via the process model.

### 12F-DISPOSABILITY-01: Fast Startup, Graceful Shutdown
Maximize robustness with fast startup and graceful shutdown.

### 12F-PARITY-01: Dev/Prod Parity
Keep development, staging, and production as similar as possible.

### 12F-LOGS-01: Logs as Event Streams
Treat logs as event streams; don't manage log files in app.

### 12F-ADMIN-01: Admin Processes
Run admin/management tasks as one-off processes.
