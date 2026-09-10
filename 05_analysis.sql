-- 05_analysis.sql
-- Descriptive strategy comparison only; not causal.
SELECT c.strategy_version, c.channel, COUNT(*) AS campaigns
FROM read_csv_auto('data/raw/campaigns.csv') c
GROUP BY 1,2 ORDER BY 1,2;

-- Campaign-window integrity check
SELECT COUNT(*) AS targeting_outside_window
FROM read_csv_auto('data/raw/daily_targeting.csv') t
JOIN read_csv_auto('data/raw/campaigns.csv') c USING(campaign_id)
WHERE CAST(t.target_date AS TIMESTAMP) < c.start_at
   OR CAST(t.target_date AS TIMESTAMP) > c.end_at;
