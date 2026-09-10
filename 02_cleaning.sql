-- 02_cleaning.sql
-- Exact duplicate removal for payments. Reused references are flagged, not deleted.
CREATE OR REPLACE TABLE golden_payments AS
SELECT * EXCLUDE(rn)
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY payment_id, account_id, event_at, amount, payment_status, payment_reference ORDER BY event_at) rn
  FROM read_csv_auto('data/raw/payments.csv')
) WHERE rn = 1;

-- Conflicting call IDs are quarantined for review.
CREATE OR REPLACE TABLE call_conflicts AS
SELECT call_id
FROM read_csv_auto('data/raw/calls.csv')
GROUP BY call_id
HAVING COUNT(*) > 1 AND COUNT(DISTINCT CONCAT_WS('|', account_id, borrower_id, CAST(event_at AS VARCHAR), agent_id, campaign_id, call_status, CAST(duration_sec AS VARCHAR))) > 1;
