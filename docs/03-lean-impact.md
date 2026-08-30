# Lean Impact and Business Value

## Overview

This project was designed around a simple operational problem: a business process can only move as fast as its slowest required approval.

In a multi-stage approval workflow, a transaction may pass through several responsible individuals before the next business activity can begin. If one approval is delayed, the downstream process can remain blocked.

The solution introduces automated monitoring, ageing analysis, notification, and escalation to reduce the time approvals remain unattended.

---

## The Problem

The approval process involved multiple sequential stages.

A simplified workflow:

```text
Order Approval
      ↓
BOM Approval
      ↓
Supplier Approval
      ↓
Inbound Logistics Approval
      ↓
Material Approval
      ↓
Quality / Gate Check
      ↓
Process Approval
```

The next stage could not begin until the current approval was completed.

A delay by one responsible person could therefore create a bottleneck for the entire downstream workflow.

---

## Before Automation

The operational process depended heavily on manual monitoring.

```text
Check System
     ↓
Identify Pending Transactions
     ↓
Identify Approval Stage
     ↓
Identify Responsible User
     ↓
Check Approval Ageing
     ↓
Send Follow-Up
     ↓
Wait
     ↓
Check Again
     ↓
Identify Manager
     ↓
Manual Escalation
     ↓
Repeat
```

This approach had several weaknesses:

- Pending approvals could remain unnoticed
- Users had limited visibility of ageing tasks
- Manual checking consumed operational time
- Follow-ups depended on individual initiative
- Escalations could happen late
- Bottlenecks were discovered after they had already affected the process

---

## After Automation

The solution converted the process into an automated monitoring and escalation workflow.

```text
Monitor Approval Pipeline
          ↓
Identify Pending Approval
          ↓
Calculate Ageing
          ↓
Notify Responsible User
          ↓
Approval Completed?
     │              │
    Yes             No
     │              │
     ▼              ▼
Continue       SLA Breached?
Monitoring      │        │
                No       Yes
                │         │
                ▼         ▼
             Monitor   Escalate
                           │
                           ▼
                        Manager
                           │
                           ▼
                    Still Pending?
                       │       │
                      No      Yes
                       │       │
                       ▼       ▼
                    Continue  Further
                             Escalation
                                 │
                                 ▼
                            VP / Director
```

---

## Lean Waste Addressed

### 1. Waiting

The primary issue was waiting.

Transactions could not move forward until required approvals were completed.

The solution improved visibility of delayed approvals and introduced time-based escalation.

---

### 2. Overprocessing

Manual monitoring required repeated checks of the same approval information.

The system now performs this analysis automatically through scheduled SQL Server and SSRS processing.

---

### 3. Motion

Operational resources previously needed to:

- Check multiple pending transactions
- Identify responsible users
- Follow up with approvers
- Contact managers
- Track unresolved approvals

Automated notifications and escalation reduced this repetitive coordination effort.

---

### 4. Hidden Bottlenecks

Without systematic monitoring, an approval could remain pending without wider visibility.

The ageing logic turns hidden delays into visible exceptions.

---

### 5. Human Dependency

The manual process depended on someone actively checking the system and deciding when to follow up.

The automated workflow standardizes this process based on defined ageing and escalation rules.

---

## From Monitoring to Exception Management

The operating model changed from:

> **Monitor everything manually**

to:

> **Monitor automatically and focus on exceptions**

This is the central Lean principle behind the solution.

Routine monitoring is automated.

Human attention is directed toward approvals that require action.

---

## Key Improvements

The automated solution provides:

- Improved visibility of pending approvals
- Clear ownership of pending tasks
- Automated reminders to responsible users
- SLA-based escalation
- Reduced manual follow-up
- Increased accountability
- Faster visibility of workflow bottlenecks
- More consistent escalation decisions

---

## Business Outcome

The client reported a positive overall year-on-year business impact following the implementation period.

The reported overall impact was approximately:

# ₹30 Lakh

This figure represents a broader business outcome and may have been influenced by multiple operational and business factors.

Therefore, it should not be interpreted as savings generated solely by this automation.

The direct contribution of this solution was focused on:

- Reducing approval-related delays
- Improving visibility
- Increasing accountability
- Accelerating escalation
- Reducing manual follow-up
- Supporting smoother movement through the approval pipeline

---

## Key Lean Principle

> **Automation should not automate waste.**
>
> It should eliminate unnecessary monitoring and allow people to focus on exceptions that require human judgment.

This solution uses automation to monitor the approval pipeline continuously while preserving human decision-making for the approvals themselves.

---

## Conclusion

The solution demonstrates how SQL Server and SSRS can be used not only for reporting but also as a lightweight process-monitoring and escalation framework.

The transformation can be summarized as:

```text
Manual Monitoring
       ↓
Automated Visibility
       ↓
Proactive Notification
       ↓
SLA-Based Escalation
       ↓
Exception-Based Management
```

The goal is not simply to send automated emails.

The real objective is to prevent delayed approvals from becoming invisible bottlenecks in a larger business process.
