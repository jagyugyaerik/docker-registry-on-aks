# docker-registry-on-aks
Docker registry on AKS

# Table of Contents
- [docker-registry-on-aks](#docker-registry-on-aks)
- [Table of Contents](#table-of-contents)
- [Requirements](#requirements)
  - [Terraform](#terraform)
  - [Auzre cli](#auzre-cli)
  - [Register Azure Account](#register-azure-account)
  - [Enable OIDC Issuer](#enable-oidc-issuer)
    - [Register the EnableOIDCIssuerPreview feature flag](#register-the-enableoidcissuerpreview-feature-flag)
  - [Install the aks-preview CLI extension](#install-the-aks-preview-cli-extension)
- [Install docker-registry](#install-docker-registry)

# Requirements

## Terraform

To use Terraform you will need to [install](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) it. HashiCorp distributes Terraform as a binary package. You can also install Terraform using popular package managers.

docs: https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started
## Auzre cli

The Azure CLI is available to install in Windows, macOS and Linux environments. It can also be run in a Docker container and Azure Cloud Shell. Follow the installation [instructions](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

docs: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

## Register Azure Account

[Register](https://azure.microsoft.com/en-us/free/) an azure account.

docs: https://azure.microsoft.com/en-us/free/
## Enable OIDC Issuer

### Register the EnableOIDCIssuerPreview feature flag

This enables an OIDC Issuer URL of the provider which allows the API server to discover public signing keys.

To use the OIDC Issuer feature, you must enable the EnableOIDCIssuerPreview feature flag on your subscription. Run the following commands:

```bash
az feature register --name EnableOIDCIssuerPreview --namespace Microsoft.ContainerService
```

You can check on the registration status by using the az feature list command:

```bash
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/EnableOIDCIssuerPreview')].{Name:name,State:properties.state}"
```

When ready, refresh the registration of the Microsoft.ContainerService resource provider by using the az provider register command:
```bash
az provider register --namespace Microsoft.ContainerService
```

## Install the aks-preview CLI extension

```bash
# Install the aks-preview extension
az extension add --name aks-preview

# Update the extension to make sure you have the latest version installed
az extension update --name aks-preview
```

# Install docker-registry

```bash
az login
terraform init
```

```bash
terraform apply -input=false -auto-approve
```

```bash
terraform destroy -input=false -auto-approve
```

