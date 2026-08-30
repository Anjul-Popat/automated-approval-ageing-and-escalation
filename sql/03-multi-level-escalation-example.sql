/*
===============================================================================
Automated Approval Ageing & Escalation System
===============================================================================

Purpose:
Generic example demonstrating multi-level escalation for approvals that
remain pending beyond defined escalation thresholds.

The schema and table names are fictional and do not represent an actual
company database or ERP system.

Example escalation flow:

Pending Approval
        │
        ▼
Initial Reminder
        │
        ▼
First SLA Threshold Breached?
        │
        ▼
Escalate to Manager
        │
        ▼
Still Pending Beyond Next Threshold?
        │
        ▼
Escalate to Senior Management

===============================================================================
*/

WITH ApprovalEscalation AS
(
    SELECT
        T.TransactionID,
        T.TransactionNumber,
        T.CurrentApprovalStage,
        T.CurrentApproverID,

        E.EmployeeName AS CurrentApprover,
        E.EmailAddress AS ApproverEmail,

        M.EmployeeID AS ManagerID,
        M.EmployeeName AS ManagerName,
        M.EmailAddress AS ManagerEmail,

        SM.EmployeeID AS SeniorManagerID,
        SM.EmployeeName AS SeniorManagerName,
        SM.EmailAddress AS SeniorManagerEmail,

        T.ApprovalRequestedDate,

        DATEDIFF
        (
            HOUR,
            T.ApprovalRequestedDate,
            GETDATE()
        ) AS PendingHours,

        S.SLAHours AS InitialSLAHours,

        CASE
            WHEN DATEDIFF
            (
                HOUR,
                T.ApprovalRequestedDate,
                GETDATE()
            ) >= S.SecondEscalationHours
                THEN 'Escalate to Senior Management'

            WHEN DATEDIFF
            (
                HOUR,
                T.ApprovalRequestedDate,
                GETDATE()
            ) >= S.FirstEscalationHours
                THEN 'Escalate to Manager'

            WHEN DATEDIFF
            (
                HOUR,
                T.ApprovalRequestedDate,
                GETDATE()
            ) >= S.SLAHours
                THEN 'Reminder / SLA Breached'

            ELSE 'Within SLA'
        END AS EscalationAction

    FROM dbo.ApprovalTransactions AS T

    LEFT JOIN dbo.Employees AS E
        ON T.CurrentApproverID = E.EmployeeID

    LEFT JOIN dbo.Employees AS M
        ON E.ManagerID = M.EmployeeID

    LEFT JOIN dbo.Employees AS SM
        ON M.ManagerID = SM.EmployeeID

    LEFT JOIN dbo.ApprovalStages AS S
        ON T.CurrentApprovalStage = S.StageName

    WHERE T.ApprovalStatus = 'Pending'
)

SELECT
    TransactionID,
    TransactionNumber,
    CurrentApprovalStage,
    CurrentApprover,
    ApproverEmail,

    ManagerName,
    ManagerEmail,

    SeniorManagerName,
    SeniorManagerEmail,

    ApprovalRequestedDate,
    PendingHours,
    InitialSLAHours,
    EscalationAction

FROM ApprovalEscalation

ORDER BY
    PendingHours DESC;
