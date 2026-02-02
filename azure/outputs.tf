output "cluster_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.name
}

output "cluster_fqdn" {
  description = "The FQDN of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "kube_config" {
  description = "The Kubernetes configuration for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw Kubernetes configuration for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "kubelet_identity" {
  description = "The kubelet identity of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
}

output "node_resource_group" {
  description = "The auto-generated resource group containing AKS cluster resources"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL for the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "identity" {
  description = "The identity block of the AKS cluster"
  value       = azurerm_kubernetes_cluster.this.identity
}
