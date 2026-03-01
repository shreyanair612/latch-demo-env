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
