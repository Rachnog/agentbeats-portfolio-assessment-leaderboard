-- Performance by Timeline
-- ========================
-- Compare portfolio performance across different time horizons

SELECT
    CASE
        WHEN s.timeline_years <= 10 THEN 'Short-term (≤10 years)'
        WHEN s.timeline_years <= 20 THEN 'Medium-term (11-20 years)'
        ELSE 'Long-term (>20 years)'
    END AS "Timeline",
    results.participants.portfolio_constructor AS "Agent",
    s.goal_type AS "Goal",
    s.timeline_years AS "Years",
    ROUND(s.probability_of_success, 1) AS "Success %",
    ROUND(s.risk_score, 1) AS "Risk",
    ROUND(s.return_score, 1) AS "Return"
FROM results
CROSS JOIN UNNEST(results.detail.scenarios) AS scenario(s)
WHERE s.timeline_years IS NOT NULL
ORDER BY s.timeline_years, s.probability_of_success DESC;
