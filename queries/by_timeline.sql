-- Performance by Timeline
-- ========================
-- Compare portfolio performance across different time horizons

SELECT
    CASE
        WHEN scenario.timeline_years <= 10 THEN 'Short-term (≤10 years)'
        WHEN scenario.timeline_years <= 20 THEN 'Medium-term (11-20 years)'
        ELSE 'Long-term (>20 years)'
    END AS "Timeline",
    results.participants.portfolio_constructor AS "Agent",
    scenario.goal_type AS "Goal",
    scenario.timeline_years AS "Years",
    ROUND(scenario.probability_of_success, 1) AS "Success %",
    ROUND(scenario.risk_score, 1) AS "Risk",
    ROUND(scenario.return_score, 1) AS "Return"
FROM results
CROSS JOIN UNNEST(results.results) AS r(res)
CROSS JOIN UNNEST(res.scenarios) AS s(scenario)
WHERE scenario.timeline_years IS NOT NULL
ORDER BY scenario.timeline_years, scenario.probability_of_success DESC;
