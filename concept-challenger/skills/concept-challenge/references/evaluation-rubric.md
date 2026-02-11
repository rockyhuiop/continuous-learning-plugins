# Concept Evaluation Rubric

Detailed criteria for rating concept application as Strong, Adequate, or Needs Review.

## Rating Definitions

### Strong

The user demonstrates genuine understanding that goes beyond recall. Observable indicators:

- **Natural vocabulary usage**: Uses concept terminology naturally within their explanation, not as a recited definition. E.g., they say "the breaker trips when failures exceed the threshold" in context, not "a circuit breaker is a pattern that..."
- **Scenario-specific trade-offs**: Discusses trade-offs relevant to THIS scenario, not generic trade-offs. E.g., "In a payment system, false positives from the circuit breaker mean declined transactions, so the failure threshold should be higher than in a non-critical path" -- not just "there are trade-offs with circuit breakers." Another example: "Using event sourcing here means the audit log is free, but rebuilding the account balance from 10M events requires snapshots" (specific to fintech scenario, not generic).
- **Edge case awareness**: Identifies what could go wrong with their approach in this specific context. E.g., "If the circuit stays open too long, we'd accumulate a backlog of unprocessed fraud checks that need reconciliation." Or: "If we replay events out of order, the inventory count diverges from reality."
- **Related concept connections**: References related concepts from their vault when relevant. E.g., "We could combine this with a bulkhead pattern to isolate the fraud-detection dependency." Or: "Event sourcing pairs naturally with CQRS here since the read model for real-time dashboards has different query patterns than the write model."
- **Implementation specifics**: Provides concrete implementation details appropriate to the scenario, not abstract descriptions.

### Adequate

The user correctly applies the concept but stays surface-level. Observable indicators:

- **Correct application**: The concept is applied to the scenario correctly -- the right pattern for the right problem.
- **Generic trade-offs**: Mentions trade-offs but in general terms, not specific to the scenario. E.g., "There's a trade-off between availability and consistency" without relating it to the payment context.
- **Definition echo**: Parts of the response closely mirror the vault note's definition rather than demonstrating independent understanding.
- **Missing connections**: Doesn't reference related concepts that would strengthen the solution.
- **Shallow implementation**: Describes what to do at a high level but lacks concrete implementation details for this scenario.

### Needs Review

The user struggles to apply the concept beyond recall. Observable indicators:

- **Definition recitation**: Restates the concept definition without applying it to the scenario. E.g., "A circuit breaker prevents cascading failures by monitoring calls and opening when failures exceed a threshold" -- correct but not applied.
- **Misapplication**: Applies the concept in a way that wouldn't work for this scenario. E.g., applying circuit breaker to a synchronous, single-service problem where retry logic would suffice.
- **Concept confusion**: Confuses the concept with a related but different one. E.g., confusing circuit breaker with rate limiting or retry patterns.
- **Scenario mismatch**: Ignores the scenario's specific constraints or context. The answer would be the same regardless of the scenario presented.
- **Incomplete application**: Addresses only part of the concept. E.g., describes how to detect failures but not how to handle the open state or recovery.

## Providing Feedback

### Structure

1. **Start with the rating** as a clear heading: `**Rating: Strong**` (or Adequate / Needs Review)
2. **Lead with strengths** -- quote specific parts of the user's response that demonstrate understanding
3. **Then address gaps** -- be specific about what was missing or could be improved
4. **End with a growth direction** -- one concrete thing the user could explore to deepen understanding

### Quoting the User

Always reference the user's actual words:

**Good**: "Your point that 'the half-open state should probe with a single low-value transaction first' shows strong understanding of how to adapt the recovery mechanism to a financial context."

**Bad**: "You showed good understanding of the concept." (Too generic -- the user doesn't know what specifically was good.)

### Feedback by Rating

**For Strong ratings:**
- Highlight the specific moments of insight that went beyond textbook
- Note any particularly good connections to related concepts
- Suggest an advanced challenge or a deeper exploration direction
- Keep it brief -- strong answers don't need long feedback

**For Adequate ratings:**
- Acknowledge what was correct
- Identify 1-2 specific areas where the response could be deeper
- Ask a follow-up question that would push toward Strong. E.g., "What would happen in this payment system if the circuit breaker's timeout is too aggressive?"
- Suggest re-reading the vault note's example for comparison

**For Needs Review ratings:**
- Be encouraging -- acknowledge the attempt and any correct elements
- Identify the specific gap (definition-only, misapplication, confusion)
- Provide a brief hint about how the concept applies to this scenario (don't give the full answer)
- Suggest the user re-read the vault note and try a basic-difficulty challenge
- Frame it as a learning opportunity: "This is exactly the kind of gap that challenges are designed to surface."

## Edge Cases

### User Gives a Valid Alternative Approach

If the user applies a different concept that also validly solves the problem, don't mark it as wrong. Instead:
- Acknowledge the validity of their approach
- Note that the intended concept was X, and explain how it would also apply
- Rate based on the quality of their chosen approach's application

### User Asks for Clarification

If the user asks questions about the scenario before answering, this is a positive signal (seeking understanding). Answer their questions, then let them provide their full response before evaluating.

### User Gives a Very Short Answer

If the response is only 1-2 sentences, it's likely Adequate at best. But don't penalize brevity per se -- evaluate the substance. If the answer is correct but terse, rate appropriately and note that more detail would demonstrate deeper understanding.

### User Responds in a Mix of Languages

Evaluate the concept application regardless of language. For the language review section, only evaluate the English portions following `references/language-rubric.md`. Gently encourage writing the full response in English for practice, but don't treat non-English text as an error.
