# ISPG-SM01 Practice Guide for Security Risk Assessment & Audit

The ISPG-SM01 Practice Guide provides the methodology for conducting Security Risk Assessment and Audit (SRAA). Version 2.0 (April 2024).

## Assessment Framework

### Security Risk Assessment (SRA) vs Security Audit (SA)

| Aspect | SRA | SA |
|--------|-----|-----|
| **Purpose** | Identify and evaluate risks | Verify compliance |
| **Focus** | Vulnerabilities and threats | Control effectiveness |
| **Output** | Risk treatment recommendations | Compliance findings |
| **Timing** | Before implementation, after changes | Periodic (at least every 2 years) |

### Assessment Types

#### High-Level Assessment
- Strategic analysis of security posture
- Department-wide scope
- Identifies major risk areas
- Guides resource allocation

#### Comprehensive Assessment
- Detailed evaluation of specific systems
- Technical and procedural controls
- Vulnerability testing
- Configuration review

#### Pre-Production Assessment
- Before system deployment
- After major changes
- Validates security requirements
- Identifies deployment risks

## SRA Methodology

### Phase 1: Planning

#### Scope Definition
```
Define Boundaries:
- System components included
- Network segments
- Data types
- User populations
- Integration points

Criticality Assessment:
- Business impact analysis
- Data classification
- Regulatory requirements
- Recovery priorities
```

#### Team Composition
- Lead assessor (experienced security professional)
- Technical specialists (network, application, database)
- Business representatives
- Compliance personnel

### Phase 2: Information Gathering

#### Documentation Review
```
Required Documents:
- System architecture diagrams
- Network topology
- Data flow diagrams
- Security policies and procedures
- Previous assessment reports
- Incident history
- Change records
```

#### Technical Discovery
```
Methods:
- Network scanning
- Vulnerability scanning
- Configuration extraction
- Log analysis
- Code review (if applicable)

Tools:
- Vulnerability scanners (Nessus, Qualys)
- Network mappers (Nmap)
- Configuration analyzers
- SAST/DAST tools for applications
```

#### Stakeholder Interviews
```
Key Personnel:
- System owners
- IT administrators
- Security personnel
- Business users
- Third-party vendors (if applicable)

Topics:
- System purpose and criticality
- Known issues and concerns
- Recent changes
- Incident history
- Future plans
```

### Phase 3: Risk Analysis

#### Asset Identification
```
Categories:
1. Hardware assets
2. Software assets
3. Data assets
4. Network components
5. Personnel
6. Services and processes

Attributes:
- Asset owner
- Classification level
- Criticality rating
- Dependencies
```

#### Threat Analysis
```
Threat Sources:
- External attackers
- Malicious insiders
- Accidental actions
- Natural disasters
- System failures

Threat Actions:
- Unauthorized access
- Data theft
- Service disruption
- Data manipulation
- Malware infection
```

#### Vulnerability Assessment
```
Categories:
1. Technical vulnerabilities
   - Software flaws
   - Configuration errors
   - Missing patches
   - Weak cryptography

2. Procedural vulnerabilities
   - Missing policies
   - Inadequate training
   - Poor change management
   - Insufficient monitoring

3. Physical vulnerabilities
   - Inadequate access controls
   - Environmental risks
   - Equipment security
```

#### Impact Evaluation
```
Impact Categories:
- Financial loss
- Operational disruption
- Reputational damage
- Legal/regulatory consequences
- Safety implications

Impact Scale:
| Level | Description |
|-------|-------------|
| 5-Critical | Catastrophic impact on organization |
| 4-High | Major impact, significant resources to recover |
| 3-Medium | Moderate impact, manageable recovery |
| 2-Low | Minor impact, minimal disruption |
| 1-Negligible | Insignificant impact |
```

#### Likelihood Assessment
```
Factors:
- Threat capability
- Threat motivation
- Vulnerability exploitability
- Existing controls

Likelihood Scale:
| Level | Description |
|-------|-------------|
| 5-Almost Certain | Expected to occur multiple times |
| 4-Likely | Will probably occur |
| 3-Possible | Might occur |
| 2-Unlikely | Not expected to occur |
| 1-Rare | Only in exceptional circumstances |
```

#### Risk Rating
```
Risk = Likelihood × Impact

Risk Matrix:
          Impact
          1  2  3  4  5
    5     5 10 15 20 25
L   4     4  8 12 16 20
i   3     3  6  9 12 15
k   2     2  4  6  8 10
e   1     1  2  3  4  5

Risk Levels:
- 20-25: Critical (immediate action)
- 12-19: High (prioritized action)
- 6-11: Medium (planned action)
- 1-5: Low (monitor and accept)
```

### Phase 4: Safeguard Selection

#### Control Categories
```
Preventive Controls:
- Access controls
- Encryption
- Input validation
- Network segmentation

Detective Controls:
- Logging and monitoring
- Intrusion detection
- Vulnerability scanning
- Audit trails

Corrective Controls:
- Incident response
- Backup and recovery
- Patch management
- Configuration management
```

#### Control Selection Criteria
- Effectiveness against identified risks
- Cost-benefit analysis
- Implementation feasibility
- Operational impact
- Compliance requirements

### Phase 5: Reporting

#### Risk Assessment Report Structure
```
1. Executive Summary
   - Scope and objectives
   - Key findings summary
   - Risk overview
   - Critical recommendations

2. Methodology
   - Approach used
   - Tools and techniques
   - Limitations

3. Findings
   - Detailed risk descriptions
   - Evidence and observations
   - Impact and likelihood
   - Risk ratings

4. Recommendations
   - Prioritized controls
   - Implementation guidance
   - Resource requirements
   - Timeline

5. Appendices
   - Detailed technical findings
   - Interview notes
   - Supporting documentation
```

## SA Methodology

### Audit Scope

#### Annex C Audit Areas
1. Firewall
2. Internal Network
3. External Network
4. Host Security
5. Internet Security
6. Remote Access
7. Wireless Communication
8. Phone Line/Telecom
9. Web/Mobile Application
10. Security Policies & Procedures

### Audit Procedures

#### For Each Audit Area
```
1. Review Objectives
   - Identify control objectives
   - Map to S17/G3 requirements

2. Gather Evidence
   - Configuration review
   - Documentation review
   - Technical testing
   - Interviews

3. Assess Compliance
   - Compare against requirements
   - Identify gaps
   - Evaluate compensating controls

4. Document Findings
   - Observation
   - Evidence
   - Risk rating
   - Recommendation
```

### Audit Evidence

#### Types of Evidence
```
Documentary:
- Policies and procedures
- Configuration documentation
- Logs and reports
- Contracts and agreements

Technical:
- Configuration screenshots
- Scan results
- Test outputs
- System settings

Testimonial:
- Interview records
- Signed statements
- Meeting notes

Physical:
- Photographs
- Physical inspection records
```

#### Evidence Requirements
- Sufficient: Enough to support conclusion
- Reliable: From trustworthy source
- Relevant: Directly related to finding
- Properly preserved: Maintained for future reference

## Deliverables

### Assessment Report
- Executive summary for management
- Detailed technical findings
- Risk ratings with justification
- Prioritized recommendations
- Evidence references

### Risk Register
- Identified risks with ratings
- Control recommendations
- Assigned owners
- Target remediation dates
- Status tracking

### Remediation Roadmap
- Prioritized action items
- Resource requirements
- Timeline
- Dependencies
- Success criteria

## Follow-Up Activities

### Tracking
- Regular progress reviews
- Status updates to management
- Risk register updates
- Re-assessment scheduling

### Verification
- Control implementation testing
- Effectiveness validation
- Residual risk assessment
- Documentation of closure
