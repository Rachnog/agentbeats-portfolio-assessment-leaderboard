-- Portfolio Performance by Goal Type
-- ====================================
-- Rankings split by goal type (retirement, house, college)

SELECT
    scenario.goal_type AS "Goal Type",
    results.participants.portfolio_constructor AS "Agent",
    ROUND(scenario.probability_of_success, 1) AS "Success %",
    ROUND(scenario.diversification_score, 1) AS "Diversification",
    ROUND(scenario.risk_score, 1) AS "Risk",
    ROUND(scenario.return_score, 1) AS "Return",
    scenario.timeline_years AS "Years",
    scenario.starting_amount AS "Starting $",
    scenario.target_amount AS "Target $"
FROM results
CROSS JOIN UNNEST(results.results) AS r(res)
CROSS JOIN UNNEST(res.scenarios) AS s(scenario)
WHERE scenario.goal_type IS NOT NULL
ORDER BY scenario.goal_type, scenario.probability_of_success DESC;
