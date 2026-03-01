# Latch Demo Environment

This repository represents a mock biotech production cloud environment used by **Velira** to demonstrate GxP configuration drift detection and auto-remediation.

Velira watches this repo and automatically opens Pull Requests when it detects drift against the FDA‑validated baseline (Config v3.2).

## Monitored resources

- `genomics-data-storage-prod` (Azure Storage Account)
- `genomics-pipeline-nsg` (Network Security Group)
- `pipeline-iam` (IAM role assignments)

Auto-generated PRs will:
- Describe the detected drift,
- Cite the relevant FDA 21 CFR Part 11 regulation,
- Include a remediation comment block restoring the baseline configuration.
