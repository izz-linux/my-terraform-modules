# Terraform Modules

Multi-cloud Terraform modules for Kubernetes cluster deployment.

## Available Modules

| Cloud | Module | Description |
|-------|--------|-------------|
| Azure | [azure](./azure) | Azure Kubernetes Service (AKS) |
| AWS | Coming soon | Amazon Elastic Kubernetes Service (EKS) |
| GCP | Coming soon | Google Kubernetes Engine (GKE) |

## Usage

Each cloud provider has its own directory with module files and examples.

```hcl
module "aks" {
  source = "path/to/azure"
  # ...
}
```

See individual module READMEs for detailed usage instructions.

## License

See [LICENSE](./LICENSE) for details.
