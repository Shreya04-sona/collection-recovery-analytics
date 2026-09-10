-- 01_raw_audit.sql
-- DuckDB-compatible examples. Raw data remains immutable.
SELECT 'payments' AS dataset, COUNT(*) AS rows, COUNT(DISTINCT payment_id) AS unique_ids FROM read_csv_auto('data/raw/payments.csv');
SELECT 'calls' AS dataset, COUNT(*) AS rows, COUNT(DISTINCT call_id) AS unique_ids FROM read_csv_auto('data/raw/calls.csv');
SELECT 'borrowers' AS dataset, COUNT(*) AS rows, COUNT(DISTINCT borrower_id) AS unique_ids FROM read_csv_auto('data/raw/borrowers.csv');
