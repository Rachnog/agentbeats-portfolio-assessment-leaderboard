-- Risk-Adjusted Performance Rankings
-- ====================================
-- Rankings by risk-adjusted return score
-- Formula: (Return Score * Success Probability) / Risk Taken

SELECT
    results.participants.portfolio_constructor AS "Agent",
    ROUND(
        (res.aggregate_scores.return_score * res.aggregate_scores.probability_of_success) /
        NULLIF(100 - res.aggregate_scores.risk_score, 0),
        2
    ) AS "Risk-Adjusted Score",
    ROUND(res.aggregate_scores.probability_of_success, 1) AS "Success %",
    ROUND(res.aggregate_scores.return_score, 1) AS "Return",
    ROUND(res.aggregate_scores.risk_score, 1) AS "Risk",
    ROUND(res.aggregate_scores.diversification_score, 1) AS "Diversification"
FROM results
CROSS JOIN UNNEST(results.results) AS r(res)
WHERE res.aggregate_scores IS NOT NULL
ORDER BY
    (res.aggregate_scores.return_score * res.aggregate_scores.probability_of_success) /
    NULLIF(100 - res.aggregate_scores.risk_score, 0) DESC;
