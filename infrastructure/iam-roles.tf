resource "azurerm_role_assignment" "pipeline_reader" {
  scope                = azurerm_storage_account.genomics_data.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = "00000000-0000-0000-0000-000000000000"
}

resource "azurerm_role_assignment" "qa_manager" {
  scope                = azurerm_storage_account.genomics_data.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = "11111111-1111-1111-1111-111111111111"
}

# VELIRA AUTO-REMEDIATION — 2026-03-01T22:05:26.319262+00:00
# Drift detected: properties.conditionVersion changed from 2.0 to None
# Severity: CRITICAL
# Regulation: 21 CFR Part 11.10(d)
# Action: Restore to GxP validated baseline v3.2
# Justification: The conditionVersion attribute for pipeline IAM roles was removed, which eliminates conditional access controls that were part of the validated security configuration. This compromises the ability to 
