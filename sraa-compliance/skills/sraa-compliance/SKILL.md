---
name: SRAA Compliance
description: This skill should be used when the user asks about "SRAA compliance", "Hong Kong security audit", "S17 baseline policy", "G3 security guidelines", "ISPG-SM01", "security risk assessment Hong Kong", "Annex C audit", or needs to understand SRAA audit requirements for government/NGO compliance.
version: 1.0.0
---

# SRAA (Security Risk Assessment and Audit) Framework

## Overview

SRAA is Hong Kong's cybersecurity audit framework mandated by the Digital Policy Office (DPO) for government departments, statutory bodies, NGOs, and government-funded entities. The framework ensures organizations maintain robust information security through systematic risk assessment and compliance auditing.

## Core Framework Documents

| Document | Purpose | Scope |
|----------|---------|-------|
| **S17** | Baseline IT Security Policy | Mandatory minimum requirements |
| **G3** | IT Security Guidelines | Detailed technical controls |
| **ISPG-SM01** | Practice Guide for SRAA | Assessment methodology |

## Two Components of SRAA

### Security Risk Assessment (SRA)
Process to identify, analyze, and evaluate security risks, then determine mitigation measures to reduce risks to acceptable levels.

**Steps:** Risk identification → Risk analysis → Risk evaluation → Mitigation determination

### Security Audit (SA)
Review process ensuring security measures comply with policies, standards, and requirements; and that treatment recommendations are properly implemented.

**Focus:** Compliance verification, control effectiveness, proper implementation

## Six Security Management Functional Areas

1. **Security Management Framework and Organisation**
   - Policy establishment, structural accountability
   - Security roles and responsibilities

2. **Governance, Risk Management, and Compliance**
   - Risk-based approach implementation
   - Regulatory compliance management

3. **Security Operations**
   - Prevent, Detect, Respond, Recover principle
   - Technical and operational controls

4. **Security Event and Incident Management**
   - Real-time threat identification
   - Response protocols and procedures

5. **Awareness Training and Capability Building**
   - Staff security education
   - Competency development

6. **Situational Awareness and Information Sharing**
   - Vulnerability monitoring
   - Threat intelligence dissemination

## Annex C: Ten Audit Areas

| Area | Focus | Key Controls |
|------|-------|--------------|
| 1. Firewall | Perimeter defense | Rule review, logging, segmentation |
| 2. Internal Network | LAN security | Segmentation, access controls, monitoring |
| 3. External Network | WAN/Internet | Exposure analysis, DMZ, filtering |
| 4. Host Security | Endpoints | Hardening, patching, AV, logging |
| 5. Internet Security | Web/Email | Gateway protection, filtering, DLP |
| 6. Remote Access | VPN/Telecommuting | Authentication, encryption, monitoring |
| 7. Wireless | RF Security | WPA3, rogue AP detection, segmentation |
| 8. Phone Line | Telecom | VoIP security, call logging |
| 9. Web/Mobile App | Application | OWASP, input validation, auth |
| 10. Policies & Procedures | Governance | Documentation, change management |

## Finding Severity Classification

| Severity | Description | Response Timeline |
|----------|-------------|-------------------|
| **Critical** | Immediate exploitation risk, data breach imminent | Immediate (24-48 hours) |
| **High** | Significant vulnerability, likely exploitation | 1-2 weeks |
| **Medium** | Moderate risk, requires attention | 1-3 months |
| **Low** | Minor issue, best practice improvement | Next review cycle |

## Evidence Collection Requirements

For each finding, document:
- **File location**: Specific path and line number
- **Configuration**: Relevant settings or code
- **Observation**: What was found and why it's a concern
- **Control reference**: S17/G3 control identifier
- **Recommendation**: Specific remediation steps

## Using This Plugin

### Start an Audit
```
/sraa:audit              # Resume or start audit
/sraa:audit --fresh      # Start new audit
/sraa:audit --domain application-security  # Specific domain
```

### Check Progress
```
/sraa:status
```

### Generate Report
```
/sraa:report
/sraa:report --format html
```

## Additional Resources

### Reference Files

For detailed control requirements, consult:
- **`references/s17-baseline-controls.md`** - Full S17 control matrix
- **`references/g3-security-guidelines.md`** - G3 detailed guidelines
- **`references/ispg-sm01-assessment.md`** - Assessment methodology
- **`references/annex-c-audit-areas.md`** - Complete audit checklists

### Example Files

Working examples in `examples/`:
- **`sample-findings.md`** - Example finding documentation format

## Assessment Frequency

- **New systems**: Early in development lifecycle
- **Existing systems**: At least once every two years
- **After changes**: Following major modifications
- **Continuous**: Ongoing monitoring recommended
