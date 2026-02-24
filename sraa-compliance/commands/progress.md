---
description: Cross-repo SRAA progress review with git history analysis and XLSX export
argument-hint: "[repo_paths...] [--since <date>] [--xlsx]"
allowed-tools: ["Read", "Write", "Glob", "Grep", "Bash", "Task"]
---

# SRAA Cross-Repo Progress Review

Review SRAA compliance progress across multiple repositories by reading each repo's audit findings, checking git history for remediated items, and optionally exporting the consolidated results as an Excel spreadsheet.

## Arguments

- `repo_paths...` - Space-separated absolute paths to repositories. If omitted, uses the current working directory and any additional working directories from the session.
- `--since <date>` - Only check git history since this date (e.g., `2026-02-05`). If omitted, uses each repo's audit start date from `audit-state.md`.
- `--xlsx` - Export results to `.xlsx` file (one sheet per repo + summary). If omitted, outputs a formatted text summary only.
- `--output <path>` - Custom output path for the XLSX file. Default: `<cwd>/output/SRAA-Audit-Report-<YYYY>.xlsx`.

## Execution Steps

### Step 1: Discover Repositories

1. Collect repo paths from arguments or session context (additional working directories).
2. For each repo path, check if `.claude/sraa-audit/audit-state.md` exists.
3. Report which repos have SRAA audit data and which do not.
4. If no repos have audit data, display:
   ```
   No SRAA audit data found in any repository.
   Run /sraa:audit in each repo to generate audit findings first.
   ```

### Step 2: Read Audit Data from Each Repo

For each repo with audit data:

1. Read `.claude/sraa-audit/audit-state.md` to get:
   - Audit date
   - Audit mode (fresh/incremental)
   - Domain progress table
   - Findings summary counts (Critical/High/Medium/Low)
2. Read all finding files from `.claude/sraa-audit/findings/`:
   - `security-controls.md`
   - `application-security.md`
   - `policy-compliance.md`
   - `infrastructure.md`
3. Parse each finding to extract:
   - Finding ID (e.g., SC-001, APP-002, POL-003, INF-004)
   - Severity (Critical/High/Medium/Low)
   - Title/description
   - Status (Open/Fixed/Accepted)
   - Domain
   - OWASP category or control reference
   - Evidence (file paths, line numbers)
   - Recommendation

Read findings from multiple repos in parallel using the Task tool when possible.

### Step 3: Check Git History for Remediation

For each repo, determine the `--since` date:
- If `--since` argument provided, use that date for all repos.
- Otherwise, extract the audit start date from that repo's `audit-state.md`.

Run git log for each repo to find security-related commits:

```bash
git -C <repo_path> log --format="%H %ad %s" --date=short --since="<date>"
```

Look for commits with keywords: `fix`, `security`, `sraa`, `vulnerability`, `xss`, `csrf`, `cors`, `helmet`, `jwt`, `auth`, `sanitize`, `rate-limit`, `secrets`, `env`, `docker`, `csp`, `sri`, `dompurify`, `injection`, `owasp`.

Cross-reference git commit messages and changed files against the open findings to determine which findings have been addressed by code changes.

### Step 4: Classify Findings

For each finding across all repos, classify as:

- **Fixed** - Git history shows commits that directly address the finding (code changes to the relevant files with relevant commit messages). Mark with the commit hash and date as evidence.
- **Open** - No matching remediation commits found. The finding remains unaddressed.

### Step 5: Generate Consolidated Summary

Display a formatted summary organized as two lists:

```
SRAA Cross-Repo Progress Review
================================
Repos analyzed: [count]
Period: [since_date] to [today]

FIXED ITEMS ([count])
─────────────────────
[repo-name] [ID] [Severity] - [Title] (fixed [date])
[repo-name] [ID] [Severity] - [Title] (fixed [date])
...

OPEN ITEMS ([count])
────────────────────
[repo-name] [ID] [Severity] - [Title]
[repo-name] [ID] [Severity] - [Title]
...

Summary by Repository
─────────────────────
| Repository | Fixed | Open | Critical | High | Medium | Low |
|------------|-------|------|----------|------|--------|-----|
| repo-1     | 5     | 12   | 1        | 3    | 5      | 3   |
| repo-2     | 0     | 8    | 2        | 2    | 3      | 1   |
| Total      | 5     | 20   | 3        | 5    | 8      | 4   |
```

### Step 6: Export to XLSX (if --xlsx flag present)

If `--xlsx` flag is provided:

1. Prepare a JSON data file at `/tmp/sraa-progress-data.json` with structure:
   ```json
   {
     "generated": "ISO timestamp",
     "since_date": "YYYY-MM-DD",
     "repos": {
       "repo-name": {
         "audit_date": "YYYY-MM-DD",
         "fixed": [
           {
             "id": "SC-001",
             "severity": "Critical",
             "domain": "Security Controls",
             "title": "...",
             "evidence": "...",
             "recommendation": "...",
             "fixed_date": "YYYY-MM-DD",
             "fixed_commit": "abc1234"
           }
         ],
         "open": [
           {
             "id": "APP-002",
             "severity": "High",
             "domain": "Application Security",
             "title": "...",
             "evidence": "...",
             "recommendation": "..."
           }
         ]
       }
     }
   }
   ```

2. Ensure Python environment with openpyxl is available:
   ```bash
   # Check if openpyxl is available, install if needed
   python3 -c "import openpyxl" 2>/dev/null || python3 -m pip install --user openpyxl 2>/dev/null || (python3 -m venv /tmp/sraa-venv && /tmp/sraa-venv/bin/pip install openpyxl)
   ```

3. Run the bundled XLSX generation script:
   ```bash
   # Use system python or venv python depending on what works
   PYTHON=$(python3 -c "import openpyxl; import sys; print(sys.executable)" 2>/dev/null || echo "/tmp/sraa-venv/bin/python3")
   $PYTHON ${CLAUDE_PLUGIN_ROOT}/scripts/generate-sraa-xlsx.py /tmp/sraa-progress-data.json [output_path]
   ```

4. Display the output file path and offer to open it.

## Repos Without Dedicated Audit Reports

Some repos may not have their own `.claude/sraa-audit/` directory but are covered by findings in another repo's audit (e.g., a backend audit that includes frontend findings). In this case:
- Note that the repo has no dedicated audit.
- If the user provides context about which parent audit covers it, include those findings on the repo's sheet.
- Otherwise, create a sheet noting "No dedicated SRAA audit — findings may be covered in [parent repo] audit."

## Error Handling

- If a repo path is invalid, skip it and warn the user.
- If a repo has no git history (not a git repo), skip the git analysis and report findings as-is.
- If openpyxl installation fails, fall back to CSV export and inform the user.
- If finding files are malformed, extract what's parseable and note issues.

## Tips

- Run after completing `/sraa:audit` in each repository.
- Use `--since` to focus on a specific remediation window (e.g., since the last report was submitted).
- The XLSX output is suitable for sharing with management or compliance reviewers.
