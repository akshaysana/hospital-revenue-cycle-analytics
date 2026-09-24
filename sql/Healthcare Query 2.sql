SELECT
	SUM(f.[Billed Amount] - f.[Paid Amount]) AS Revenue_Leakage,
	p.[Insurance Type],
	d.[Reason Code]
FROM Fact_Claims AS f
LEFT JOIN Dim_Payer AS p
	ON f.PayerID = p.PayerID
LEFT JOIN Dim_Denial_Context AS d
	ON d.Denial_Context_ID = f.Denial_Context_ID
--WHERE p.[Insurance Type] = 'Medicare' AND d.[Reason Code] = 'Incorrect billing information';
GROUP BY p.[Insurance Type], d.[Reason Code]
HAVING p.[Insurance Type] = 'Medicare' AND d.[Reason Code] = 'Incorrect billing information';