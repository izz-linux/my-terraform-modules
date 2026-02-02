output "cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "cluster_fqdn" {
  description = "The FQDN of the AKS cluster"
  value       = module.aks.cluster_fqdn
}

output "node_resource_group" {
  description = "The auto-generated resource group for cluster resources"
  value       = module.aks.node_resource_group
}

output "kube_config_command" {
  description = "Azure CLI command to get kubeconfig"
  value       = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.cluster_name}"
}
