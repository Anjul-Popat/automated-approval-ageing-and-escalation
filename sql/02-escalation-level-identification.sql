/*
===============================================================================
Automated Approval Ageing & Escalation System
===============================================================================

Purpose:
Generic example demonstrating how an overdue approval can be mapped to the
appropriate escalation recipient based on the employee reporting hierarchy.

The schema and table names are fictional and do not represent an actual
company database or ERP system.

Example escalation logic:

Pending Approval
        │
        ▼
Approval Ageing Calculated
        │
        ▼
Within SLA?
   │              │
  Yes             No
   │              │
   ▼              ▼
Monitor      Identify Manager
                    │
                    ▼
              Escalation Level
                    │
                    ▼
             Send Notification

===============================================================================
*/

WITH ApprovalAgeing AS
(
    SELECT
        T.TransactionID,
        T.TransactionNumber,
        T.CurrentApprovalStage,
        T.CurrentApproverID,
        E.EmployeeName AS CurrentApprover,
        E.ManagerID,
        M.EmployeeName AS ManagerName,
        M.EmailAddress AS ManagerEmail,
        T.ApprovalRequestedDate,

        DATEDIFF
        (
            HOUR,
            T.ApprovalRequestedDate,
            GETDATE()
        ) AS PendingHours,

        S.SLAHours,

        CASE
            WHEN DATEDIFF
            (
                HOUR,
                T.ApprovalRequestedDate,
                GETDATE()
            ) >= S.SLAHours
            THEN 'SLA Breached'

            ELSE 'Within SLA'
        END AS SLAStatus

    FROM dbo.ApprovalTransactions AS T

    LEFT JOIN dbo.Employees AS E
        ON T.CurrentApproverID = E.EmployeeID

    LEFT JOIN dbo.Employees AS M
        ON E.ManagerID = M.EmployeeID

    LEFT JOIN dbo.ApprovalStages AS S
        ON T.CurrentApprovalStage = S.StageName

    WHERE T.ApprovalStatus = 'Pending'
)

SELECT
    TransactionID,
    TransactionNumber,
    CurrentApprovalStage,
    CurrentApprover,
    ManagerName,
    ManagerEmail,
    ApprovalRequestedDate,
    PendingHours,
    SLAHours,
    SLAStatus,

    CASE
        WHEN SLAStatus = 'SLA Breached'
        THEN 'Escalate to Manager'

        ELSE 'No Escalation Required'
    END AS EscalationAction

FROM ApprovalAgeing

ORDER BY
    PendingHours DESC;
