-- Portfolio Performance by Goal Type
-- ====================================
-- Rankings split by goal type (retirement, house, college)

SELECT
    s.goal_type AS "Goal Type",
    results.participants.portfolio_constructor AS "Agent",
    ROUND(s.probability_of_success, 1) AS "Success %",
    ROUND(s.diversification_score, 1) AS "Diversification",
    ROUND(s.risk_score, 1) AS "Risk",
    ROUND(s.return_score, 1) AS "Return",
    s.timeline_years AS "Years",
    s.starting_amount AS "Starting $",
    s.target_amount AS "Target $"
FROM results
CROSS JOIN UNNEST(results.detail.scenarios) AS scenario(s)
WHERE s.goal_type IS NOT NULL
ORDER BY s.goal_type, s.probability_of_success DESC;
