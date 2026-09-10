# Collections Recovery Analytics — Executive Memo

## Executive decision
The dataset does **not** support accepting the headline “recovery improved 11% month-on-month” without qualification. An independent proxy calculation shows that February→March 2026 recovery increased by approximately **11.0%**, which is close to the stated 11% claim. However, the source data contains material integrity issues—duplicate payments, conflicting call IDs, inconsistent borrower identifiers, campaign-window violations, and timestamp problems—so the headline should be treated as a hypothesis to validate, not as a clean causal KPI.

## What happened
Using a reproducible proxy metric—successful payment amount after exact duplicate removal divided by static account-master outstanding—the full-month recovery proxy was 1.822% in January, 1.660% in February and 1.842% in March, before settling around the 1.7–1.8% range through July. August is incomplete and is excluded from headline MoM interpretation.

## Data-quality findings that can distort recovery
- Payments contain 25,500 rows but 500 duplicate payment IDs / 486 exact duplicate rows after grouping; payment references are also reused across multiple payment IDs and accounts, so reference alone is unsafe as a deduplication key.
- Calls contain 1,350 duplicate call IDs and conflicting duplicate records; those conflicting IDs are excluded from primary call metrics and retained separately.
- The account master has 455 missing borrower IDs and 2,913 account borrower IDs not present in the borrowers table.
- Event-level borrower IDs frequently disagree with the account master; the analytical model therefore anchors borrower identity on account_id → master borrower_id.
- 36,333 targeting records fall outside their campaign's stated start/end window.
- 30,191 account-status history records have recorded_at earlier than event_at.
- The latest status history differs from the account master for 22,295 accounts.
- Agent IDs and employee codes are not stable one-to-one identifiers, preventing naive longitudinal agent comparisons.

## Why the 11% claim is not yet causal
The February→March movement is numerically consistent with an 11% MoM increase under the proxy metric, but this alone cannot establish that operations improved by 11%. Portfolio mix, campaign selection, attribution windows, identifier corruption and timing issues can all create apparent changes. Strategy-version and channel comparisons are therefore presented as descriptive evidence rather than causal effects.

## ₹10 Cr recommendation
**Do not commit the full ₹10 Cr based solely on the observational dataset.** The highest-value next step is a controlled targeting pilot rather than a blanket infrastructure or headcount investment. Targeting can be tested with a randomized or tightly matched treatment/control design while holding DPD, risk segment, loan type and geography constant.

### Proposed pilot
Allocate a small, ring-fenced pilot budget first. Randomly assign eligible accounts to current targeting versus improved targeting, pre-register the primary outcome as incremental recovered ₹ per eligible ₹ outstanding, and track adverse outcomes such as complaints. Scale toward ₹10 Cr only if the lower-bound ROI remains positive after accounting for operational costs.

## Production KPI definitions
- Contact rate = answered calls / call attempts.
- PTP rate = PTP events / right-party contacts; right-party logic must be finalized with disposition governance.
- PTP kept rate = kept PTPs / total PTPs.
- Recovery proxy = successful, deduplicated payment amount / static account-master outstanding.
- Cost per ₹ recovered = campaign/operational cost / recovered amount.

## Confidence
**Medium-low** for the exact recovery level and **low** for causal attribution, because the dataset lacks a reliable monthly balance history and contains several intentional integrity defects. Confidence can be raised with a governed event model, stable identifiers, canonical timestamps and a controlled targeting experiment.
