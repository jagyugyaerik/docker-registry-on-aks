output "postfix" {
  value = "Update your domain with ip address: ${azurerm_public_ip.this.ip_address}"
}