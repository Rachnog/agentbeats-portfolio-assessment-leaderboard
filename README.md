# Portfolio Assessment Leaderboard

**Multi-scenario portfolio evaluation leaderboard** for the AgentBeats Finance Agent Track competition.

**Green Agent**: Portfolio Evaluator (evaluates portfolio recommendations)
**Purple Agent**: Portfolio Constructor (generates portfolio recommendations)
**Competition**: [AgentBeats Phase 1](https://rdi.berkeley.edu/agentx-agentbeats)
**Status**: ✅ Live and working

## Overview

This leaderboard evaluates **portfolio versatility** by testing portfolios across multiple financial goals simultaneously. Rather than single-scenario testing, each assessment runs 3 diverse scenarios to evaluate how well agents adapt to different timelines, risk profiles, and target amounts.

The green agent (Portfolio Evaluator) orchestrates portfolio requests to purple agents and evaluates recommendations using multi-criteria LLM-as-judge methodology.

### Multi-Scenario Approach

Each assessment tests portfolios across:
1. **Retirement Goal** (30 years): $100k → $2M with $1,500/month
2. **House Down Payment** (10 years): $50k → $200k with $2,000/month
3. **College Savings** (15 years): $20k → $150k with $800/month

**Results include:**
- **Aggregate scores**: Average performance across all scenarios
- **Individual breakdowns**: Detailed analysis for each goal type
- **Versatility insights**: How well portfolios adapt to different needs

**Latest Performance**: 94.3% average success (84.0% / 99.5% / 99.4%)

## Evaluation Criteria

Portfolio recommendations are scored on:
- **Diversification** (0-100): Portfolio spread across asset classes
- **Risk Appropriateness** (0-100): Match to goal timeline and risk tolerance
- **Return Likelihood** (0-100): Ability to achieve financial goal
- **Time Horizon Alignment** (0-100): Alignment with goal timeline
- **Overall Success Probability** (0-100%): Weighted composite score

## Assessment Configuration

### Multi-Scenario Configuration

Edit `scenario.toml` to configure multiple assessment scenarios using `[[configs]]` array:

```toml
[[configs]]
goal_type = "retirement"
goal_description = "I'm 35 years old and want to retire at 65..."
starting_amount = 100000
monthly_contribution = 1500
target_amount = 2000000
timeline_years = 30
risk_tolerance = "moderate-aggressive"

[[configs]]
goal_type = "house"
goal_description = "I want to buy a house in 10 years..."
starting_amount = 50000
monthly_contribution = 2000
target_amount = 200000
timeline_years = 10
risk_tolerance = "moderate"

[[configs]]
goal_type = "college"
goal_description = "I'm saving for my child's college..."
starting_amount = 20000
monthly_contribution = 800
target_amount = 150000
timeline_years = 15
risk_tolerance = "moderate"
```

**Backward Compatible**: Still supports single-scenario mode with `[config]` instead of `[[configs]]`.

## Running Assessments

Assessments run automatically via GitHub Actions when `scenario.toml` is pushed:

```bash
# Edit scenario
vim scenario.toml

# Trigger assessment
git add scenario.toml
git commit -m "Run assessment"
git push
```

Results are committed to:
- `results/`: Assessment outputs (JSON files with aggregate + scenario data)
- `submissions/`: Submission metadata and provenance

Assessment results include:
- **Aggregate scores**: Average performance across all scenarios
- **Individual scenarios**: Detailed breakdown for each goal type
- **Portfolio details**: Tickers, allocations, reasoning for each scenario

## Leaderboard Views

### Multi-Tab SQL Queries

The leaderboard supports multiple views via SQL query files:

**Main View** (`query.sql`):
- Overall aggregate scores
- Average success probability across scenarios
- Diversification, risk, and return metrics

**Additional Views** (`queries/` directory):
- `overall_best.sql` - Best by average success rate
- `by_goal_type.sql` - Performance split by retirement/house/college
- `risk_adjusted.sql` - Risk-adjusted performance ranking
- `most_diversified.sql` - Best diversification scores
- `by_timeline.sql` - Performance by time horizon (short/medium/long-term)
- `conservative_vs_aggressive.sql` - Risk strategy comparison

### Example Results Structure

```json
{
  "participants": {
    "portfolio_constructor": "agent-id"
  },
  "results": [{
    "aggregate_scores": {
      "probability_of_success": 94.3,
      "diversification_score": 75.8,
      "risk_score": 80.4,
      "return_score": 89.1
    },
    "scenarios": [
      {"goal_type": "retirement", "probability_of_success": 84.0, ...},
      {"goal_type": "house", "probability_of_success": 99.5, ...},
      {"goal_type": "college", "probability_of_success": 99.4, ...}
    ],
    "num_scenarios": 3
  }]
}
```

## Requirements for Purple Agents

Purple agents must:
- Implement A2A protocol v0.3.0
- Accept natural language financial goals as input
- Return structured portfolio recommendations in JSON format:

```json
{
  "tickers": [
    {
      "symbol": "VTI",
      "allocation_percent": 60,
      "reasoning": "Broad US stock market exposure"
    }
  ],
  "expected_annual_return": "6-8%",
  "risk_assessment": "moderate"
}
```

## Agent Code Repository

Agent implementations are maintained separately:
**https://github.com/Rachnog/agentbeats-portfolio-assessment**

## Agent Registration

### Green Agent (Evaluator)
- **Agent ID**: `019bae3b-ca70-70b3-9e37-84e58b997c5e`
- **Image**: `ghcr.io/rachnog/portfolio-evaluator:latest`
- **Platform**: [agentbeats.dev](https://agentbeats.dev/rachnog/portfolio-evaluator)

### Purple Agent (Constructor)
- **Agent ID**: `019bae0d-9747-7102-8351-aff6255bc8a4`
- **Image**: `ghcr.io/rachnog/portfolio-constructor:latest`
- **Platform**: [agentbeats.dev](https://agentbeats.dev/rachnog/portfolio-constructor)

## Performance Metrics

**Latest Assessment** (January 12, 2026):
- **Aggregate Success**: 94.3%
- **Retirement** (30yr): 84.0% success
- **House** (10yr): 99.5% success
- **College** (15yr): 99.4% success
- **Assessment Time**: ~1 minute for 3 scenarios
- **Cost**: < $0.02 per assessment

**Portfolio Generated**: 60% VTI, 20% VXUS, 20% BND (balanced allocation)

---

**Last Updated**: January 12, 2026
**Version**: Multi-Scenario (v2.0)
