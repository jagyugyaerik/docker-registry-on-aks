verbosityLevel: 3

appgw:
  subscriptionId: ${subscription_id}
  resourceGroup: ${resource_group}
  applicationGatewayID: ${application_gateway_id}
  subnetId: ${subnet_id}

armAuth:
  type: servicePrincipal
  secretJSON: ${secret_json}

rbac:
  enabled: true

nameOverride: ${service_account_name}