variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default = "izz-aks-cluster"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "izz-k8s-rg"
}

variable "location" {
  description = "The Azure region for deployment"
  type        = string
  default     = "eastus2"
}

variable "kubernetes_version" {
  description = "The Kubernetes version"
  type        = string
  default     = "1.33"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
