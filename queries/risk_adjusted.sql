-- Risk-Adjusted Performance Rankings
-- ====================================
-- Rankings by risk-adjusted return score
-- Formula: (Return Score * Success Probability) / Risk Taken

SELECT
    results.participants.portfolio_constructor AS "Agent",
    ROUND(
        (detail.aggregate_scores.return_score * detail.aggregate_scores.probability_of_success) /
        NULLIF(100 - detail.aggregate_scores.risk_score, 0),
        2
    ) AS "Risk-Adjusted Score",
    ROUND(detail.aggregate_scores.probability_of_success, 1) AS "Success %",
    ROUND(detail.aggregate_scores.return_score, 1) AS "Return",
    ROUND(detail.aggregate_scores.risk_score, 1) AS "Risk",
    ROUND(detail.aggregate_scores.diversification_score, 1) AS "Diversification"
FROM results
WHERE detail.aggregate_scores IS NOT NULL
ORDER BY
    (detail.aggregate_scores.return_score * detail.aggregate_scores.probability_of_success) /
    NULLIF(100 - detail.aggregate_scores.risk_score, 0) DESC;
