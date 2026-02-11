#!/bin/bash
# Production Audit - Session Start Hook
# Detects existing audit state and notifies the user

AUDIT_STATE=".claude/production-audit/audit-state.md"

if [ -f "$AUDIT_STATE" ]; then
  # Extract key info from audit state
  PROJECT=$(grep "^\*\*Project:\*\*" "$AUDIT_STATE" 2>/dev/null | sed 's/\*\*Project:\*\* //')
  SCOPE=$(grep "^\*\*Scope:\*\*" "$AUDIT_STATE" 2>/dev/null | sed 's/\*\*Scope:\*\* //')
  STARTED=$(grep "^\*\*Started:\*\*" "$AUDIT_STATE" 2>/dev/null | sed 's/\*\*Started:\*\* //')

  # Count findings by severity
  CRITICAL=0
  HIGH=0
  MEDIUM=0
  LOW=0

  for f in .claude/production-audit/findings/*.md; do
    if [ -f "$f" ]; then
      c=$(grep -c "^\*\*Severity:\*\* Critical" "$f" 2>/dev/null || echo 0)
      h=$(grep -c "^\*\*Severity:\*\* High" "$f" 2>/dev/null || echo 0)
      m=$(grep -c "^\*\*Severity:\*\* Medium" "$f" 2>/dev/null || echo 0)
      l=$(grep -c "^\*\*Severity:\*\* Low" "$f" 2>/dev/null || echo 0)
      CRITICAL=$((CRITICAL + c))
      HIGH=$((HIGH + h))
      MEDIUM=$((MEDIUM + m))
      LOW=$((LOW + l))
    fi
  done

  TOTAL=$((CRITICAL + HIGH + MEDIUM + LOW))

  # Count completed domains
  COMPLETED=$(grep -c "completed" "$AUDIT_STATE" 2>/dev/null || echo 0)
  PENDING=$(grep -c "pending" "$AUDIT_STATE" 2>/dev/null || echo 0)

  echo "[Production Audit] Existing audit found for ${PROJECT:-this project}"
  echo "  Started: ${STARTED:-unknown} | Scope: ${SCOPE:-full}"
  echo "  Findings: ${TOTAL} total (${CRITICAL}C ${HIGH}H ${MEDIUM}M ${LOW}L)"
  echo "  Domains: ${COMPLETED} completed, ${PENDING} pending"
  echo "  Resume: /production-audit:audit | Status: /production-audit:status"
fi
