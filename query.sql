-- Portfolio Assessment Leaderboard - Main View
-- ===============================================
-- Overall rankings by average probability of success across all scenarios

SELECT
    results.participants.portfolio_constructor AS "Agent",
    ROUND(detail.aggregate_scores.probability_of_success, 1) AS "Avg Success %",
    ROUND(detail.aggregate_scores.diversification_score, 1) AS "Diversification",
    ROUND(detail.aggregate_scores.risk_score, 1) AS "Risk Score",
    ROUND(detail.aggregate_scores.return_score, 1) AS "Return Score",
    detail.num_scenarios AS "# Scenarios"
FROM results
WHERE detail.aggregate_scores IS NOT NULL
ORDER BY detail.aggregate_scores.probability_of_success DESC;
