terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "firewall" {
  source = "../.."

  name                = "example-firewall"
  resource_group_name = "example-rg"
  location            = "australiaeast"
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration = [{
    name                 = "default"
    subnet_id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/AzureFirewallSubnet"
    public_ip_address_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-rg/providers/Microsoft.Network/publicIPAddresses/example-pip"
  }]

  zones = ["1", "2", "3"]

  tags = {
    Environment = "Development"
    ManagedBy   = "Terraform"
    Purpose     = "Example"
  }
}

output "firewall_id" {
  description = "The ID of the Azure Firewall"
  value       = module.firewall.resource_id
}

output "firewall_name" {
  description = "The name of the Azure Firewall"
  value       = module.firewall.name
}

output "firewall_private_ip_address" {
  description = "The private IP address of the Azure Firewall"
  value       = module.firewall.private_ip_address
}
