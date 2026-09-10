# Data Quality & Forensics Report

## Purpose
Assess whether the recovery trend can be trusted and identify data defects that could materially change business conclusions.

## Core principles
1. Raw files are immutable.
2. Account ID is the operational anchor.
3. Exact duplicates are removed programmatically.
4. Conflicting records are quarantined rather than silently overwritten.
5. Observational associations are not labeled causal.

## Findings
- **calls_borrower_mismatch_vs_account**: 89,939. Event borrower_id differs from account master borrower_id.
- **whatsapp_events_borrower_mismatch_vs_account**: 59,673. Event borrower_id differs from account master borrower_id.
- **account_status_history_borrower_mismatch_vs_account**: 59,035. Event borrower_id differs from account master borrower_id.
- **targeting_outside_campaign_window**: 36,333. Target date outside campaign definition window.
- **status_recorded_before_event**: 30,191. recorded_at earlier than event_at.
- **payments_borrower_mismatch_vs_account**: 25,113. Event borrower_id differs from account master borrower_id.
- **latest_history_status_differs_from_account**: 22,295. Latest status history differs from account master status.
- **accounts_borrower_not_in_borrowers**: 2,913. Master borrower IDs absent from borrowers table.
- **calls_duplicate_id_groups**: 1,350. IDs appearing more than once.
- **calls_duplicate_id_extra_rows**: 1,350. Rows beyond first per duplicate ID.
- **employee_codes_with_multiple_agent_ids**: 1,099. Employee codes associated with multiple agent IDs.
- **agent_ids_with_multiple_employee_codes**: 1,000. Agent IDs associated with multiple employee codes.
- **whatsapp_events_duplicate_id_groups**: 600. IDs appearing more than once.
- **whatsapp_events_duplicate_id_extra_rows**: 600. Rows beyond first per duplicate ID.
- **payments_duplicate_id_groups**: 500. IDs appearing more than once.
- **payments_duplicate_id_extra_rows**: 500. Rows beyond first per duplicate ID.
- **accounts_missing_borrower**: 455. Accounts without borrower_id in master.
- **calls_conflicting_duplicate_ids**: 11. Duplicate call IDs with at least one conflicting field.
- **borrower_mismatch_payments**: 0. See derived master-borrower consistency test.

## Golden-data treatment
- `golden_payments.csv`: exact duplicate rows removed; reused payment references flagged.
- `golden_calls.csv`: exact duplicate rows removed; conflicting call IDs quarantined.
- `golden_account_month.csv`: account-month analytical spine anchored to account master; event borrower IDs replaced by account master borrower ID where available.
- August 2026 is marked partial.

## Limitations
The dataset does not contain a time-varying balance field, so the recovery KPI is a proxy rather than a true opening-balance recovery rate. Campaign exposure windows are inconsistent, and agent identities are unstable. These limitations prevent a high-confidence causal claim.
