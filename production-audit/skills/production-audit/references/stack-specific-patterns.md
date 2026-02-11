# Stack-Specific Best Practice Patterns

Additional checks layered on top of universal controls when the orchestrator detects a specific technology stack.

## Stack Detection

Detect the primary stack by scanning for indicator files at the project root.

| Indicator File(s) | Stack | Language |
|---|---|---|
| `package.json` + `tsconfig.json` | TypeScript/Node.js | TypeScript |
| `package.json` (no tsconfig) | JavaScript/Node.js | JavaScript |
| `pyproject.toml` or `requirements.txt` or `setup.py` | Python | Python |
| `go.mod` | Go | Go |
| `Cargo.toml` | Rust | Rust |
| `pom.xml` or `build.gradle` or `build.gradle.kts` | Java/Kotlin (JVM) | Java/Kotlin |
| `*.csproj` or `*.sln` | .NET | C# |
| `Gemfile` | Ruby | Ruby |
| `mix.exs` | Elixir | Elixir |

### Framework Detection (secondary scan)

| Indicator | Framework |
|---|---|
| `next.config.*` | Next.js |
| `vite.config.*` | Vite |
| `angular.json` | Angular |
| `nuxt.config.*` | Nuxt.js |
| `svelte.config.*` | SvelteKit |
| Django in requirements | Django |
| FastAPI in requirements | FastAPI |
| Flask in requirements | Flask |
| `gin` or `echo` or `fiber` in go.mod | Go web frameworks |
| Spring in pom.xml | Spring Boot |

## TypeScript / Node.js Checks

### TS-STRICT-01: Strict Mode
`tsconfig.json` should enable strict mode for type safety.

**Check:** `"strict": true` in tsconfig.json
**Severity:** High if disabled, Medium if partially enabled

### TS-ANY-01: Any Type Usage
Minimize `any` type usage as it defeats type safety.

**Check:** Grep for `: any`, `as any`, `<any>`
**Thresholds:**
- Acceptable: <5 instances
- Concerning: 5-20 (Medium)
- High risk: 20+ (High)

### TS-NULL-01: Null Safety
Handle null/undefined values explicitly.

**Check:** Look for optional chaining (`?.`) usage, nullish coalescing (`??`), and strict null checks
**Anti-patterns:** Non-null assertions (`!`) used excessively instead of proper null handling

### NODE-VERSION-01: Node.js Version
Pin Node.js version for reproducible builds.

**Check:** Look for `.nvmrc`, `.node-version`, `engines` field in package.json
**Severity:** Medium if missing

### NODE-ESM-01: Module System
Use consistent module system (ESM preferred for new projects).

**Check:** `"type": "module"` in package.json, or consistent use of `require()` vs `import`
**Anti-pattern:** Mixing CJS and ESM without clear boundaries

## React-Specific Checks

### REACT-HOOKS-01: Hook Rules
Follow React hook rules for correctness.

**Check patterns:**
- Hooks called conditionally
- Missing dependency arrays in useEffect/useMemo/useCallback
- Over-specified dependency arrays causing infinite loops
- Custom hooks not prefixed with `use`

### REACT-KEY-01: List Keys
Dynamic lists must use stable, unique keys.

**Check:** `key={index}` usage (anti-pattern for dynamic lists)
**Severity:** Medium for most cases, High for lists with reordering/deletion

### REACT-MEMO-01: Memoization
Expensive computations and callbacks should be memoized appropriately.

**Anti-patterns:**
- Creating new functions/objects in render on every cycle
- Missing `useMemo` for expensive computed values
- Missing `useCallback` for functions passed as props to memoized children
**Note:** Over-memoization is also an anti-pattern. Only flag obvious cases.

### REACT-EFFECT-01: Effect Cleanup
Side effects should clean up resources.

**Check:** `useEffect` with subscriptions, timers, or event listeners but no cleanup return

### REACT-STATE-01: State Management
State should be at the appropriate level and not duplicated.

**Check patterns:**
- Props drilling through 4+ component levels (needs context or state management)
- Duplicated state (same data stored in multiple places)
- Derived state stored when it could be computed
- Global state holding server data (use React Query/SWR instead)

## Python Checks

### PY-TYPING-01: Type Hints
Use type hints for function signatures and complex data structures.

**Check:** Function definitions without type annotations, especially in public APIs
**Severity:** Medium for public functions, Low for internal helpers

### PY-ASYNC-01: Async Patterns
Use async/await correctly and consistently.

**Check patterns:**
- Mixing sync and async code incorrectly
- Blocking calls inside async functions
- Missing `await` on coroutines
- No async database driver when using async web framework

### PY-IMPORT-01: Import Organization
Follow import ordering conventions.

**Standard order:** stdlib → third-party → local
**Check:** `isort` or `ruff` configuration present

### PY-VENV-01: Virtual Environment
Projects should use isolated virtual environments.

**Check:** Presence of `venv/`, `.venv/`, `pyproject.toml` with tool config, or `Pipfile`
**Anti-pattern:** Global package installation instructions in README

### PY-PACKAGING-01: Modern Packaging
Use modern Python packaging tools.

**Check:** `pyproject.toml` over `setup.py`, `uv` or `poetry` over raw pip
**Severity:** Low (recommendation)

## Go Checks

### GO-ERROR-01: Error Handling
Go errors should be checked and wrapped with context.

**Check patterns:**
- `err` assigned but not checked (returned or handled)
- Errors not wrapped with `fmt.Errorf("context: %w", err)`
- Panic used outside of initialization code
- Bare `return err` without adding context

**Severity:** High for unchecked errors, Medium for unwrapped errors

### GO-GOROUTINE-01: Goroutine Management
Goroutines should be properly managed to prevent leaks.

**Check patterns:**
- Goroutines launched without context cancellation
- No `sync.WaitGroup` or channel-based completion signaling
- Goroutines blocked on channel reads with no timeout
- Missing `defer cancel()` after `context.WithCancel()`

### GO-INTERFACE-01: Interface Design
Accept interfaces, return structs. Keep interfaces small.

**Check patterns:**
- Interfaces with 5+ methods (too large)
- Interfaces defined in implementation packages (should be in consumer)
- Returning interfaces instead of concrete types

### GO-CONTEXT-01: Context Propagation
Context should be propagated through the call chain.

**Check:** Functions doing I/O or calling external services without accepting `context.Context` as first parameter

## Java/Kotlin (JVM) Checks

### JVM-NULL-01: Null Safety
Handle nulls explicitly, especially at boundaries.

**Check:** Kotlin: `!!` operator usage. Java: Missing `@Nullable`/`@NonNull` annotations on public APIs

### JVM-RESOURCE-01: Resource Management
Resources should be managed with try-with-resources / use blocks.

**Check:** Database connections, streams, HTTP clients opened without try-with-resources (Java) or `.use {}` (Kotlin)

### JVM-SPRING-01: Spring Patterns (if Spring detected)
Follow Spring Boot best practices.

**Check patterns:**
- Field injection (`@Autowired` on fields) vs constructor injection
- Missing `@Transactional` on methods that require it
- Circular dependencies between beans
- No profile-specific configuration for environments

## Container/Docker Checks

### DOCKER-BASE-01: Base Image
Use minimal, pinned base images.

**Check patterns:**
- Using `latest` tag (`FROM node:latest`)
- Using full images instead of slim/alpine variants
- No multi-stage build for production images
- Running as root (no `USER` directive)

### DOCKER-LAYER-01: Layer Optimization
Optimize Docker layers for build cache efficiency.

**Check patterns:**
- `COPY . .` before installing dependencies (busts cache on every code change)
- Correct order: COPY lockfile → install deps → COPY source → build

### DOCKER-SECURITY-01: Container Security
Follow container security best practices.

**Check patterns:**
- Running as root user
- Sensitive data in image layers (secrets in ENV or COPY)
- Unnecessary packages installed
- No `.dockerignore` file
- Exposed unnecessary ports
