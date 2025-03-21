package terraform.azure

deny contains msg if {
    input.resource_type == "azurerm_storage_account"
    input.properties.enable_https_traffic_only == false
    msg := "Storage account must have HTTPS traffic enabled"
}

deny contains msg if {
    input.resource_type == "azurerm_storage_account"
    input.properties.encryption.key_source != "Microsoft.Keyvault"
    msg := "Storage account must use customer-managed encryption keys"
}