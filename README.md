# terraform-azurerm-firewall

Azure Firewall Terraform module wrapping Azure Verified Module (AVM) with opinionated defaults for Australian regions.

## Usage

```hcl
module "firewall" {
  source = "github.com/nathlan/terraform-azurerm-firewall"

  name                = "my-firewall"
  resource_group_name = "my-rg"
  location            = "australiaeast"
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"

  ip_configuration = [{
    name                 = "default"
    subnet_id            = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/virtualNetworks/xxx/subnets/AzureFirewallSubnet"
    public_ip_address_id = "/subscriptions/xxx/resourceGroups/xxx/providers/Microsoft.Network/publicIPAddresses/xxx"
  }]

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
```

For complete examples, see the [examples](./examples/) directory.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.9.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm) | >= 3.116.0, < 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_avm_firewall"></a> [avm_firewall](#module_avm_firewall) | Azure/avm-res-network-azurefirewall/azurerm | ~> 0.4.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_telemetry"></a> [enable_telemetry](#input_enable_telemetry) | This variable controls whether or not telemetry is enabled for the module. | `bool` | `true` | no |
| <a name="input_firewall_policy_id"></a> [firewall_policy_id](#input_firewall_policy_id) | The ID of the Firewall Policy to associate with the Azure Firewall. | `string` | `null` | no |
| <a name="input_ip_configuration"></a> [ip_configuration](#input_ip_configuration) | List of IP configurations for the Azure Firewall. At least one IP configuration is required. | <pre>list(object({<br/>    name                 = string<br/>    subnet_id            = optional(string)<br/>    public_ip_address_id = string<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input_location) | The Azure region where the Azure Firewall should be created. | `string` | n/a | yes |
| <a name="input_lock"></a> [lock](#input_lock) | The lock level to apply to the Azure Firewall. Possible values are CanNotDelete and ReadOnly. | <pre>object({<br/>    kind = string<br/>    name = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_management_ip_configuration"></a> [management_ip_configuration](#input_management_ip_configuration) | The management IP configuration for the Azure Firewall. Required for Basic SKU tier. | <pre>object({<br/>    name                 = string<br/>    subnet_id            = string<br/>    public_ip_address_id = string<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input_name) | The name of the Azure Firewall. | `string` | n/a | yes |
| <a name="input_private_ip_ranges"></a> [private_ip_ranges](#input_private_ip_ranges) | List of private IP ranges to which traffic will not be SNAT'd. | `list(string)` | `[]` | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of the resource group in which to create the Azure Firewall. | `string` | n/a | yes |
| <a name="input_role_assignments"></a> [role_assignments](#input_role_assignments) | A map of role assignments to apply to the Azure Firewall. | <pre>map(object({<br/>    role_definition_id_or_name             = string<br/>    principal_id                           = string<br/>    description                            = optional(string, null)<br/>    skip_service_principal_aad_check       = optional(bool, false)<br/>    condition                              = optional(string, null)<br/>    condition_version                      = optional(string, null)<br/>    delegated_managed_identity_resource_id = optional(string, null)<br/>    principal_type                         = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_sku_name"></a> [sku_name](#input_sku_name) | The SKU name of the Azure Firewall. Possible values are AZFW_Hub and AZFW_VNet. | `string` | `"AZFW_VNet"` | no |
| <a name="input_sku_tier"></a> [sku_tier](#input_sku_tier) | The SKU tier of the Azure Firewall. Possible values are Basic, Standard, and Premium. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_virtual_hub"></a> [virtual_hub](#input_virtual_hub) | Virtual Hub configuration when using AZFW_Hub SKU. | <pre>object({<br/>    virtual_hub_id  = string<br/>    public_ip_count = optional(number, 1)<br/>  })</pre> | `null` | no |
| <a name="input_zones"></a> [zones](#input_zones) | Specifies the Availability Zones in which the Azure Firewall should be located. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_configuration"></a> [ip_configuration](#output_ip_configuration) | The IP configuration of the Azure Firewall. |
| <a name="output_name"></a> [name](#output_name) | The name of the Azure Firewall. |
| <a name="output_private_ip_address"></a> [private_ip_address](#output_private_ip_address) | The private IP address of the Azure Firewall. |
| <a name="output_resource"></a> [resource](#output_resource) | The full Azure Firewall resource object. |
| <a name="output_resource_id"></a> [resource_id](#output_resource_id) | The ID of the Azure Firewall. |
<!-- END_TF_DOCS -->
