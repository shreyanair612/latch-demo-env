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

# VELIRA AUTO-REMEDIATION — 2026-03-01T16:30:52.201853+00:00
# Drift detected: properties.condition changed from ((!(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})) to None
# Severity: CRITICAL
# Regulation: 21 CFR Part 11.10(d)
# Action: Restore to GxP validated baseline v3.2
# Justification: The removal of the condition attribute from the role assignment allows unrestricted write access to role assignments, bypassing the validated control that restricted such actions. This compromises acc
