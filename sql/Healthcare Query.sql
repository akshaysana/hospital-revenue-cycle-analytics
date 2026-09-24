--CREATE DATABASE Hospital_Revenue_Cycle;
--GO
--USE Hospital_Revenue_Cycle;
--GO

WITH Distincts AS (
	SELECT
		DISTINCT [Insurance Type]
	FROM raw_claim_data
)

SELECT
	ROW_NUMBER() OVER(ORDER BY [Insurance Type]) AS PayerID,
	[Insurance Type]
INTO Dim_Payer
FROM Distincts;

WITH Distincts2 AS (
	SELECT DISTINCT 
			[Claim Status],
			[Reason code],
			[AR Status],
			Outcome
	FROM raw_claim_data
)

SELECT
	ROW_NUMBER() OVER(ORDER BY [Claim Status]) AS Denial_Context_ID,
	[Claim Status],
	[Reason code],
	[AR Status],
	Outcome
INTO Dim_Denial_Context
FROM Distincts2;

SELECT
	r.[Claim ID],
	i.PayerID,
	d.Denial_Context_ID,
	CAST(r.[Date of Service] AS DATE) AS Date_of_Service,
	r.[Billed Amount],
	r.[Allowed Amount],
	r.[Paid Amount]
INTO Fact_Claims
FROM raw_claim_data AS r
LEFT JOIN Dim_Payer AS i
	ON r.[Insurance Type] = i.[Insurance Type]
LEFT JOIN Dim_Denial_Context AS d
	ON r.[Claim Status] = d.[Claim Status]
	AND r.[Reason code] = d.[Reason code]
	AND r.[AR Status] = d.[AR Status]
	AND r.Outcome = d.Outcome;