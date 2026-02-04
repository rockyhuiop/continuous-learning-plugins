# Annex C: Complete Audit Areas Checklist

Detailed audit checklists for each of the ten SRAA Annex C security domains.

## 1. Firewall Audit

### Control Objectives
- Perimeter defense properly configured
- Traffic filtering appropriate
- Administrative access secured
- Logging and monitoring enabled

### Audit Checklist

#### Configuration Review
- [ ] Default deny policy in place
- [ ] Rules documented with business justification
- [ ] No "any-any" rules without justification
- [ ] Rules reviewed within last 6 months
- [ ] Unused rules identified and removed
- [ ] Temporary rules have expiry dates

#### Access Control
- [ ] Administrative access via secure channel (SSH/HTTPS)
- [ ] Default credentials changed
- [ ] Strong authentication for admin access
- [ ] Admin access logged
- [ ] Separate admin accounts per administrator

#### Logging
- [ ] Denied traffic logged
- [ ] Allowed traffic to critical systems logged
- [ ] Rule changes logged
- [ ] Admin access logged
- [ ] Logs sent to SIEM
- [ ] Log retention meets requirements (12 months)

#### High Availability
- [ ] Failover configuration tested
- [ ] Configuration synchronized
- [ ] Monitoring alerts configured

### Evidence Required
- Firewall rule export
- Configuration backup
- Admin access logs
- Change management records
- Rule review documentation

---

## 2. Internal Network Audit

### Control Objectives
- Network segmentation implemented
- Internal traffic controlled
- Unauthorized devices detected
- Monitoring in place

### Audit Checklist

#### Segmentation
- [ ] VLANs properly configured
- [ ] Inter-VLAN routing controlled
- [ ] Sensitive systems in separate segments
- [ ] Guest network isolated
- [ ] Management network separated

#### Access Control
- [ ] Port security enabled (MAC limiting)
- [ ] 802.1X implemented where appropriate
- [ ] Unused ports disabled
- [ ] DHCP snooping enabled
- [ ] ARP inspection enabled

#### Monitoring
- [ ] Network monitoring tools deployed
- [ ] Traffic analysis capabilities
- [ ] Anomaly detection in place
- [ ] Unauthorized device detection

#### Switch Security
- [ ] Firmware current
- [ ] Secure management protocols (SSH)
- [ ] Spanning tree protection
- [ ] BPDU guard enabled

### Evidence Required
- Network topology diagram
- VLAN configuration
- Switch configurations
- Port security settings
- Monitoring dashboard screenshots

---

## 3. External Network Audit

### Control Objectives
- External exposure minimized
- DMZ properly configured
- Internet connectivity secured
- Third-party connections controlled

### Audit Checklist

#### DMZ Configuration
- [ ] DMZ properly segmented
- [ ] Only required services exposed
- [ ] Backend systems not directly accessible
- [ ] Firewall rules between zones documented

#### External Exposure
- [ ] External IP addresses documented
- [ ] Exposed services justified
- [ ] SSL/TLS properly configured
- [ ] Public-facing systems hardened

#### Third-Party Connections
- [ ] VPN or dedicated links for partners
- [ ] Access limited to required resources
- [ ] Connection agreements in place
- [ ] Regular connection reviews

### Evidence Required
- External IP inventory
- DMZ architecture diagram
- SSL/TLS scan results
- Third-party connection documentation
- Penetration test results

---

## 4. Host Security Audit

### Control Objectives
- Systems properly hardened
- Patches applied timely
- Endpoint protection deployed
- Logging enabled

### Audit Checklist

#### Hardening
- [ ] Security baseline applied (CIS benchmark)
- [ ] Unnecessary services disabled
- [ ] Unused ports closed
- [ ] Host firewall enabled
- [ ] Secure boot configured

#### Patch Management
- [ ] Patch management process documented
- [ ] Critical patches within 14 days
- [ ] High patches within 30 days
- [ ] Patch compliance monitored
- [ ] Exceptions documented and approved

#### Endpoint Protection
- [ ] Anti-malware installed and updated
- [ ] Real-time protection enabled
- [ ] Regular scans configured
- [ ] EDR deployed (servers)
- [ ] Central management in place

#### Logging
- [ ] Security audit logging enabled
- [ ] Log forwarding to SIEM
- [ ] Privileged action logging
- [ ] Log integrity protection

### Evidence Required
- Hardening checklist completion
- Patch compliance report
- Endpoint protection status
- Sample server configurations
- Vulnerability scan results

---

## 5. Internet Security Audit

### Control Objectives
- Web traffic secured
- Email protected
- Content filtering implemented
- Data loss prevention enabled

### Audit Checklist

#### Web Security
- [ ] Web proxy/gateway deployed
- [ ] HTTPS inspection where appropriate
- [ ] Category-based filtering
- [ ] Malware scanning enabled
- [ ] SSL certificate validation

#### Email Security
- [ ] Email gateway security
- [ ] Spam filtering enabled
- [ ] Malware scanning on attachments
- [ ] SPF/DKIM/DMARC configured
- [ ] Email encryption available

#### Data Loss Prevention
- [ ] DLP policies defined
- [ ] Sensitive data patterns identified
- [ ] Blocking/alerting configured
- [ ] Regular policy review

### Evidence Required
- Web gateway configuration
- Email gateway settings
- DLP policy documentation
- Filtering reports
- Incident statistics

---

## 6. Remote Access Audit

### Control Objectives
- Secure remote access methods
- Strong authentication enforced
- Access appropriately logged
- Session security maintained

### Audit Checklist

#### VPN Configuration
- [ ] Strong encryption (AES-256)
- [ ] Modern protocols (IKEv2, WireGuard)
- [ ] Split tunneling disabled or controlled
- [ ] Idle timeout configured
- [ ] Certificate-based authentication

#### Authentication
- [ ] Multi-factor authentication required
- [ ] Strong password policy
- [ ] Account lockout enabled
- [ ] Session timeout appropriate

#### Access Control
- [ ] Access limited to required resources
- [ ] Network segmentation for remote users
- [ ] Just-in-time access where possible
- [ ] Regular access review

#### Monitoring
- [ ] All connections logged
- [ ] Session activity monitored
- [ ] Anomaly detection enabled
- [ ] Geographic restrictions if appropriate

### Evidence Required
- VPN configuration
- Authentication policy
- Access control rules
- Connection logs sample
- MFA enrollment status

---

## 7. Wireless Communication Audit

### Control Objectives
- Wireless networks secured
- Rogue access points detected
- Guest access controlled
- Wireless monitoring enabled

### Audit Checklist

#### Security Configuration
- [ ] WPA3 or WPA2-Enterprise
- [ ] Strong pre-shared keys (if PSK used)
- [ ] SSID not broadcasting sensitive names
- [ ] Client isolation where appropriate

#### Network Segmentation
- [ ] Corporate wireless on separate VLAN
- [ ] Guest wireless isolated
- [ ] IoT devices on dedicated network
- [ ] Inter-VLAN routing controlled

#### Detection
- [ ] Rogue AP detection enabled
- [ ] Wireless IDS deployed
- [ ] Regular wireless surveys
- [ ] Alert on unauthorized APs

#### Access Control
- [ ] 802.1X for corporate wireless
- [ ] Guest registration process
- [ ] MAC filtering (secondary control)
- [ ] Time-based access where appropriate

### Evidence Required
- Wireless configuration
- Rogue AP detection reports
- Network segmentation diagram
- Guest access procedures
- Recent wireless survey

---

## 8. Phone Line/Telecom Audit

### Control Objectives
- VoIP systems secured
- Traditional phone lines protected
- Call logging appropriate
- Toll fraud prevented

### Audit Checklist

#### VoIP Security
- [ ] VoIP on dedicated VLAN
- [ ] Signaling encrypted (TLS/SRTP)
- [ ] SIP trunk security
- [ ] Firmware current

#### Access Control
- [ ] Strong voicemail PINs
- [ ] Admin access secured
- [ ] Extension fraud prevention
- [ ] International calling controls

#### Monitoring
- [ ] Call detail records retained
- [ ] Anomaly detection for unusual patterns
- [ ] After-hours call monitoring
- [ ] Toll fraud alerts

### Evidence Required
- VoIP configuration
- Network segmentation
- CDR retention policy
- Security settings documentation
- Recent call pattern analysis

---

## 9. Web/Mobile Application Audit

### Control Objectives
- Applications secure from OWASP Top 10
- Authentication properly implemented
- Data protection in place
- Security testing performed

### Audit Checklist

#### OWASP Top 10 (2021)

**A01: Broken Access Control**
- [ ] Authorization checks on all requests
- [ ] No direct object references
- [ ] Principle of least privilege
- [ ] CORS properly configured

**A02: Cryptographic Failures**
- [ ] Sensitive data encrypted at rest
- [ ] Strong encryption algorithms
- [ ] Proper key management
- [ ] No secrets in code

**A03: Injection**
- [ ] Input validation implemented
- [ ] Parameterized queries used
- [ ] Output encoding for XSS prevention
- [ ] Command injection prevention

**A04: Insecure Design**
- [ ] Threat modeling performed
- [ ] Security requirements defined
- [ ] Secure design patterns used

**A05: Security Misconfiguration**
- [ ] Default credentials changed
- [ ] Error handling doesn't leak info
- [ ] Security headers implemented
- [ ] Unnecessary features disabled

**A06: Vulnerable Components**
- [ ] Dependency scanning in place
- [ ] Known vulnerabilities addressed
- [ ] Component inventory maintained
- [ ] Update process defined

**A07: Authentication Failures**
- [ ] Strong password policy
- [ ] MFA for sensitive operations
- [ ] Session management secure
- [ ] Account lockout implemented

**A08: Software and Data Integrity**
- [ ] Code signing where appropriate
- [ ] CI/CD pipeline secured
- [ ] Dependency integrity verified

**A09: Logging Failures**
- [ ] Security events logged
- [ ] Sensitive data not logged
- [ ] Log integrity protected
- [ ] Monitoring alerts configured

**A10: SSRF**
- [ ] URL validation implemented
- [ ] Allowlist for external calls
- [ ] Network segmentation

#### Mobile-Specific
- [ ] Certificate pinning
- [ ] Secure local storage
- [ ] Jailbreak/root detection
- [ ] Code obfuscation

### Evidence Required
- SAST scan results
- DAST scan results
- Penetration test report
- Security code review findings
- Dependency scan output

---

## 10. Security Policy, Guidelines & Procedures Audit

### Control Objectives
- Policies documented and approved
- Procedures implemented
- Staff awareness maintained
- Documentation current

### Audit Checklist

#### Policy Documentation
- [ ] Information security policy
- [ ] Acceptable use policy
- [ ] Access control policy
- [ ] Incident response policy
- [ ] Business continuity policy
- [ ] Data classification policy
- [ ] Third-party security policy

#### Procedures
- [ ] User access management
- [ ] Change management
- [ ] Incident handling
- [ ] Backup and recovery
- [ ] Vulnerability management
- [ ] Security monitoring

#### Training and Awareness
- [ ] Security awareness training
- [ ] Training records maintained
- [ ] Role-specific training
- [ ] Phishing awareness

#### Governance
- [ ] Security committee meetings
- [ ] Policy review schedule
- [ ] Exception process documented
- [ ] Compliance monitoring

#### Change Management
- [ ] Formal change process
- [ ] Security impact assessment
- [ ] Testing requirements
- [ ] Rollback procedures
- [ ] Change records maintained

### Evidence Required
- Policy documents with approval signatures
- Training completion records
- Committee meeting minutes
- Change management records
- Procedure documentation

---

## Finding Severity Matrix

| Severity | Criteria |
|----------|----------|
| **Critical** | Immediate exploitation risk, no compensating controls, regulatory violation |
| **High** | Significant vulnerability, limited compensating controls, policy violation |
| **Medium** | Moderate risk, some compensating controls exist, deviation from best practice |
| **Low** | Minor issue, strong compensating controls, opportunity for improvement |

## Evidence Documentation Format

```markdown
### Evidence ID: [Domain]-[Number]

**Audit Area:** [Annex C Area]
**Control Reference:** [S17/G3 Control ID]
**Date Collected:** [YYYY-MM-DD]

**Description:**
[What evidence was collected]

**Source:**
[Where evidence came from - system, person, document]

**Location:**
[File path, screenshot reference, or document location]

**Observations:**
[Key observations from the evidence]
```
