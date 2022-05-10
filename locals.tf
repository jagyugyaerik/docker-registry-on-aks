locals {
  clusterissuer = "letsencrypt"
}

locals {
  ingress-azure = {
    service_account_name = "ingress-azure"
    namespace            = "ingress-azure"
  }
}

locals {
  system_helm_releases = {
    cert-manager = {
      namespace        = "cert-manager"
      repository       = "https://charts.jetstack.io"
      chart            = "cert-manager"
      version          = "1.8.0"
      create_namespace = true
      values = [
        file("${path.module}/helm_values/cert-manager-values.yaml")
      ]
    }
    ingress-azure = {
      namespace        = "ingress-azure"
      repository       = "https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/"
      chart            = "ingress-azure"
      version          = "1.5.2"
      create_namespace = true
      values = [
        data.template_file.ingress_azure_values_file.rendered
      ]
    }
  }
  app_helm_releases = {
    docker-registry = {
      namespace        = "docker-registry"
      repository       = "https://helm.twun.io"
      chart            = "docker-registry"
      version          = "2.1.0"
      create_namespace = true
      values = [
        data.template_file.docker_registry_file.rendered
      ]
    }
    letsencrypt = {
      namespace        = null
      repository       = "https://charts.loft.sh"
      chart            = "cert-issuer"
      version          = "0.0.4"
      create_namespace = null
      values = [
        file("${path.module}/helm_values/cert-issuer-values.yaml")
      ]
    }
  }
}

locals {
  backend_address_pool_name      = "${azurerm_virtual_network.this.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.this.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.this.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.this.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.this.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.this.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.this.name}-rdrcfg"
}