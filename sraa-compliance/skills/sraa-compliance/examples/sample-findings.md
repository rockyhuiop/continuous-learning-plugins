# Sample SRAA Findings

Example findings demonstrating the proper documentation format for SRAA compliance audits.

---

## Finding: APP-001

**Severity:** High
**Domain:** Web/Mobile Application (Annex C Area 9)
**Control Reference:** S17-SD-1.3, G3-A03
**Status:** Open

### Description
Hardcoded API credentials discovered in frontend source code. The API key for the authentication service is visible in the compiled JavaScript bundle, potentially allowing unauthorized API access.

### Evidence
- File: `src/api/config.ts:15`
- Observation: `const API_KEY = "sk_live_abc123..."` exposed in source
- Risk: API key visible in browser developer tools and source maps

### Recommendation
1. Move API key to environment variable (`VITE_API_KEY`)
2. Implement backend proxy for sensitive API calls
3. Rotate compromised API key immediately
4. Review all source files for hardcoded secrets

### Remediation
[Pending - No updates]

---

## Finding: APP-002

**Severity:** Critical
**Domain:** Web/Mobile Application (Annex C Area 9)
**Control Reference:** S17-AC-3.1, G3-A07
**Status:** Open

### Description
JWT tokens stored in localStorage without expiration validation. The application accepts tokens regardless of expiry, potentially allowing session replay attacks with stolen tokens.

### Evidence
- File: `src/utils/tokenManager.ts:42`
- Observation: `localStorage.getItem('token')` used without expiry check
- File: `src/api/config.ts:28`
- Observation: Token attached to requests without validation

### Recommendation
1. Implement token expiry validation before each API call
2. Clear expired tokens from storage automatically
3. Use short-lived access tokens with refresh token pattern
4. Consider HttpOnly cookies for token storage

### Remediation
[Pending - No updates]

---

## Finding: NET-001

**Severity:** Medium
**Domain:** External Network (Annex C Area 3)
**Control Reference:** S17-CS-2.1, G3-CS-1
**Status:** Open

### Description
Development server exposed on port 5174 with CORS allowing all origins. While this appears to be development configuration, it could lead to CSRF attacks if deployed to production.

### Evidence
- File: `vite.config.ts:8`
- Observation: `server: { host: true }` enables network access
- Configuration: No CORS restrictions in development mode

### Recommendation
1. Restrict `host: true` to development only via environment check
2. Implement explicit CORS allowlist in production
3. Add security headers (CSP, X-Frame-Options) in production
4. Document development vs production configuration differences

### Remediation
[Pending - No updates]

---

## Finding: POL-001

**Severity:** Low
**Domain:** Security Policy & Procedures (Annex C Area 10)
**Control Reference:** S17-SM-1.2, G3-SM-1
**Status:** Open

### Description
No SECURITY.md or security policy documentation found in the repository. Developers and contributors lack guidance on security practices and vulnerability reporting.

### Evidence
- File: Repository root
- Observation: Missing SECURITY.md file
- Observation: No security guidelines in CLAUDE.md or README.md

### Recommendation
1. Create SECURITY.md with:
   - Vulnerability reporting process
   - Security contact information
   - Supported versions for security updates
2. Add security practices section to CLAUDE.md
3. Document dependency update policy

### Remediation
[Pending - No updates]

---

## Finding: APP-003

**Severity:** Medium
**Domain:** Web/Mobile Application (Annex C Area 9)
**Control Reference:** S17-OS-4.1, G3-A09
**Status:** Open

### Description
Authentication failures not logged with sufficient detail for security monitoring. Failed login attempts do not capture IP address, timestamp, or attempted username for security analysis.

### Evidence
- File: `src/contexts/AuthContext.tsx:89`
- Observation: Login failure only shows toast notification to user
- Observation: No server-side logging of failed authentication attempts

### Recommendation
1. Implement comprehensive authentication logging:
   - Timestamp (ISO 8601)
   - Attempted username/email
   - IP address
   - User agent
   - Failure reason
2. Configure alerts for multiple failed attempts
3. Implement rate limiting on authentication endpoints

### Remediation
[Pending - No updates]

---

## Finding: INF-001

**Severity:** Medium
**Domain:** Infrastructure (Annex C Area 6/7)
**Control Reference:** S17-AC-4.2, G3-AC-4
**Status:** Open

### Description
Environment files (.env) not in .gitignore or contain example values that may be confused with real credentials. Risk of accidental credential exposure.

### Evidence
- File: `.env.development`
- Observation: File tracked in git with development values
- File: `.gitignore`
- Observation: Only `.env` excluded, not `.env.development`

### Recommendation
1. Add all `.env*` files to .gitignore (except .env.example)
2. Create `.env.example` with placeholder values
3. Document environment setup in README.md
4. Review git history for any committed secrets

### Remediation
[Pending - No updates]

---

## Summary Statistics

| Severity | Count |
|----------|-------|
| Critical | 1 |
| High | 1 |
| Medium | 3 |
| Low | 1 |
| **Total** | **6** |

### By Domain

| Domain | Count |
|--------|-------|
| Web/Mobile Application | 3 |
| External Network | 1 |
| Infrastructure | 1 |
| Security Policy | 1 |

---

## Remediation Priority

### Immediate (24-48 hours)
1. APP-002: JWT token expiration (Critical)

### High Priority (1-2 weeks)
2. APP-001: Hardcoded API credentials (High)

### Standard Priority (1-3 months)
3. APP-003: Authentication logging (Medium)
4. NET-001: CORS configuration (Medium)
5. INF-001: Environment file management (Medium)

### Next Review Cycle
6. POL-001: Security documentation (Low)
