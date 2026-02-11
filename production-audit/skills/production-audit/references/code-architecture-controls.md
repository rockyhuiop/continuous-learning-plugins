# Code & Architecture Controls

Best practice reference for the code-architecture-auditor. Each control has an ID for traceability in findings.

## SOLID Principles

### SOLID-SRP: Single Responsibility Principle
A class/module should have only one reason to change.

**Check patterns:**
- Classes exceeding 300 lines likely have multiple responsibilities
- Files with more than 3 unrelated imports suggest mixed concerns
- Functions doing I/O + computation + formatting = multiple responsibilities

**Severity guide:**
- Critical: Core business service handling 5+ unrelated concerns
- High: Service class with 3-4 mixed responsibilities
- Medium: Utility class mixing unrelated helpers
- Low: Minor mixed concerns in non-critical code

### SOLID-OCP: Open-Closed Principle
Entities should be open for extension, closed for modification.

**Check patterns:**
- Long switch/if-else chains that grow with each new variant
- Repeated modifications to the same class for different features
- No abstraction layer for pluggable behaviors

### SOLID-LSP: Liskov Substitution Principle
Subtypes must be substitutable for their base types.

**Check patterns:**
- Subclasses throwing `NotImplementedError` for inherited methods
- Type checks against specific subtypes (`instanceof`) in consumer code
- Override methods that narrow contracts or add preconditions

### SOLID-ISP: Interface Segregation Principle
Clients should not depend on interfaces they do not use.

**Check patterns:**
- Large interfaces (>10 methods) where most implementations only use a subset
- Methods returning `undefined`/`null` because the implementation doesn't support them
- "God interfaces" that every service must implement

### SOLID-DIP: Dependency Inversion Principle
High-level modules should not depend on low-level modules; both should depend on abstractions.

**Check patterns:**
- Direct imports of concrete implementations in business logic
- Business logic importing database drivers, HTTP clients, or file system modules directly
- No dependency injection or inversion of control

## Clean Code Metrics

### CC-COMPLEXITY-01: Cyclomatic Complexity
Measure the number of independent paths through a function.

**Thresholds:**
- Acceptable: 1-10
- Concerning: 11-20 (Medium finding)
- High risk: 21-30 (High finding)
- Critical: 31+ (Critical finding)

**Detection patterns:**
- Count `if`, `else if`, `case`, `while`, `for`, `&&`, `||`, `catch`, `?:` per function
- Deeply nested conditionals (4+ levels) are a strong signal

### CC-COGNITIVE-01: Cognitive Complexity
Measures how difficult code is to understand (more nuanced than cyclomatic).

**Thresholds:**
- Acceptable: 0-15
- Concerning: 16-25 (Medium finding)
- High risk: 26-40 (High finding)
- Critical: 41+ (Critical finding)

**Key rules:**
- Nesting increases penalty (nested `if` costs more than flat `if`)
- Boolean operator sequences increment complexity
- Recursion adds to complexity

### CC-DUPLICATION-01: Code Duplication
Repeated code blocks that should be extracted.

**Thresholds:**
- 3+ repetitions of 6+ lines = Medium finding
- Duplicated business logic across services = High finding
- Copy-pasted security/validation logic = Critical finding

**Detection patterns:**
- Grep for identical or near-identical function bodies
- Look for copied-and-modified patterns (same structure, different variable names)
- Check for repeated error handling blocks

### CC-FUNCTION-SIZE-01: Function Length
Functions should be small and focused.

**Thresholds:**
- Acceptable: 1-30 lines
- Concerning: 31-60 lines (Low finding)
- Too long: 61-100 lines (Medium finding)
- Critical: 101+ lines (High finding)

### CC-FILE-SIZE-01: File Length
Files should be focused on a single responsibility.

**Thresholds:**
- Acceptable: 1-300 lines
- Concerning: 301-500 lines (Low finding)
- Too long: 501-800 lines (Medium finding)
- Critical: 801+ lines (High finding)

### CC-NAMING-01: Naming Conventions
Names should be meaningful, consistent, and reveal intent.

**Check patterns:**
- Single-letter variables outside loop indices
- Abbreviated names that obscure meaning
- Inconsistent naming styles within the same module (camelCase vs snake_case)
- Boolean variables not prefixed with is/has/should/can
- Functions not starting with verbs

## Architecture Patterns

### ARCH-LAYERING-01: Layering Violations
Respect architectural layer boundaries.

**Check patterns:**
- Domain/business logic importing from infrastructure layer
- Presentation layer directly accessing database
- Circular dependencies between layers
- Utility code depending on application-specific code

**Common layer order (outer depends on inner):**
1. Presentation / API / Controllers
2. Application / Use Cases / Services
3. Domain / Business Logic / Entities
4. Infrastructure / Data Access / External Services

### ARCH-COUPLING-01: Coupling Analysis
Components should have minimal coupling.

**Check patterns:**
- High fan-out: A module importing 10+ other modules
- High fan-in: A module imported by 20+ other modules (may be OK for utilities)
- Temporal coupling: Function A must be called before Function B with no enforcement
- Content coupling: Module A directly accessing internal data of Module B

**Severity guide:**
- Critical: Circular dependency between major modules
- High: Business logic tightly coupled to specific database/framework
- Medium: Unnecessary coupling between features
- Low: Minor import chain inefficiencies

### ARCH-COHESION-01: Cohesion Analysis
Components should have high internal cohesion.

**Check patterns:**
- "God objects" that contain unrelated methods
- Data classes that are always used partially (only some fields accessed)
- Modules where methods don't share data or call each other

### ARCH-DEAD-CODE-01: Dead Code Detection
Unused code increases maintenance burden.

**Check patterns:**
- Exported functions/classes never imported elsewhere
- Unreachable code after return/throw statements
- Commented-out code blocks
- Feature flags for features that shipped long ago
- Unused dependencies in package.json/requirements.txt

**Severity guide:**
- High: Large dead modules (100+ lines) in active codebase
- Medium: Dead functions or classes
- Low: Small unused utilities or commented code

### ARCH-ABSTRACTION-01: Abstraction Level
Code should operate at consistent abstraction levels.

**Check patterns:**
- Functions mixing high-level orchestration with low-level bit manipulation
- Controllers containing database query strings
- Business logic formatting HTTP responses
- One function calling both `processOrder()` and `buffer.slice(0, 4)`
