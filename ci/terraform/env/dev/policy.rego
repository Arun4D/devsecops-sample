package terraform.azure

deny[msg] {
    input.resource_type == "azurerm_storage_account"
    not input.properties.enable_https_traffic_only  # Corrected condition
    msg := "Storage account must have HTTPS traffic enabled"
}

deny[msg] {
    input.resource_type == "azurerm_storage_account"
    input.properties.encryption.key_source != "Microsoft.Keyvault"
    msg := "Storage account must use customer-managed encryption keys"
}
