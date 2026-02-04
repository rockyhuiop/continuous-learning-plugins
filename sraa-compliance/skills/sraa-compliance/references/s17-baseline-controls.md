# S17 Baseline IT Security Policy Controls

The S17 Baseline IT Security Policy defines mandatory minimum security requirements for protection of information systems and data assets. Version 8.2 (April 2025).

## Control Categories

### 1. Security Management

#### SM-1: Security Policy
- [ ] Documented information security policy approved by management
- [ ] Policy reviewed at least annually
- [ ] Policy communicated to all relevant personnel

#### SM-2: Security Organization
- [ ] Designated IT Security Officer (ITSO)
- [ ] Clear security roles and responsibilities
- [ ] Management commitment demonstrated

#### SM-3: Risk Management
- [ ] Regular risk assessments conducted
- [ ] Risk treatment plan documented
- [ ] Residual risks accepted by management

### 2. Asset Management

#### AM-1: Asset Inventory
- [ ] Complete inventory of IT assets
- [ ] Asset owners assigned
- [ ] Classification of information assets

#### AM-2: Media Handling
- [ ] Procedures for removable media
- [ ] Secure disposal of media
- [ ] Encryption of portable storage

### 3. Access Control

#### AC-1: Access Control Policy
- [ ] Documented access control policy
- [ ] Need-to-know principle enforced
- [ ] Regular access reviews

#### AC-2: User Management
- [ ] Formal user registration process
- [ ] Unique user IDs assigned
- [ ] Prompt removal of access on termination

#### AC-3: Authentication
- [ ] Strong password policy enforced
- [ ] Multi-factor authentication for sensitive systems
- [ ] Account lockout after failed attempts

#### AC-4: Privileged Access
- [ ] Privileged accounts separately managed
- [ ] Just-in-time privileged access where possible
- [ ] Privileged activity logging

### 4. Cryptography

#### CR-1: Encryption Policy
- [ ] Documented cryptographic policy
- [ ] Approved algorithms specified
- [ ] Key management procedures

#### CR-2: Key Management
- [ ] Secure key generation
- [ ] Key storage protection
- [ ] Key rotation procedures

### 5. Physical Security

#### PS-1: Secure Areas
- [ ] Physical perimeter security
- [ ] Access controls for secure areas
- [ ] Visitor management procedures

#### PS-2: Equipment Security
- [ ] Equipment siting and protection
- [ ] Supporting utilities (power, cooling)
- [ ] Cable security

### 6. Operations Security

#### OS-1: Documented Procedures
- [ ] Operating procedures documented
- [ ] Change management process
- [ ] Capacity management

#### OS-2: Malware Protection
- [ ] Anti-malware software deployed
- [ ] Regular signature updates
- [ ] User awareness of malware risks

#### OS-3: Backup
- [ ] Regular backups performed
- [ ] Backup testing conducted
- [ ] Off-site backup storage

#### OS-4: Logging and Monitoring
- [ ] Security event logging enabled
- [ ] Log protection measures
- [ ] Regular log review

#### OS-5: Vulnerability Management
- [ ] Regular vulnerability assessments
- [ ] Patch management process
- [ ] Penetration testing (annual minimum)

### 7. Communications Security

#### CS-1: Network Security
- [ ] Network segmentation implemented
- [ ] Firewall protection at boundaries
- [ ] Intrusion detection/prevention

#### CS-2: Data Transfer
- [ ] Encryption in transit
- [ ] Secure file transfer mechanisms
- [ ] Email security controls

### 8. System Acquisition and Development

#### SD-1: Security Requirements
- [ ] Security requirements in specifications
- [ ] Secure development practices
- [ ] Security testing before deployment

#### SD-2: Development Environment
- [ ] Separation of environments (dev/test/prod)
- [ ] Source code protection
- [ ] Change control for production

#### SD-3: Third-Party Software
- [ ] Vendor security assessment
- [ ] License compliance
- [ ] Support and update arrangements

### 9. Supplier Relationships

#### SR-1: Supplier Security
- [ ] Security requirements in contracts
- [ ] Regular supplier security reviews
- [ ] Right to audit provisions

#### SR-2: Supply Chain
- [ ] Supply chain risk assessment
- [ ] Secure delivery arrangements
- [ ] Component integrity verification

### 10. Incident Management

#### IM-1: Incident Response
- [ ] Incident response plan documented
- [ ] Incident reporting procedures
- [ ] Contact list maintained

#### IM-2: Incident Handling
- [ ] Evidence preservation procedures
- [ ] Escalation procedures
- [ ] Post-incident review

### 11. Business Continuity

#### BC-1: Continuity Planning
- [ ] Business continuity plan documented
- [ ] Recovery time objectives defined
- [ ] Regular plan testing

#### BC-2: Disaster Recovery
- [ ] IT disaster recovery plan
- [ ] Recovery site arrangements
- [ ] Annual DR testing

### 12. Compliance

#### CO-1: Legal Requirements
- [ ] Applicable laws identified
- [ ] Compliance monitoring
- [ ] Privacy requirements met

#### CO-2: Security Review
- [ ] Regular compliance audits
- [ ] Independent security assessments
- [ ] Remediation tracking

## Minimum Baseline Requirements

The following are **mandatory** for all systems:

1. **Authentication**: Minimum 8-character passwords, complexity enforced
2. **Session Timeout**: Maximum 15 minutes for sensitive systems
3. **Logging**: Authentication events, privileged actions, security events
4. **Encryption**: TLS 1.2+ for data in transit
5. **Patching**: Critical patches within 14 days
6. **Backup**: Daily incremental, weekly full, monthly off-site
7. **Access Review**: Quarterly for privileged accounts
8. **Incident Reporting**: Within 4 hours for critical incidents

## Control Reference Format

When citing S17 controls in findings:
```
S17-AC-3.2: Multi-factor authentication requirement
S17-OS-4.1: Security event logging
S17-CS-1.3: Firewall protection
```
