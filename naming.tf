resource "azurecaf_naming_convention" "resource_group" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "rg"
  convention    = "cafclassic"
}

resource "azurecaf_naming_convention" "vnet" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "vnet"
  convention    = "cafclassic"
}

resource "azurecaf_naming_convention" "snet" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "snet"
  postfix       = "aks"
  convention    = "cafclassic"
}

resource "azurecaf_naming_convention" "agw_snet" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "snet"
  postfix       = "agw"
  convention    = "cafclassic"
}

resource "azurecaf_naming_convention" "aks" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "aks"
  convention    = "cafclassic"
}

resource "azurecaf_naming_convention" "agw" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "agw"
  convention    = "cafclassic"
}

resource "azurecaf_naming_convention" "pip" {
  name          = "registry"
  prefix        = "dev"
  resource_type = "pip"
  convention    = "cafclassic"
}