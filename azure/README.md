# Azure AKS Terraform Module

A Terraform module for deploying Azure Kubernetes Service (AKS) clusters.

## Features

- Configurable default node pool with autoscaling support
- System-assigned or user-assigned managed identity
- Flexible network configuration
- Customizable SKU tier (Free or Standard)

## Usage

```hcl
module "aks" {
  source = "path/to/module"

  cluster_name        = "my-aks-cluster"
  resource_group_name = "my-resource-group"
  location            = "eastus"

  default_node_pool = {
    name       = "default"
    vm_size    = "Standard_DS2_v2"
    node_count = 2
  }

  tags = {
    Environment = "dev"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| azurerm | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | The name of the AKS cluster | `string` | n/a | yes |
| resource_group_name | The name of the resource group | `string` | n/a | yes |
| location | The Azure region for deployment | `string` | n/a | yes |
| dns_prefix | DNS prefix for the cluster | `string` | `null` (uses cluster_name) | no |
| kubernetes_version | The Kubernetes version | `string` | `null` (latest) | no |
| sku_tier | SKU tier (Free or Standard) | `string` | `"Free"` | no |
| default_node_pool | Default node pool configuration | `object` | See variables.tf | no |
| identity_type | Identity type (SystemAssigned or UserAssigned) | `string` | `"SystemAssigned"` | no |
| identity_ids | User-assigned identity IDs | `list(string)` | `null` | no |
| network_profile | Network profile configuration | `object` | `{}` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the AKS cluster |
| cluster_name | The name of the AKS cluster |
| cluster_fqdn | The FQDN of the AKS cluster |
| kube_config | Kubernetes configuration (sensitive) |
| kube_config_raw | Raw Kubernetes configuration (sensitive) |
| kubelet_identity | The kubelet identity |
| node_resource_group | The auto-generated resource group |
| oidc_issuer_url | The OIDC issuer URL |
| identity | The identity block of the cluster |

## Examples

- [Basic](./examples/basic) - Basic AKS cluster deployment

## License

See [LICENSE](./LICENSE) for details.
