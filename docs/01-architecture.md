# Solution Architecture

## Overview

This solution is designed to monitor approval ageing across a multi-stage business workflow and automatically notify and escalate pending approvals based on defined ageing thresholds.

The objective is to reduce process bottlenecks caused by delayed approvals and eliminate the need for manual monitoring and follow-up.

The solution uses:

- SQL Server
- SQL Server tables and views
- SSRS reports and datasets
- SSRS subscriptions
- Approval ageing logic
- SLA-based escalation rules
- Organizational hierarchy mapping

The automated workflow follows:

**Monitor → Identify → Notify → Escalate → Continue Monitoring**

---

## Business Workflow Context

The solution is designed for business processes that require multiple sequential approvals before the next stage can begin.

A simplified workflow may look like:

```text
Order Created
     │
     ▼
Order Approval
     │
     ▼
BOM Approval
     │
     ▼
Supplier Approval
     │
     ▼
Inbound Logistics Approval
     │
     ▼
Material Approval
     │
     ▼
Quality / Gate Check
     │
     ▼
Process Approval
     │
     ▼
Next Business Process
```

A delay at any approval stage can prevent downstream activities from progressing.

---

## High-Level Architecture

```text
Business Transaction
        │
        ▼
Approval Workflow
        │
        ▼
SQL Server Tables / Views
        │
        ▼
Approval Ageing Analysis
        │
        ├──────────────────────────────┐
        ▼                              ▼
Within SLA                       SLA Breached
        │                              │
        ▼                              ▼
Continue Monitoring         Identify Current Owner
                                       │
                                       ▼
                               SSRS Notification
                                       │
                                       ▼
                          Approval Completed?
                              │          │
                             Yes         No
                              │          │
                              ▼          ▼
                       Continue Flow   Escalation
                                          │
                                          ▼
                                     Manager Alert
                                          │
                                          ▼
                                 Approval Completed?
                                     │          │
                                    Yes         No
                                     │          │
                                     ▼          ▼
                              Continue Flow  Further Escalation
                                                   │
                                                   ▼
                                             VP / Director
```

---

## Component 1: Approval Data Monitoring

The solution uses SQL Server tables and views to monitor transactions moving through the approval workflow.

The monitoring logic identifies:

- Transaction or order currently awaiting approval
- Current approval stage
- Pending approver
- Approval ageing
- Defined SLA
- Approval status
- Escalation eligibility

Internal company tables and business objects are intentionally represented generically in this public documentation.

---

## Component 2: Approval Ageing Analysis

The core logic calculates how long a transaction has remained pending at its current approval stage.

The analysis can compare:

- Current date and time
- Approval request date and time
- Time spent at the current approval level
- Configured SLA threshold

Conceptually:

```text
Approval Ageing

Current Time
     -
Approval Request Time
     =
Pending Duration
```

Transactions that exceed the defined SLA are identified as requiring additional attention or escalation.

---

## Component 3: Daily Pending Approval Notification

An SSRS report identifies pending approvals and groups them by the responsible approver.

An SSRS subscription distributes a daily notification to the relevant user.

The notification can include:

- Transaction reference
- Current approval stage
- Pending ageing
- SLA status
- Required action

This provides direct visibility of pending tasks without requiring users to manually check the ERP system.

---

## Component 4: SLA-Based Escalation

If an approval remains pending beyond the defined SLA, the system automatically applies the next escalation rule.

Example:

```text
Pending Approval
       │
       ▼
Initial Notification
       │
       ▼
Within SLA?
   │         │
  Yes        No
   │         │
   ▼         ▼
Monitor   Notify Manager
              │
              ▼
        Still Pending?
          │        │
         No       Yes
          │        │
          ▼        ▼
       Close    Escalate Further
                     │
                     ▼
                 VP / Director
```

This reduces dependency on manual follow-ups and ensures that unresolved approvals become visible at the appropriate management level.

---

## Component 5: Organizational Hierarchy

The escalation process uses organizational reporting relationships to determine the appropriate escalation recipient.

Conceptually:

```text
Pending Approver
       │
       ▼
Direct Manager
       │
       ▼
Next Escalation Level
       │
       ▼
Senior Management
```

The responsible user can remain copied in the escalation communication to maintain visibility and accountability.

---

## Component 6: SSRS-Based Automation

SSRS acts as the reporting and notification layer.

The solution uses:

- Datasets to retrieve approval and ageing information
- Report parameters where required
- SSRS subscriptions for scheduled delivery
- Email notifications for pending approvals
- Scheduled escalation communications

This allows the process to run automatically without requiring a custom application or separate workflow engine.

---

## End-to-End Process Flow

```text
Business Transaction Created
          │
          ▼
Transaction Enters Approval Workflow
          │
          ▼
Current Approval Owner Identified
          │
          ▼
Calculate Approval Ageing
          │
          ▼
      SLA Breached?
       │        │
      No       Yes
       │        │
       ▼        ▼
    Monitor   Notify Approver
                    │
                    ▼
              Approval Completed?
                 │        │
                Yes       No
                 │        │
                 ▼        ▼
             Continue   Escalate
                           │
                           ▼
                     Manager Alert
                           │
                           ▼
                    Still Pending?
                      │        │
                     No       Yes
                      │        │
                      ▼        ▼
                   Close    VP / Director
                              Escalation
```

---

## Technology Flow

| Component | Technology |
|---|---|
| Approval workflow data | SQL Server Tables / Views |
| Approval ageing | SQL Server |
| Pending approval analysis | SSRS Dataset |
| User notification | SSRS Subscription |
| SLA monitoring | SQL Query Logic |
| Escalation | SSRS Subscription / SQL Logic |
| Management hierarchy | SQL Server Views / Tables |
| Scheduled delivery | SSRS Subscription |

---

## Before and After Automation

### Before

```text
Check ERP System
        ↓
Identify Pending Approval
        ↓
Identify Responsible Person
        ↓
Check Ageing
        ↓
Manual Follow-Up
        ↓
Check Again
        ↓
Manual Escalation
        ↓
Repeat
```

### After

```text
Monitor Automatically
        ↓
Calculate Approval Ageing
        ↓
Notify Responsible User
        ↓
SLA Breach?
        ↓
Escalate Automatically
        ↓
Manager
        ↓
Further Escalation
        ↓
Continue Monitoring
```

---

## Design Principle

The solution converts a manually monitored approval workflow into an automated, exception-based process.

The focus is on ensuring that:

- Pending approvals are visible
- Ageing is continuously monitored
- Responsible users receive timely reminders
- Delays are escalated automatically
- Manual follow-up effort is reduced
- Approval bottlenecks do not remain hidden

The objective is not to replace human decision-making.

The objective is to automate **visibility, follow-up, monitoring, and escalation** so that approvals receive attention before they become major process bottlenecks.

---

## Lean Perspective

The solution applies Lean principles by reducing non-value-added activities associated with approval monitoring.

Key areas of improvement include:

- **Waiting** — reduced delays caused by unattended approvals
- **Overprocessing** — reduced repetitive checking of approval status
- **Motion** — reduced effort spent manually chasing approvers
- **Process visibility** — improved identification of bottlenecks
- **Standardization** — consistent SLA-based escalation
- **Human dependency** — reduced dependency on individuals to manually monitor pending tasks

The solution follows an exception-based operating model:

**Monitor Everything → Act on Delays → Escalate Exceptions Automatically**

---

## Business Outcome

The solution improved visibility of pending approvals and introduced a structured escalation mechanism for delayed actions.

Observed benefits included:

- Improved visibility of approval bottlenecks
- Reduced manual monitoring and follow-up
- Increased accountability for pending approvals
- Faster escalation of delayed tasks
- Improved workflow transparency

The client reported a broader year-on-year business impact of approximately **₹30 lakh** following the implementation period. This overall result may have been influenced by multiple operational and business factors and is not presented as savings attributable solely to this automation.
