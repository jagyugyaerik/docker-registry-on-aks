locals {
  helm_releases = {
    docker-registry = {
      namespace        = "docker-registry"
      repository       = "https://helm.twun.io"
      chart            = "docker-registry"
      version          = "2.1.0"
      create_namespace = true
    }
    # cert-manager  = {}
    # ingress-azure = {}
  }
}

resource "helm_release" "this" {
  depends_on = [
    azurerm_kubernetes_cluster.this
  ]
  for_each = local.helm_releases

  name             = each.key
  namespace        = each.value.namespace
  repository       = each.value.repository
  chart            = each.value.chart
  version          = each.value.version
  create_namespace = each.value.create_namespace
}