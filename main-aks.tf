data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = azurecaf_naming_convention.resource_group.result
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name                = azurecaf_naming_convention.vnet.result
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "this" {
  name                 = azurecaf_naming_convention.vnet.result
  virtual_network_name = azurerm_virtual_network.this.name
  resource_group_name  = azurerm_resource_group.this.name
  address_prefixes     = var.snet_address_prefixes
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = azurecaf_naming_convention.aks.result
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "registry-aks"
  oidc_issuer_enabled = true

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "standard_d2ads_v5"
    vnet_subnet_id = azurerm_subnet.this.id
  }

  network_profile {
    network_plugin = "azure"
  }

  identity {
    type = "SystemAssigned"
  }
}
