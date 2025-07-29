# 🔐 Azure Security Hygiene & Automation Framework

This project is a modular and scalable Azure security automation and monitoring framework designed to help organizations proactively identify misconfigurations, reduce privilege risk, and detect suspicious or non-compliant activity across their Azure tenant.

It uses a combination of:
- PowerShell scripts (for proactive checks)
- Microsoft Graph API (for identity and role data)
- KQL detections in Microsoft Sentinel / Log Analytics (for log-based alerting)
- Optional integrations with Teams, email, or ticketing systems

---

## 📌 Goals

- Enforce identity and credential hygiene (e.g., expiring secrets, password rotation)
- Monitor privileged account activity and usage
- Alert on behavioral anomalies (e.g., account lockouts)
- Log resource changes to support audit and insider threat detection
- Provide a low-cost, extensible alternative to commercial CSPM tools

---

## 🧩 Modules

### 🔹 PowerShell-Based Checks

| Script | Description |
|--------|-------------|
| `Get-AppRegSecretExpirationReport.ps1` | Detects Azure App Registrations with secrets or certificates expiring within 30 days. |
| `Get-UsersPWReport.ps1` | Identifies Entra ID users with passwords set to expire soon, supporting credential lifecycle enforcement. |
| `Get-GlobalAdminsReport.ps1` | Flags Global Admins who haven’t logged in for 90+ days to reduce privilege creep and stale access. |

### 🔹 KQL-Based Detections (Microsoft Sentinel / Log Analytics)

| Detection | Description |
|-----------|-------------|
| `user-lockout-detection.kql` | Detects user account lockouts (e.g., ResultType 50053) in sign-in logs — useful for brute-force and MFA troubleshooting alerts. |
| `resource-creation-audit.kql` | Monitors and logs all Azure resource creation events, capturing who created what, when, and where — valuable for auditing and insider threat review. |

---

## 🛠 Technologies Used

- **Azure PowerShell**
- **Microsoft Graph API**
- **Azure Resource Graph**
- **Microsoft Sentinel (KQL)**
- **Azure Monitor & Log Analytics**
- **Azure Automation / Logic Apps**
- **Optional**: Power Automate, Teams Webhooks, SendGrid, ServiceNow API

---

## 📈 Deployment Options

- Run PowerShell scripts via:
  - Azure Automation (Scheduled Runbooks)
  - Local/Cloud-hosted task scheduler
- Deploy KQL queries as:
  - Sentinel Analytics Rules (scheduled or near-real-time)
  - Workbooks or custom dashboards
- Alerts can trigger emails, Teams/Slack webhooks, or tickets

---

## 🧪 Future Improvements

- Baseline-based drift detection for privileged role assignments
- Automatic remediation or approval workflows for stale resources
- Integration with GitHub Actions for secure DevOps pipelines
- Workbook dashboard for executive-level summaries

---

## 📂 Folder Structure

