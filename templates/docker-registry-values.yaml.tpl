ingress:
  enabled: true
  path: /
  hosts:
    - ${host_name}
  className: azure-application-gateway
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
  tls:
    - secretName: tls
      hosts:
        - ${host_name}