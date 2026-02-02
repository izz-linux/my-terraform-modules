resource "azurerm_kubernetes_cluster" "this" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = coalesce(var.dns_prefix, var.cluster_name)
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  default_node_pool {
    name                = var.default_node_pool.name
    vm_size             = var.default_node_pool.vm_size
    node_count           = var.default_node_pool.auto_scaling_enabled ? null : var.default_node_pool.node_count
    auto_scaling_enabled = var.default_node_pool.auto_scaling_enabled
    min_count            = var.default_node_pool.auto_scaling_enabled ? var.default_node_pool.min_count : null
    max_count            = var.default_node_pool.auto_scaling_enabled ? var.default_node_pool.max_count : null
    os_disk_size_gb     = var.default_node_pool.os_disk_size_gb
    os_disk_type        = var.default_node_pool.os_disk_type
    vnet_subnet_id      = var.default_node_pool.vnet_subnet_id
    zones               = var.default_node_pool.zones
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }

  dynamic "network_profile" {
    for_each = length(keys(var.network_profile)) > 0 ? [var.network_profile] : []
    content {
      network_plugin    = network_profile.value.network_plugin
      network_policy    = network_profile.value.network_policy
      dns_service_ip    = network_profile.value.dns_service_ip
      service_cidr      = network_profile.value.service_cidr
      load_balancer_sku = network_profile.value.load_balancer_sku
      outbound_type     = network_profile.value.outbound_type
    }
  }

  tags = var.tags
}
