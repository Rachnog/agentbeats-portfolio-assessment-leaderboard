-- Conservative vs Aggressive Strategies
-- ========================================
-- Compare portfolios by risk profile

SELECT
    CASE
        WHEN scenario.risk_score >= 80 THEN 'Conservative'
        WHEN scenario.risk_score >= 60 THEN 'Moderate'
        ELSE 'Aggressive'
    END AS "Strategy",
    results.participants.portfolio_constructor AS "Agent",
    scenario.goal_type AS "Goal Type",
    ROUND(scenario.risk_score, 1) AS "Risk Score",
    ROUND(scenario.return_score, 1) AS "Return Score",
    ROUND(scenario.probability_of_success, 1) AS "Success %",
    ROUND(scenario.diversification_score, 1) AS "Diversification"
FROM results
CROSS JOIN UNNEST(results.results) AS r(res)
CROSS JOIN UNNEST(res.scenarios) AS s(scenario)
WHERE scenario.goal_type IS NOT NULL
ORDER BY scenario.risk_score DESC, scenario.probability_of_success DESC;
