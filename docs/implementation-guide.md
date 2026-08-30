# Implementation Guide

## Overview

This guide explains the implementation approach for an automated approval reminder and escalation system.

The solution is designed to monitor business transactions that are pending approval, identify the responsible approver, calculate the ageing of pending approvals, and automatically escalate delayed actions through a predefined management hierarchy.

The implementation uses SQL Server and SQL Server Reporting Services (SSRS) while keeping the design generic and reusable across different ERP approval workflows.

---

## Business Problem

Many business processes depend on sequential approvals.

A typical workflow may involve approvals for:

- Orders
- Bills of Material
- Vendors
- Inbound logistics
- Materials
- Gate-level checks
- Random audits
- Process continuation

A delay at any approval stage can prevent the next activity from starting.

For example:

```text
Order Created
      ↓
Order Approval
      ↓
Procurement Initiated
      ↓
Bill of Material Approval
      ↓
Vendor Approval
      ↓
Inbound Logistics Approval
      ↓
Material Approval
      ↓
Gate / Audit Checks
      ↓
Process Continuation
```

If an approver does not take action, the entire downstream process can remain blocked.

The manual approach required users or support teams to regularly check:

- Which transactions were pending
- Which approval stage was pending
- How long the transaction had been waiting
- Who was responsible for the approval
- Who should receive an escalation
- Whether the responsible person's manager had responded
- Whether further escalation was required

This created unnecessary monitoring effort and limited visibility into approval bottlenecks.

---

## Solution Approach

The automated solution follows this cycle:

```text
Detect Pending Approval
          ↓
Calculate Approval Ageing
          ↓
Identify Responsible Approver
          ↓
Send Reminder
          ↓
Wait for Configured Timeframe
          ↓
Still Pending?
     ↙          ↘
   No            Yes
   ↓              ↓
Stop         Escalate to Manager
                     ↓
              Still Pending?
                 ↙      ↘
               No        Yes
               ↓          ↓
              Stop    Escalate Further
                         ↓
                    VP / Director
```

The objective is to automatically manage routine follow-up activities while providing visibility to the appropriate people at the appropriate time.

---

## Component 1: Pending Approval Identification

SQL Server queries are used to identify transactions that are currently pending approval.

The query logic should identify:

- Transaction or order identifier
- Current approval stage
- Pending status
- Responsible approver
- Approval request date
- Current ageing
- Manager or escalation contact
- Current escalation level

The actual source tables and views depend on the ERP implementation.

Because the underlying database structure may contain proprietary business information, the implementation pattern is represented conceptually.

Example:

```sql
SELECT
    Transaction_ID,
    Approval_Level,
    Responsible_User,
    Approval_Request_Date,
    Status
FROM Approval_Source
WHERE Status = 'Pending';
```

---

## Component 2: Approval Ageing Calculation

The system calculates how long a transaction has been waiting for approval.

A generic calculation can be:

```text
Current Date and Time
        -
Approval Request Date and Time
        =
Pending Approval Ageing
```

Example:

```sql
DATEDIFF(
    HOUR,
    Approval_Request_Date,
    GETDATE()
) AS Approval_Ageing_Hours
```

The ageing can also be calculated in:

- Minutes
- Hours
- Days
- Business hours
- Working days

The selected method should align with the organisation's escalation policy.

---

## Component 3: Responsible Approver Identification

Once a pending transaction is identified, the system determines who is currently responsible for taking action.

The responsible user can be derived from:

- Approval workflow tables
- User master data
- Role mappings
- Approval configuration tables
- ERP workflow metadata

The system associates each pending transaction with the relevant:

```text
Transaction
      ↓
Approval Level
      ↓
Responsible Approver
```

This ensures that reminders are sent directly to the person responsible for the next action.

---

## Component 4: Automated Reminder

An SSRS report is used to present pending approval information.

The report may contain:

- Transaction details
- Pending approval stage
- Responsible user
- Pending since date
- Current ageing
- Required action

An SSRS subscription automatically distributes the report to the responsible users.

Example:

```text
Subject:
Action Required: Pending Approvals

Email:
You have pending transactions requiring your approval.

Please review and approve or reject the pending items.

Transaction Details:
- Transaction ID
- Approval Stage
- Pending Since
- Current Ageing
```

This provides visibility without requiring users to manually check the ERP system for pending tasks.

---

## Component 5: First-Level Escalation

If an approval remains pending beyond the configured reminder timeframe, the system checks whether the transaction has already been actioned.

If it is still pending, the escalation process begins.

```text
Approval Still Pending
          ↓
Ageing Exceeds Threshold
          ↓
Identify Manager
          ↓
Send Escalation
```

The manager receives an automated notification.

The original approver can also be included in the email as a CC recipient.

Example:

```text
To: Approver Manager
CC: Responsible Approver

Subject:
Escalation: Pending Approval Requires Attention

The following approval has remained pending beyond
the configured timeframe.

Please review and take the required action.
```

This creates visibility at the next level of the organisation without requiring manual intervention.

---

## Component 6: Second-Level Escalation

If the approval continues to remain pending after the manager escalation period, the system performs a second escalation.

The escalation hierarchy can be:

```text
Approver
    ↓
Manager
    ↓
VP / Director
```

The second-level escalation is triggered only when:

- The transaction is still pending
- The configured escalation timeframe has passed
- The previous escalation has not resulted in action

Example:

```text
Approval Still Pending
          ↓
Manager Escalation Period Exceeded
          ↓
Identify VP / Director
          ↓
Send Escalation
```

This prevents approval bottlenecks from remaining unresolved indefinitely.

---

## Component 7: SSRS Subscriptions

SSRS subscriptions are used to automate the execution and delivery of approval monitoring reports.

The subscriptions can be configured to run:

- Daily
- Multiple times per day
- On specific working days
- At defined business hours

For example:

```text
Every Day
    ↓
Morning
    ↓
Run Approval Monitoring Report
    ↓
Identify Pending Approvals
    ↓
Send Reminder Emails
```

Separate subscriptions or report parameters can be used for different escalation levels.

---

## Component 8: Escalation Timing

The solution uses configurable timeframes to determine when an escalation should occur.

A conceptual example:

| Approval Status | Action |
|---|---|
| Newly Pending | Send reminder |
| Threshold 1 Exceeded | Escalate to Manager |
| Threshold 2 Exceeded | Escalate to VP / Director |

The actual thresholds can be configured based on business requirements.

Example:

```text
0 Hours
   ↓
Initial Reminder

Configured Timeframe
   ↓
Manager Escalation

Additional Timeframe
   ↓
VP / Director Escalation
```

This approach allows the organisation to change escalation policies without redesigning the overall solution.

---

## End-to-End Process

```text
Business Transaction Created
          ↓
Approval Required
          ↓
Approval Request Pending
          ↓
SQL Server Identifies Pending Item
          ↓
Calculate Approval Ageing
          ↓
Identify Responsible Approver
          ↓
SSRS Sends Reminder
          ↓
      Approval Action?
       ↙        ↘
     Yes         No
      ↓           ↓
   Process      Ageing
   Continues    Threshold
                   ↓
             Escalate to Manager
                   ↓
              Approval Action?
               ↙        ↘
             Yes         No
              ↓           ↓
           Process     Escalate to
           Continues   VP / Director
```

---

## Technology Architecture

| Component | Technology |
|---|---|
| Approval Data | ERP Database |
| Data Analysis | SQL Server |
| Pending Approval Detection | SQL Queries |
| Ageing Calculation | SQL Server |
| Approval Reporting | SSRS |
| Automated Delivery | SSRS Subscription |
| Reminder Notification | E-Mail |
| Escalation Logic | SQL Server / SSRS |
| Management Escalation | E-Mail |

---

## Design Principles

The solution follows several key principles.

### Exception-Based Monitoring

Users do not need to continuously monitor the ERP system.

The system identifies exceptions automatically.

```text
Manual:
Check → Find Pending → Follow Up

Automated:
Identify Pending → Notify → Escalate
```

---

### Progressive Escalation

Notifications are sent to the appropriate level based on the age of the pending approval.

```text
Approver
    ↓
Manager
    ↓
VP / Director
```

---

### Reduced Manual Intervention

The solution automates:

- Monitoring
- Ageing calculation
- User identification
- Reminder notifications
- Escalation notifications

Human involvement is required primarily for the actual business decision rather than routine follow-up.

---

### Improved Visibility

Users receive visibility into:

- Their pending approvals
- Approval ageing
- Bottlenecks in the workflow
- Escalations requiring attention

This helps ensure that pending approvals do not remain hidden in the workflow.

---

## Business Impact

The solution was implemented to reduce delays caused by pending approvals and limited visibility.

The automation:

- Improved visibility of pending tasks
- Reduced manual monitoring
- Created accountability for delayed approvals
- Automatically involved managers when required
- Enabled higher-level escalation for unresolved delays
- Helped reduce approval bottlenecks

The client reported an overall financial benefit after implementation compared with the previous year.

However, the reported business impact should be interpreted carefully.

The approval automation was one contributing initiative, and the overall benefit may also have been influenced by other operational and business factors.

The value of this solution was primarily in reducing approval delays, improving visibility, increasing accountability, and removing repetitive manual follow-up activities.

---

## Data Privacy and Repository Scope

This repository does not contain:

- Proprietary ERP table names
- Internal database schemas
- Client information
- Employee information
- Internal e-mail addresses
- Production SQL code
- Confidential business data

The implementation is documented as a reusable architectural pattern.

The SQL and workflow examples are intentionally generic.

---

## Reusable Pattern

This approach can be applied to many approval-based workflows, including:

- Purchase approvals
- Invoice approvals
- Vendor onboarding
- Contract approvals
- Material approvals
- Finance approvals
- Audit approvals
- Change requests
- Workflow bottlenecks

The core pattern remains:

```text
Detect
   ↓
Measure Ageing
   ↓
Notify
   ↓
Wait
   ↓
Recheck
   ↓
Escalate
   ↓
Repeat Until Resolved
```

The implementation can be adapted based on the approval hierarchy, escalation rules, and technologies available in the organisation.
