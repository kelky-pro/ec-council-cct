# CCT Module 01 -Threats and Vulnerabilities

## 1. Threats and Threat Sources

### What is a Threat?
A threat is an entity, event, or action that has the potential to harm an information system by exploiting a vulnerability.

**CIA impact:** Confidentiality, Integrity, Availability.

### Threat Sources

| Type | Definition | Example |
|---|---|---|
| Natural | Environmental events | Flood, earthquake, lightning |
| Intentional – Internal | Deliberate insider activity | Employee stealing data |
| Intentional – External | Deliberate external attack | Ransomware attack |
| Unintentional | Accidental human actions | Accidental data exposure |

## 2. Threat Actors / Agents

A threat actor is an individual or group responsible for conducting malicious activities.

### Types

| Actor | Definition | Example |
|---|---|---|
| Black Hat | Malicious hacker | Cybercriminal |
| White Hat | Authorized ethical hacker | Penetration tester |
| Gray Hat | Acts without authorization, not necessarily malicious | Unauthorized vulnerability discovery |
| Suicide Hacker | Willing to cause damage despite consequences | Destructive insider |
| Script Kiddie | Uses existing tools with limited knowledge | Automated exploit user |
| Hacktivist | Attacks for ideological or political reasons | Website defacement |

### Threat Actor Attributes

| Attribute | Meaning | Example |
|---|---|---|
| Origin | Where they operate from | Internal / External |
| Sophistication | Technical skill | Beginner / Advanced |
| Resources | Available funding and infrastructure | Botnets, custom malware |
| Motivation | Why they attack | Financial, political, espionage, revenge |

## 3. Threat Vectors

A threat vector is the method or path used to gain access to a target.

| Vector | Example |
|---|---|
| Phishing | Fake banking login email |
| USB | Infected removable drive |
| Malware | Trojan attachment |
| Exploitation | Attacking an unpatched server |
| Weak credentials | Password spraying |
| Remote access | Compromised RDP |
| Supply chain | Compromised software update |
| Social engineering | Impersonating IT support |


## 4. Malware

Malware (malicious software) is software or code designed to perform unauthorized or harmful activities.

### Malware Distribution

- Phishing emails and attachments.
- Malicious websites.
- USB devices.
- Pirated software.
- Exploited vulnerabilities.
- Compromised software updates.
- Network propagation.

### Components of Malware

| Component | Definition | Example |
|---|---|---|
| Exploit | Takes advantage of a vulnerability | Remote code execution |
| Dropper | Delivers or installs another payload | Malicious installer |
| Downloader | Retrieves additional malware | Downloads second-stage payload |
| Crypter | Conceals malware through encryption or transformation | Encrypted payload |
| Obfuscator | Makes code difficult to understand | Encoded JavaScript |
| Packer | Compresses or transforms executable code | Packed malware |
| Injector | Places code into another process | Process injection |
| Payload | Performs the intended malicious action | File encryption |
| Malicious code | Instructions performing harmful operations | Credential-stealing script |

### Types of Malware

| Type | Definition | Example |
|---|---|---|
| Trojan | Disguises itself as legitimate software | Theef RAT |
| Virus | Attaches to host files and replicates | File-infecting virus |
| Ransomware | Encrypts or locks data for extortion | WannaCry |
| Worm | Self-replicates and spreads | Conficker |
| Rootkit | Conceals malicious activity | Kernel rootkit |
| PUA | Potentially unwanted application | Unwanted software bundle |
| Adware | Displays unwanted advertisements | Browser adware |
| Spyware | Secretly collects information | SpyAgent, Power Spy |
| Keylogger | Records keystrokes | Spyrix Keylogger |
| Botnet | Network of compromised devices under attacker control | Mirai |
| Fileless malware | Primarily uses memory and legitimate system tools | PowerShell abuse |

### Fileless Malware

**Why do attackers use it?**
- Stealth: Reduces conventional file-based detection opportunities.
- LOLBins: Abuses legitimate operating-system utilities.
- Trusted tools: Uses applications already present on the system.

Examples of LOLBins:

| Tool | Potential abuse |
|---|---|
| PowerShell | Malicious script execution |
| WMI | Remote execution |
| Certutil | Downloading or decoding files |
| Rundll32 | Executing malicious DLL functionality |
| MSHTA | Executing malicious scripts |

**Remember:** Fileless does not mean that no files or forensic artifacts exist.

### Real Malware Incidents

**WannaCry (2017) — Ransomware + Worm**

- Exploited Windows SMB vulnerabilities.
- Used EternalBlue.
- Encrypted files and demanded ransom.
- Disrupted healthcare and other organizations worldwide.

[WannaCry incident and screenshot – Microsoft](https://www.microsoft.com/en-us/security/blog/2017/05/12/wannacrypt-ransomware-worm-targets-out-of-date-systems/)

**Mirai (2016) — Botnet**

- Infected poorly secured IoT devices.
- Exploited weak/default credentials.
- Used compromised devices for DDoS attacks.
- Disrupted Dyn DNS infrastructure.

## 5. Vulnerabilities and Risk

### Vulnerability
A weakness in software, hardware, configuration, or procedures that can be exploited by a threat.

Examples:
- Unpatched software.
- Weak passwords.
- SQL injection.
- Misconfigured firewalls.

### Risk
The potential for loss or damage when a threat exploits a vulnerability.

**Simplified formula:**

`Risk = Likelihood × Impact`

### Difference

| Concept | Example |
|---|---|
| Threat | Cybercriminal |
| Threat vector | Exploitation |
| Vulnerability | Unpatched server |
| Exploit | Malicious exploit code |
| Risk | Potential data breach |
| Impact | Financial and reputational loss |

## 6. Types of Vulnerabilities

| Type | Definition | Example |
|---|---|---|
| Misconfiguration | Incorrect security settings | Publicly exposed database |
| Default configuration | Unchanged vendor settings | Default admin password |
| Application flaws | Weaknesses in software | SQL injection, XSS |
| Poor patch management | Failure to apply security updates | Unpatched Windows server |
| Design flaws | Insecure system architecture | Missing authorization checks |
| OS flaws | Operating-system weaknesses | Kernel privilege escalation |
| Zero-day | Vulnerability exploited before an effective patch is available | MOVEit CVE-2023-34362 |
| Legacy platforms | Outdated or unsupported technology | Unsupported Windows OS |
| System sprawl | Unmanaged or undocumented assets | Forgotten internet-facing server |
| Certificate/key management | Insecure handling of cryptographic keys | Exposed private key |
| Third-party risks | Weaknesses introduced by suppliers | Compromised software vendor |

### Real-World Incidents

**Equifax (2017) — Application Vulnerability**

- Attackers exploited Apache Struts CVE-2017-5638.
- Sensitive personal information was exposed.
- Demonstrated the importance of patch management.

**Capital One (2019) — Cloud Security**

- SSRF was used to obtain cloud credentials.
- Unauthorized access to stored data followed.
- Demonstrated the importance of IAM and cloud security.

**MOVEit (2023) — Zero-Day**

- SQL injection vulnerability in MOVEit Transfer.
- Attackers exploited CVE-2023-34362.
- Data theft affected numerous organizations.

**SolarWinds (2020) — Third-Party Risk**

- Attackers compromised a software supply chain.
- Malicious code was distributed through trusted updates.
- Demonstrated supply-chain security risks.

When investigating an incident, ask:

1. **Who?** — Threat actor.
2. **Where from?** — Threat source.
3. **How?** — Threat vector.
4. **What?** — Malware or attack technique.
5. **Which weakness?** — Vulnerability.
6. **What happened?** — Impact.
7. **How serious?** — Risk.
---
