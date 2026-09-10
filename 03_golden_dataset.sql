-- 03_golden_dataset.sql
-- Build the analytical account spine and anchor borrower identity on the account master.
CREATE OR REPLACE TABLE golden_accounts AS
SELECT account_id, borrower_id, loan_type, principal_amount, outstanding_amount, dpd, risk_segment, status, opened_at, timezone
FROM read_csv_auto('data/raw/accounts.csv');

CREATE OR REPLACE TABLE golden_success_payments AS
SELECT p.payment_id, p.account_id, a.borrower_id, CAST(p.event_at AS TIMESTAMP) event_at, p.amount
FROM golden_payments p JOIN golden_accounts a USING(account_id)
WHERE p.payment_status='SUCCESS';
