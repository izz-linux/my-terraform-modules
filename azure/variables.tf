variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
  default     = null
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the AKS cluster"
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "The SKU tier for the AKS cluster (Free or Standard)"
  type        = string
  default     = "Free"

  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "SKU tier must be either 'Free' or 'Standard'."
  }
}

variable "default_node_pool" {
  description = "Configuration for the default node pool"
  type = object({
    name                = optional(string, "default")
    vm_size             = optional(string, "Standard_DS2_v2")
    node_count          = optional(number, 1)
    enable_auto_scaling = optional(bool, false)
    min_count           = optional(number, null)
    max_count           = optional(number, null)
    os_disk_size_gb     = optional(number, 30)
    os_disk_type        = optional(string, "Managed")
    vnet_subnet_id      = optional(string, null)
    zones               = optional(list(string), null)
  })
  default = {}
}

variable "identity_type" {
  description = "The type of identity used for the AKS cluster (SystemAssigned or UserAssigned)"
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "Identity type must be either 'SystemAssigned' or 'UserAssigned'."
  }
}

variable "identity_ids" {
  description = "List of user-assigned identity IDs (required if identity_type is UserAssigned)"
  type        = list(string)
  default     = null
}

variable "network_profile" {
  description = "Network profile configuration for the AKS cluster"
  type = object({
    network_plugin      = optional(string, "azure")
    network_policy      = optional(string, null)
    dns_service_ip      = optional(string, null)
    service_cidr        = optional(string, null)
    load_balancer_sku   = optional(string, "standard")
    outbound_type       = optional(string, "loadBalancer")
  })
  default = {}
}

variable "tags" {
  description = "A map of tags to apply to the AKS cluster resources"
  type        = map(string)
  default     = {}
}
