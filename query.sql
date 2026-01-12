-- Portfolio Assessment Leaderboard - Main View
-- ===============================================
-- Overall rankings by average probability of success across all scenarios

SELECT
    results.participants.portfolio_constructor AS "Agent",
    ROUND(res.aggregate_scores.probability_of_success, 1) AS "Avg Success %",
    ROUND(res.aggregate_scores.diversification_score, 1) AS "Diversification",
    ROUND(res.aggregate_scores.risk_score, 1) AS "Risk Score",
    ROUND(res.aggregate_scores.return_score, 1) AS "Return Score",
    res.num_scenarios AS "# Scenarios"
FROM results
CROSS JOIN UNNEST(results.results) AS r(res)
WHERE res.aggregate_scores IS NOT NULL
ORDER BY res.aggregate_scores.probability_of_success DESC;
