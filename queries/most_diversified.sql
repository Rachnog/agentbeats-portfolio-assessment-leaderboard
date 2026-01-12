-- Most Diversified Portfolios
-- =============================
-- Rankings by diversification score

SELECT
    results.participants.portfolio_constructor AS "Agent",
    ROUND(detail.aggregate_scores.diversification_score, 1) AS "Diversification",
    ROUND(detail.aggregate_scores.probability_of_success, 1) AS "Success %",
    ROUND(detail.aggregate_scores.risk_score, 1) AS "Risk",
    ROUND(detail.aggregate_scores.return_score, 1) AS "Return"
FROM results
WHERE detail.aggregate_scores IS NOT NULL
ORDER BY detail.aggregate_scores.diversification_score DESC;
