#!/bin/bash
# Initialize SRAA audit workspace for a project
# Usage: ./init-audit-workspace.sh [project_path]

set -e

PROJECT_PATH="${1:-.}"
AUDIT_DIR="$PROJECT_PATH/.claude/sraa-audit"

echo "Initializing SRAA audit workspace..."

# Create directory structure
mkdir -p "$AUDIT_DIR/findings"
mkdir -p "$AUDIT_DIR/evidence"
mkdir -p "$AUDIT_DIR/reports"

# Get project name from package.json or directory
if [ -f "$PROJECT_PATH/package.json" ]; then
    PROJECT_NAME=$(grep -o '"name": *"[^"]*"' "$PROJECT_PATH/package.json" | head -1 | cut -d'"' -f4)
else
    PROJECT_NAME=$(basename "$(cd "$PROJECT_PATH" && pwd)")
fi

# Get current timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Create audit-state.md
cat > "$AUDIT_DIR/audit-state.md" << EOF
# SRAA Audit State

**Started:** $TIMESTAMP
**Mode:** incremental
**Project:** $PROJECT_NAME
**Last Updated:** $TIMESTAMP

## Domain Progress

| Domain | Status | Progress | Last Updated | Findings |
|--------|--------|----------|--------------|----------|
| Security Controls | pending | 0% | - | 0 |
| Application Security | pending | 0% | - | 0 |
| Policy Compliance | pending | 0% | - | 0 |
| Infrastructure | pending | 0% | - | 0 |

## Findings Summary

| Severity | Count |
|----------|-------|
| Critical | 0 |
| High | 0 |
| Medium | 0 |
| Low | 0 |

## Audit Log

- $TIMESTAMP Audit workspace initialized
EOF

# Create empty finding files with headers
for domain in "security-controls" "application-security" "policy-compliance" "infrastructure"; do
    DOMAIN_TITLE=$(echo "$domain" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
    cat > "$AUDIT_DIR/findings/$domain.md" << EOF
# $DOMAIN_TITLE Findings

## Summary

| ID | Severity | Title | Status |
|----|----------|-------|--------|

---

## Findings

<!-- Findings will be added below -->

EOF
done

echo "SRAA audit workspace initialized at: $AUDIT_DIR"
echo ""
echo "Directory structure:"
echo "  $AUDIT_DIR/"
echo "  ├── audit-state.md"
echo "  ├── findings/"
echo "  │   ├── security-controls.md"
echo "  │   ├── application-security.md"
echo "  │   ├── policy-compliance.md"
echo "  │   └── infrastructure.md"
echo "  ├── evidence/"
echo "  └── reports/"
echo ""
echo "Run /sraa:audit to begin the compliance assessment."
