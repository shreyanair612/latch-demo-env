# =============================================================================
# Genomics Data Storage — GxP Validated Configuration
# Baseline: v3.2 (validated 2025-11-15)
# Environment: gxp-prod-eastus
# Regulation: 21 CFR Part 11.10(a)
# =============================================================================

resource "azurerm_storage_account" "genomics_data" {
  name                     = "genomicsdatastorageprod"
  resource_group_name      = azurerm_resource_group.gxp_prod.name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  # Encryption — required for 21 CFR Part 11 data-at-rest protection
  blob_properties {
    versioning_enabled = true
  }

  # Public access — must be disabled for regulated data
  allow_nested_items_to_be_public = false

  # TLS — minimum TLS 1.2 required
  min_tls_version = "TLS1_2"

  # HTTPS — enforce encrypted transport
  https_traffic_only_enabled = true

  # Network — restrict to VPC only
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.data_subnet.id]
    bypass                     = ["AzureServices"]
  }

  tags = {
    environment = "gxp-prod"
    compliance  = "21-CFR-Part-11"
    baseline    = "v3.2"
  }
}

# VELIRA AUTO-REMEDIATION — 2026-03-01T16:22:03.608520+00:00
# Drift detected: properties.allowBlobPublicAccess changed from False to True
# Severity: CRITICAL
# Regulation: 21 CFR Part 11.10(a), 21 CFR Part 11.10(d)
# Action: Restore to GxP validated baseline v3.2
# Justification: The configuration change allows public access to blob storage, which compromises the confidentiality and integrity of electronic records stored in the FDA-validated environment.
