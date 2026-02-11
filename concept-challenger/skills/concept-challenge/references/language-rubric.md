# Language Evaluation Rubric

Detailed criteria for evaluating English technical writing quality in challenge responses. Designed for non-native English speakers working in software engineering.

## Evaluation Order

Always evaluate in this order:

1. **Positive reinforcement** -- what was done well
2. **Grammar corrections** -- specific errors with rule names
3. **Technical writing quality** -- structure and precision
4. **Vocabulary** -- good usage and improvement suggestions

Lead with positives. The goal is to build confidence while improving skills.

## Grammar Categories

Check for these common issues in order of frequency for non-native speakers:

### Article Usage (a/an/the)

The most common error category. Check for:
- Missing articles: "I would add ~~circuit breaker~~" → "I would add **a** circuit breaker"
- Wrong article: "~~A~~ payment system we discussed" → "**The** payment system we discussed"
- Unnecessary article: "~~The~~ software engineering requires..." → "Software engineering requires..."

**Rule of thumb**: Specific/known → `the`. One of many/first mention → `a/an`. General category → no article.

### Subject-Verb Agreement

- "The system ~~process~~ requests" → "The system **processes** requests"
- "Each of the services ~~are~~ independent" → "Each of the services **is** independent"
- "The data ~~are~~ stored" → "The data **is** stored" (in technical writing, "data" typically takes singular)

### Tense Consistency

Technical writing typically uses present tense for how systems work and would/could for proposals:

- Mixing tenses: "The service ~~processed~~ requests and then ~~will send~~ them" → "The service **processes** requests and then **sends** them"
- Proposals: "I ~~will add~~ a cache layer" → "I **would add** a cache layer" (hypothetical proposal)

### Preposition Usage

- "Depends ~~of~~ the configuration" → "Depends **on** the configuration"
- "Results ~~to~~ failures" → "Results **in** failures"
- "Responsible ~~of~~ handling" → "Responsible **for** handling"

### Countable/Uncountable Nouns

- "~~Less~~ errors" → "**Fewer** errors" (countable)
- "~~A~~ traffic" → "traffic" (uncountable, no article)
- "~~Many~~ latency" → "**much** latency" / "**high** latency" (uncountable)

### Conditional Structures

- "If the service ~~will fail~~, we retry" → "If the service **fails**, we retry" (first conditional: present, not future)
- "If we ~~would add~~ a cache..." → "If we **added** a cache..." (second conditional: past tense in if-clause)

## Technical Writing Quality

### Argument Structure

Good technical writing follows a logical flow. Evaluate:

**Claim → Evidence → Implication** pattern:
- **Claim**: What approach to take
- **Evidence**: Why it works (technical reasoning)
- **Implication**: What this means for the system

**Good**: "I would introduce a circuit breaker around the fraud-detection call (claim). When failures exceed 5 in a 10-second window, the breaker opens and returns a default 'pending review' status (evidence). This prevents the gateway thread pool from exhausting while still allowing legitimate transactions to proceed with deferred fraud checking (implication)."

**Weak**: "I would add a circuit breaker. This would help with the failures. The system would be more reliable." (Claims without evidence or implications.)

### Transition Usage

Check for logical connectors between ideas:

- **Adding**: furthermore, additionally, moreover, also
- **Contrasting**: however, nevertheless, in contrast, on the other hand
- **Cause/effect**: consequently, therefore, as a result, thus
- **Specifying**: specifically, in particular, namely, for instance
- **Sequencing**: first, then, subsequently, finally

**Good**: "The circuit breaker would prevent cascading failures. **However**, we also need to consider what happens to requests during the open state. **Specifically**, payment requests could be queued for retry **rather than** being immediately rejected."

**Weak**: "The circuit breaker prevents failures. And we need to handle open state. And payments should be queued." (No transitions -- reads as a list, not an argument.)

### Precision

Technical writing should use specific terms, not vague ones:

| Vague | Precise |
|-------|---------|
| "makes it faster" | "reduces p99 latency from 2s to 200ms" |
| "handles the problem" | "prevents cascading failures by isolating the dependency" |
| "it's better" | "it reduces coupling between the gateway and downstream services" |
| "the thing that..." | name the specific component |
| "stuff like that" | list the specific items |

### Conciseness

Flag redundancy and wordiness:

| Wordy | Concise |
|-------|---------|
| "In order to" | "To" |
| "Due to the fact that" | "Because" |
| "At this point in time" | "Now" / "Currently" |
| "The reason why is because" | "Because" |
| "Is able to" | "Can" |
| "In the event that" | "If" |
| "A large number of" | "Many" |

### Hedging Appropriateness

Good technical writing hedges when uncertain and asserts when confident:

**Appropriate hedging**: "This approach **might** introduce additional latency, depending on the cache invalidation strategy." (Genuinely uncertain outcome.)

**Inappropriate hedging**: "I **think maybe** a circuit breaker **could possibly** help here." (Undermines confidence when the concept clearly applies.)

**Appropriate assertion**: "A circuit breaker prevents cascading failures by failing fast." (Established fact.)

**Inappropriate assertion**: "This will definitely solve all reliability issues." (Over-confident; no single pattern solves everything.)

## Vocabulary Evaluation

### Positive Vocabulary Feedback

Call out good technical vocabulary usage:

- Correct use of domain-specific terms (e.g., "fail fast", "back-pressure", "idempotent")
- Precise verb choices (e.g., "the breaker trips" vs. "the breaker activates")
- Appropriate technical register (neither too casual nor too formal)

### Vocabulary Improvement Suggestions

Note where informal or imprecise words could be replaced:

| Informal/Imprecise | Technical/Precise |
|---------------------|-------------------|
| "break" (noun) | "failure", "outage" |
| "fix" (noun) | "resolution", "mitigation" |
| "handle" (vague) | "process", "route", "reject", "retry" |
| "talk to" (services) | "communicate with", "call", "invoke" |
| "a lot of" | "significant", "substantial", quantity |
| "thing" | name the specific entity |
| "basically" | remove or replace with specific explanation |

## Revised Version Format

### Annotation Rules

1. **Bold** all changed words and phrases: "It **causes** the system to slow down"
2. **Parenthetical explanations** for significant changes only (not every bolded word):
   - Grammar rule applied: "(subject-verb agreement)"
   - Writing improvement rationale: "(more precise than 'handles the problem')"
   - Structural change: "(moved to front for logical flow)"
3. **Preserve the user's ideas** -- never change what they argue, only how they express it
4. **Length cap**: The revised version must not exceed 1.5x the word count of the original

### Annotation Examples

**Original**: "It will causes the system to slow down because too many request."

**Revised**: "It **causes** the system to slow down **due to excessive requests**."
(subject-verb agreement: "causes" not "will causes"; "too many request" → "excessive requests" -- countable noun needs plural; "due to" is more precise than "because" in technical writing)

**Original**: "I think we should add a thing between the services that will check if it working or not and then decide."

**Revised**: "**We should introduce a circuit breaker between** the gateway and fraud-detection service **that monitors the** downstream service's **health and controls** whether requests **are forwarded or fail fast**."
(removed unnecessary hedging "I think"; named the specific pattern and components; "check if it working" → "monitors health" -- more precise; "decide" → "controls whether requests are forwarded or fail fast" -- specifies the actual decision)

### What Not to Change

- The user's reasoning or argument structure (unless it's genuinely illogical)
- Domain-specific choices (if user picks a valid implementation approach, keep it)
- Style preferences (some users prefer shorter sentences, others prefer longer)
- Correct usage (don't change things that aren't wrong)

## Tone Guidelines

### Framing Grammar Feedback

**Do**: "A small grammar note: 'causes' instead of 'will causes' (subject-verb agreement after removing the auxiliary 'will')"

**Don't**: "You made an error with subject-verb agreement." / "This sentence is grammatically incorrect."

### Framing Writing Feedback

**Do**: "Your argument flows well. One way to strengthen it further: add a transition like 'however' before the trade-off discussion to signal the shift."

**Don't**: "Your writing lacks transitions." / "This paragraph is poorly structured."

### When There Are Few Errors

If the user's English is strong, say so briefly and focus on concept evaluation. Don't manufacture corrections for the sake of having a language section. A short "Your technical writing is clear and well-structured -- no significant improvements needed" is perfectly valid.

### When There Are Many Errors

Focus on the 3-5 most impactful corrections rather than listing every error. Prioritize errors that impede comprehension first, then errors that recur most frequently. Group similar errors (e.g., "Article usage appeared several times -- here's the pattern to remember"). The goal is learning, not exhaustive error cataloging.
