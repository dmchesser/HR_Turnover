
--SELECT * FROM dbo.tbHR_TurnoverEmpList
--WHERE FacilityID='SRHC'
--  AND YEAR(HireDate)=2023
--  AND MONTH(HireDate)=5
--  AND TotHrs<>0

SELECT
	s.SortID,
	s.FacilityID,
	CAST(LEFT(s.Stat,3)+'01'+SUBSTRING(s.Stat,3,3) AS Date) Month,
	s.Total NewHires,
	a.Total Terminations
FROM dbo.tbHR_Turnover365DayStats s
 INNER JOIN (
	SELECT
		SortID,
		Stat,
		Total
	FROM dbo.tbHR_Turnover365DayStats
	WHERE FacilityID='SRHC'
	  AND Stat LIKE '%Term%'
		) a ON s.SortID=a.SortID-1
WHERE s.FacilityID='SRHC'
  AND s.Stat LIKE '%New Hires'
ORDER BY s.SortID
