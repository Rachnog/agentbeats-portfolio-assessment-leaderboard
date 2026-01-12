-- Conservative vs Aggressive Strategies
-- ========================================
-- Compare portfolios by risk profile

SELECT
    CASE
        WHEN s.risk_score >= 80 THEN 'Conservative'
        WHEN s.risk_score >= 60 THEN 'Moderate'
        ELSE 'Aggressive'
    END AS "Strategy",
    results.participants.portfolio_constructor AS "Agent",
    s.goal_type AS "Goal Type",
    ROUND(s.risk_score, 1) AS "Risk Score",
    ROUND(s.return_score, 1) AS "Return Score",
    ROUND(s.probability_of_success, 1) AS "Success %",
    ROUND(s.diversification_score, 1) AS "Diversification"
FROM results
CROSS JOIN UNNEST(results.detail.scenarios) AS scenario(s)
WHERE s.goal_type IS NOT NULL
ORDER BY s.risk_score DESC, s.probability_of_success DESC;
