#!/usr/bin/env bash
# SessionStart hook for sraa-compliance plugin
# Checks for in-progress SRAA audit and injects context if found

set -euo pipefail

# Read cwd from stdin JSON (Claude Code passes hook input on stdin)
CWD=$(cat | python3 -c "import sys,json; print(json.load(sys.stdin).get('cwd',''))" 2>/dev/null || echo "")

if [ -z "$CWD" ]; then
  exit 0
fi

AUDIT_STATE="$CWD/.claude/sraa-audit/audit-state.md"

if [ ! -f "$AUDIT_STATE" ]; then
  exit 0
fi

# Extract a one-line summary from the audit state file
SUMMARY=$(head -20 "$AUDIT_STATE" | grep -E '(domain|finding|progress|complete|status)' -i | head -1 || echo "")

if [ -z "$SUMMARY" ]; then
  SUMMARY="SRAA audit state file detected"
fi

# Escape for JSON
SUMMARY=$(printf '%s' "$SUMMARY" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\t/\\t/g')

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "SRAA audit in progress: ${SUMMARY}. Run /sraa:status for details."
  }
}
EOF

exit 0
