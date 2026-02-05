module "avm_firewall" {
  source  = "Azure/avm-res-network-azurefirewall/azurerm"
  version = "~> 0.4.0"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  firewall_sku_name   = var.sku_name
  firewall_sku_tier   = var.sku_tier
  firewall_policy_id  = var.firewall_policy_id

  # Convert list to map for ip_configurations
  ip_configurations = { for idx, config in var.ip_configuration : "ipconfig${idx}" => config }

  firewall_management_ip_configuration = var.management_ip_configuration
  firewall_private_ip_ranges           = var.private_ip_ranges != [] ? toset(var.private_ip_ranges) : null
  firewall_zones                       = var.zones != [] ? toset(var.zones) : null

  firewall_virtual_hub = var.virtual_hub

  tags = var.tags

  enable_telemetry = var.enable_telemetry
  lock             = var.lock
  role_assignments = var.role_assignments
}
