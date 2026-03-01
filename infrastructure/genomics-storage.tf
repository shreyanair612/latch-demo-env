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

# VELIRA AUTO-REMEDIATION — 2026-03-01T16:30:52.201853+00:00
# Drift detected: properties.networkAcls.virtualNetworkRules[0].id changed from /subscriptions/a1b2c3d4/resourceGroups/gxp-prod/providers/Microsoft.Network/virtualNetworks/gxp-vnet/subnets/data-subnet to None
# Severity: CRITICAL
# Regulation: 21 CFR Part 11.10(d)
# Action: Restore to GxP validated baseline v3.2
# Justification: The virtual network rule for the storage account has been removed, leaving the resource without network restrictions. This compromises the confidentiality and integrity of the data by potentially allo
