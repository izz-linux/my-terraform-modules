# Basic AKS Example

This example demonstrates basic usage of the Azure AKS module.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.3.0
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure subscription

## Usage

1. Authenticate with Azure:

```bash
az login
az account set --subscription "<subscription-id>"
```

2. Copy the example variables file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Edit `terraform.tfvars` with your desired values.

4. Initialize and apply:

```bash
terraform init
terraform plan
terraform apply
```

5. After successful deployment, configure kubectl:

```bash
az aks get-credentials --resource-group <resource-group-name> --name <cluster-name>
```

## Clean Up

To destroy the resources:

```bash
terraform destroy
```
