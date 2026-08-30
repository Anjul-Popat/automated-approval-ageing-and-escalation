# Business Impact

## Overview

This project was designed to improve visibility, accountability, and response time for transactions delayed by pending approvals.

The primary objective was not to automate the approval decision itself. Instead, the automation focused on reducing delays caused by approvals that remained pending without timely follow-up.

The solution introduced automated monitoring, notification, and progressive escalation to help ensure that pending approvals received attention at the appropriate time.

---

## Before the Automation

Before implementation, monitoring the approval pipeline required manual effort.

The process typically involved:

```text
Check ERP System
       ↓
Identify Pending Approvals
       ↓
Check Current Approval Stage
       ↓
Identify Responsible Approver
       ↓
Check Approval Ageing
       ↓
Manual Follow-Up
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

This approach created several operational challenges:

- Pending approvals could remain unnoticed.
- Delays were identified only when someone checked the system.
- Employees had limited visibility into their own pending actions.
- Support teams spent time on repetitive monitoring and follow-up.
- Escalation depended on manual intervention.
- Bottlenecks could affect downstream processes.
- Delayed approvals could accumulate without immediate visibility.

The main issue was not necessarily the availability of data.

The issue was that the information required continuous manual monitoring and interpretation.

---

## After the Automation

The solution changed the process from manual monitoring to automated exception management.

```text
Monitor Approval Pipeline
          ↓
Identify Pending Approval
          ↓
Calculate Approval Ageing
          ↓
Identify Responsible User
          ↓
Send Automated Notification
          ↓
Still Pending?
     │              │
    No             Yes
     │              │
     ▼              ▼
Continue       Escalate Automatically
Monitoring             ↓
                    Manager
                       ↓
                Still Pending?
                   │      │
                  No     Yes
                   │      │
                   ▼      ▼
               Continue   VP / Director
               Monitoring
```

The system automatically brought delayed approvals to the attention of the appropriate people.

This reduced dependency on someone manually monitoring the ERP system.

---

## Operational Improvements

### Improved Visibility

Users received visibility into:

- Pending approvals requiring their action
- Current approval stage
- Approval ageing
- Delayed transactions
- Escalations requiring attention

Instead of expecting users to remember or repeatedly check the ERP system, the relevant information was delivered automatically.

---

### Increased Accountability

The escalation mechanism created a clear progression:

```text
Responsible Approver
        ↓
      Manager
        ↓
   VP / Director
```

If an approval remained pending, the system increased visibility through the organizational hierarchy.

This helped ensure that unresolved delays were not dependent on repeated manual follow-up.

---

### Faster Identification of Bottlenecks

The automation made it easier to identify where transactions were waiting.

For example:

```text
Transaction
      ↓
Approval Stage A   ✓ Completed
      ↓
Approval Stage B   ✓ Completed
      ↓
Approval Stage C   ⏳ Pending
      ↓
Downstream Process ⛔ Waiting
```

This provided visibility into the specific approval stage causing the bottleneck.

---

### Reduced Repetitive Monitoring

Before automation:

```text
Person checks system
        ↓
Finds pending approval
        ↓
Sends reminder
        ↓
Checks system again
        ↓
Escalates manually
```

After automation:

```text
System monitors
        ↓
System identifies delay
        ↓
System sends notification
        ↓
System escalates if required
```

Human effort could therefore focus more on resolving exceptions and making business decisions rather than repeatedly checking the status of transactions.

---

## Broader Business Outcome

Following implementation, the client reported an overall year-on-year business impact of approximately:

# ₹30 Lakh Per Annum

This figure was shared as a broader business outcome observed after the implementation period.

However, it is important to interpret this result correctly.

The ₹30 lakh figure is **not presented as savings generated solely by this approval automation**.

Business outcomes can be influenced by multiple factors, including:

- Process improvements
- Changes in transaction volumes
- Procurement efficiency
- Operational improvements
- Vendor performance
- Material availability
- Cost management initiatives
- Other automation initiatives
- Broader organizational changes

The approval automation should therefore be viewed as one contributing process-improvement initiative within the broader operational environment.

---

## Contribution of This Automation

While the overall financial impact cannot be attributed exclusively to this solution, the automation contributed through several measurable process improvements.

```text
Improved Visibility
        ↓
Faster Identification of Delays
        ↓
Reduced Approval Ageing
        ↓
Fewer Hidden Bottlenecks
        ↓
Faster Process Continuation
```

Its primary contribution was to improve the control and responsiveness of the approval workflow.

The automation helped ensure that delayed approvals:

- Became visible sooner
- Reached the responsible user automatically
- Were escalated when required
- Received management attention if unresolved
- Were less likely to remain hidden in the workflow

---

## Lean Perspective

The project applies an important Lean principle:

> **Do not spend human effort continuously searching for problems that a system can identify automatically.**

The previous process required repeated human activity to identify whether an exception existed.

The improved process reversed this model:

```text
Before:
Human Monitors Everything
        ↓
Find Exception

After:
System Monitors Everything
        ↓
Human Focuses on Exception
```

This is an example of **exception-based management**.

---

## Waste Reduction

The solution primarily targeted process waste associated with:

### Waiting

Downstream activities could not begin until required approvals were completed.

### Motion

Users repeatedly navigated through the ERP system to check approval status.

### Overprocessing

Support teams performed repeated monitoring and follow-up activities.

### Delayed Information

Responsible users and managers did not always have immediate visibility into ageing approvals.

The automation reduced these inefficiencies by making delayed approvals visible automatically.

---

## Key Value Delivered

The main value of the solution can be summarized as:

```text
Manual Monitoring
        ↓
Automated Monitoring

Hidden Delays
        ↓
Visible Exceptions

Manual Follow-Up
        ↓
Automated Notification

Manual Escalation
        ↓
SLA-Based Escalation

Reactive Response
        ↓
Proactive Attention
```

---

## Important Measurement Principle

When evaluating automation projects, it is important to distinguish between:

### Directly Attributable Benefits

Benefits that can be directly measured and linked to the automation, such as:

- Manual hours reduced
- Number of reminders automated
- Escalations automated
- Reduction in approval ageing

### Broader Business Outcomes

Benefits that may be influenced by multiple factors, such as:

- Annual financial savings
- Procurement efficiency
- Operational throughput
- Reduced production delays

This distinction helps ensure that business benefits are communicated accurately and credibly.

---

## Conclusion

The automation transformed approval monitoring from a repetitive manual activity into a proactive exception-management process.

The core transformation was:

```text
Manual Checking
      ↓
Automated Monitoring
      ↓
Proactive Notification
      ↓
Automatic Escalation
      ↓
Improved Accountability
      ↓
Reduced Approval Bottlenecks
```

The reported ₹30 lakh year-on-year business impact should be viewed as a broader organizational outcome following the implementation period, rather than a benefit attributable solely to this automation.

The direct value of the solution lies in:

- Improved approval visibility
- Reduced manual monitoring
- Faster identification of bottlenecks
- Automated follow-up
- Progressive escalation
- Increased accountability
- Better support for downstream business processes
