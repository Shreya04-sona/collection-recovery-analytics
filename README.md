# Collections Recovery Analytics — Submission Pack

## Objective
Validate the reported 11% month-on-month recovery improvement, identify data-quality and attribution risks, explain performance drivers, and recommend how to deploy a ₹10 Cr investment.

## Deliverables
- `data/golden/` — reproducible analytical datasets
- `sql/` — DuckDB-compatible audit, cleaning and metric SQL
- `notebooks/03_recovery_analysis.ipynb` — analytical notebook
- `dashboard/recovery_executive_dashboard.png` — executive dashboard
- `dashboard/*.csv` — dashboard-ready data
- `reports/executive_memo.md` — executive recommendation
- `reports/data_quality_report.md` — data forensics
- `architecture/architecture.png` — pipeline architecture
- `evidence/` — audit tables and methodology

## Key conclusion
The February→March recovery proxy rises by about 11%, so the headline is numerically plausible under the proxy definition. It is **not sufficient evidence of an 11% causal operational improvement** because the source contains material duplicate, identity, timestamp and campaign-window defects and does not provide time-varying outstanding balances.

## Recommended decision
Do not commit the full ₹10 Cr based only on this observational dataset. Run a controlled targeting pilot and scale only if incremental recovery per ₹ invested remains positive after costs and adverse outcomes.

## Reproducibility
Raw source files are copied unchanged under `data/raw/`. All transformations are documented in SQL and Python.
