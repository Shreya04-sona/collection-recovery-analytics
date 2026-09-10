-- 04_metrics.sql
SELECT DATE_TRUNC('month', event_at) AS month,
       SUM(amount) AS recovered_amount,
       COUNT(DISTINCT payment_id) AS successful_payments
FROM golden_success_payments
GROUP BY 1 ORDER BY 1;

-- Proxy recovery rate uses static account-master outstanding because no monthly balance history exists.
WITH pay AS (
 SELECT DATE_TRUNC('month', event_at) month, SUM(amount) recovered FROM golden_success_payments GROUP BY 1
), bal AS (
 SELECT SUM(outstanding_amount) outstanding FROM golden_accounts
)
SELECT month, recovered, recovered/outstanding AS proxy_recovery_rate FROM pay CROSS JOIN bal ORDER BY month;
