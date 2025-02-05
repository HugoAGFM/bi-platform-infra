# Current Config
data "azurerm_client_config" "current" {}


# Resource Group
resource "azurerm_resource_group" "main" {
  name     = local.workspace.resource_group_name
  location = local.workspace.region
}


# Azure Data Factory
resource "azurerm_data_factory" "main" {
  name                = local.workspace.adf_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  dynamic "github_configuration" {
    for_each = local.workspace.env == "dev" ? ["apply"] : []
    content {
      account_name    = "HugoAGFM"
      branch_name     = "main"
      repository_name = "bi-platform-adf"
      root_folder     = "/"
    }
  }
}


# Key Vault
resource "azurerm_key_vault" "main" {
  name                = local.workspace.kv_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"
  purge_protection_enabled = false
}


# Databricks
resource "azurerm_databricks_workspace" "main" {
  name                = local.workspace.adbw_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "standard"
}

