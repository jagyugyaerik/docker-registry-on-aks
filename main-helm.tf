data "template_file" "ingress_azure_values_file" {
  template = file("${path.module}/templates/ingress-auzre-values.yaml.tpl")
  vars = {
    subscription_id          = data.azurerm_subscription.primary.subscription_id
    resource_group           = azurerm_resource_group.this.name
    application_gateway_id = azurerm_application_gateway.this.id
    subnet_id                = azurerm_subnet.agw.id
    service_account_name     = local.ingress-azure.service_account_name
    secret_json = base64encode(jsonencode({
      "clientId"       = "${azuread_service_principal.this.application_id}",
      "clientSecret"   = "${azuread_service_principal_password.this.value}",
      "subscriptionId" = "${data.azurerm_subscription.primary.subscription_id}",
      "tenantId"       = "${data.azurerm_client_config.current.tenant_id}",
      "activeDirectoryEndpointUrl" : "https://login.microsoftonline.com",
      "resourceManagerEndpointUrl" : "https://management.azure.com/",
      "activeDirectoryGraphResourceId" : "https://graph.windows.net/",
      "sqlManagementEndpointUrl" : "https://management.core.windows.net:8443/",
      "galleryEndpointUrl" : "https://gallery.azure.com/",
      "managementEndpointUrl" : "https://management.core.windows.net/"
      }
    ))
  }
}

data "template_file" "docker_registry_file" {
  template = file("${path.module}/templates/docker-registry-values.yaml.tpl")
  vars = {
    host_name = "${var.host_name}"
  }
}

resource "helm_release" "system" {
  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
  for_each = local.system_helm_releases

  name             = each.key
  namespace        = each.value.namespace
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.version
  create_namespace = each.value.create_namespace
  values           = each.value.values
}

resource "helm_release" "app" {
  depends_on = [
    helm_release.system
  ]
  for_each = local.app_helm_releases

  name             = each.key
  namespace        = each.value.namespace
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.version
  create_namespace = each.value.create_namespace
  values           = each.value.values
}