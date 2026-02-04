# G3 IT Security Guidelines

The G3 IT Security Guidelines provide detailed technical controls and best practices for implementing S17 requirements. Version 10.2 (April 2025).

## Security Management Framework

### Organizational Structure

#### Security Committee
- Chaired by senior management
- Reviews security posture quarterly
- Approves security investments
- Oversees incident response

#### IT Security Officer (ITSO) Responsibilities
- Day-to-day security operations
- Security awareness programs
- Incident coordination
- Compliance monitoring
- Vendor security assessment

#### Security Administrator Responsibilities
- System hardening
- Access management
- Log monitoring
- Patch deployment
- Configuration management

## Technical Security Controls

### Network Security

#### Firewall Configuration
```
Required Rules:
- Default deny all inbound
- Explicit allow rules documented
- Stateful packet inspection enabled
- Application-layer filtering for web traffic
- Regular rule review (quarterly minimum)

Logging Requirements:
- All denied connections
- All administrative access
- Rule changes
- Retention: 12 months minimum
```

#### Network Segmentation
```
Zones Required:
1. Internet/DMZ Zone
2. Internal Network Zone
3. Management Zone
4. Database/Backend Zone

Inter-zone Traffic:
- Explicit firewall rules between zones
- No direct Internet-to-internal access
- Jump servers for administrative access
```

#### Intrusion Detection/Prevention
```
Deployment:
- Network IDS at perimeter
- Host-based IDS on critical servers
- Signature updates: daily
- Custom rules for critical applications

Response:
- Automated alerting for critical signatures
- Integration with SIEM
- Documented response procedures
```

### Host Security

#### Server Hardening Checklist
```
Operating System:
[ ] Remove unnecessary services
[ ] Disable unused ports
[ ] Apply security baseline (CIS benchmark)
[ ] Enable host firewall
[ ] Configure secure boot

Authentication:
[ ] Disable local admin where possible
[ ] Enforce strong passwords
[ ] Enable account lockout
[ ] Configure MFA for administrative access

Logging:
[ ] Enable security audit logging
[ ] Configure log forwarding to SIEM
[ ] Enable process creation logging
[ ] Monitor privileged operations
```

#### Endpoint Protection
```
Required Components:
- Anti-malware with real-time scanning
- Host-based firewall
- Application whitelisting (high-security systems)
- Endpoint Detection and Response (EDR) for servers

Update Requirements:
- AV signatures: at least daily
- Security patches: within 14 days (critical)
- Security patches: within 30 days (high)
```

### Application Security

#### Web Application Controls
```
Input Validation:
- Whitelist validation preferred
- Parameterized queries mandatory
- Output encoding for all user data
- File upload restrictions

Authentication:
- Session timeout: 15 minutes inactive
- Secure session management
- MFA for sensitive operations
- Account lockout after 5 failures

HTTPS Configuration:
- TLS 1.2 minimum, TLS 1.3 preferred
- Strong cipher suites only
- HSTS enabled
- Certificate from trusted CA
```

#### API Security
```
Authentication:
- API keys with restricted scope
- OAuth 2.0 for user authorization
- JWT with short expiry
- Rate limiting implemented

Authorization:
- Resource-level authorization checks
- No direct object references
- Principle of least privilege

Logging:
- All API calls logged
- Include: timestamp, user, resource, action
- Sensitive data masked in logs
```

### Data Protection

#### Data Classification
| Level | Description | Controls |
|-------|-------------|----------|
| Public | No restrictions | Standard handling |
| Internal | Internal use only | Access controls, no public sharing |
| Confidential | Sensitive business data | Encryption, access logging, need-to-know |
| Restricted | Highly sensitive | Strong encryption, MFA, audit trails |

#### Encryption Requirements
```
At Rest:
- AES-256 for confidential/restricted data
- Full disk encryption for laptops
- Database encryption for sensitive fields
- Key management procedures documented

In Transit:
- TLS 1.2+ for all network traffic
- VPN for remote access
- Encrypted email for sensitive communications
- Certificate validation enforced
```

### Access Management

#### Identity Lifecycle
```
Provisioning:
1. Request with manager approval
2. Verify identity and employment
3. Assign minimum required access
4. Document in access management system
5. User acknowledgment of policies

Modification:
1. Request with manager approval
2. Verify business justification
3. Update access records
4. Notify user of changes

Deprovisioning:
1. HR notification of termination
2. Immediate disabling (within 4 hours for termination)
3. Access removal within 24 hours
4. Equipment recovery
5. Access records updated
```

#### Privileged Access Management
```
Controls:
- Separate privileged accounts from daily-use accounts
- Just-in-time access where possible
- Privileged access workstations for administration
- Session recording for critical systems
- Regular review of privileged users (quarterly)

Monitoring:
- All privileged actions logged
- Real-time alerting for anomalies
- Regular review of privileged activity
```

### Logging and Monitoring

#### Required Log Sources
```
Critical:
- Authentication systems
- Firewalls and network devices
- Web servers and applications
- Database servers
- Privileged access systems

Standard:
- Endpoints (security events)
- Email systems
- File servers
- DNS servers
```

#### Log Retention
| Log Type | Retention Period |
|----------|------------------|
| Security events | 12 months minimum |
| Authentication | 12 months minimum |
| Administrative actions | 36 months |
| Transaction logs | Per regulatory requirement |
| Application logs | 6 months minimum |

#### SIEM Requirements
```
Capabilities:
- Log aggregation from all sources
- Real-time correlation
- Automated alerting
- Dashboard and reporting
- Incident investigation tools

Alerts Required:
- Multiple failed authentications
- Privilege escalation attempts
- Malware detection
- Data exfiltration indicators
- After-hours access to sensitive systems
```

## Incident Response

### Incident Classification
| Category | Description | Response Time |
|----------|-------------|---------------|
| Critical | Active breach, data loss imminent | Immediate (within 1 hour) |
| High | Significant threat detected | Within 4 hours |
| Medium | Security event requiring investigation | Within 24 hours |
| Low | Minor issue, no immediate threat | Within 1 week |

### Response Procedures
```
1. Detection and Reporting
   - Identify incident indicators
   - Report to ITSO immediately
   - Initial severity assessment

2. Containment
   - Isolate affected systems
   - Preserve evidence
   - Prevent further damage

3. Investigation
   - Determine scope and impact
   - Identify root cause
   - Document findings

4. Remediation
   - Remove threat
   - Patch vulnerabilities
   - Restore services

5. Recovery
   - Verify system integrity
   - Monitor for recurrence
   - Return to normal operations

6. Post-Incident
   - Lessons learned review
   - Update procedures
   - Report to management
```

## Compliance Verification

### Self-Assessment Checklist
Quarterly self-assessment against:
- [ ] S17 baseline controls
- [ ] G3 technical guidelines
- [ ] Policy compliance
- [ ] Training completion

### External Assessment
Annual independent assessment covering:
- Vulnerability assessment
- Penetration testing
- Configuration review
- Policy review
- Incident response testing
