# Changelog

## [1.1.0] - 2026-02-24

### Added
- `/sraa:progress` command for cross-repo SRAA progress review
- `cross-repo-reviewer` agent for analyzing remediation across multiple repositories
- `generate-sraa-xlsx.py` script for Excel export with color-coded severity
- Git history analysis to detect which findings have been remediated by commits
- XLSX output with summary sheet, all-fixed sheet, and per-repo sheets
- Support for `--since`, `--xlsx`, and `--output` flags

## [1.0.0] - 2026-02-04

### Added
- Initial release of SRAA compliance auditing plugin
- Security controls auditor (Annex C areas 1-6)
- Application security auditor (Annex C area 9)
- Policy compliance auditor (Annex C area 10)
- Infrastructure auditor (Annex C areas 6-8)
- SRAA orchestrator for coordinating multi-domain audits
- Memory coordinator for audit state persistence
- Slash commands: /sraa:audit, /sraa:status, /sraa:report
- Session start hook for audit state detection
- Reference documents for S17, G3, ISPG-SM01, and Annex C
