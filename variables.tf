variable "location" {
  type        = string
  description = "Azure location"
  default     = "West Europe"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "List of address space of vnet."
  default     = ["10.1.0.0/16"]
}

variable "aks_snet_address_prefixes" {
  type        = list(string)
  description = "List of address_prefixes of snet."
  default     = ["10.1.0.0/22"]
}

variable "agw_snet_address_prefixes" {
  type        = list(string)
  description = "List of address_prefixes of snet."
  default     = ["10.1.4.0/24"]
}

variable "host_name" {
  type        = string
  default     = "eriklab.ddns.net"
  description = "Hostname of docker registry"
}
