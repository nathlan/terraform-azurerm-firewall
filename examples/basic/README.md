# Basic Azure Firewall Example

This example demonstrates the basic usage of the Azure Firewall module with a VNet-based deployment.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.71.0, < 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | The ID of the Azure Firewall |
| <a name="output_firewall_name"></a> [firewall\_name](#output\_firewall\_name) | The name of the Azure Firewall |
| <a name="output_firewall_private_ip_address"></a> [firewall\_private\_ip\_address](#output\_firewall\_private\_ip\_address) | The private IP address of the Azure Firewall |
<!-- END_TF_DOCS -->
