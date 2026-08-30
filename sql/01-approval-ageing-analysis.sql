/*
===============================================================================
Automated Approval Ageing & Escalation System
===============================================================================

Purpose:
This is a generic and fictional example demonstrating how approval ageing
can be analysed using SQL Server.

The schema and table names in this example do not represent an actual
company database or ERP system.

Example workflow:

Transaction
    ↓
Approval Request
    ↓
Approval Owner
    ↓
Approval Ageing Calculation
    ↓
SLA Evaluation
    ↓
Notification / Escalation

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

    LEFT JOIN dbo.ApprovalStages AS S
        ON T.CurrentApprovalStage = S.StageName

    WHERE T.ApprovalStatus = 'Pending'
)

SELECT
    TransactionID,
    TransactionNumber,
    CurrentApprovalStage,
    CurrentApprover,
    ApprovalRequestedDate,
    PendingHours,
    SLAHours,
    SLAStatus

FROM ApprovalAgeing

ORDER BY
    PendingHours DESC;
