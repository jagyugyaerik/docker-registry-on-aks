resource "azuread_application" "this" {
  display_name = "ingressAzure"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "this" {
  application_id               = azuread_application.this.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [azuread_service_principal.this]

  create_duration = "30s"
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.this.object_id
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.object_id
}

resource "azuread_application_federated_identity_credential" "this" {
  application_object_id = azuread_application.this.object_id
  display_name          = "ingress-azure"
  description           = "SPN for ingress auzre"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = azurerm_kubernetes_cluster.this.oidc_issuer_url
  subject               = "system:serviceaccount:${local.ingress-azure.namespace}:${local.ingress-azure.service_account_name}"
}