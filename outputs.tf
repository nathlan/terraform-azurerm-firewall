output "resource" {
  description = "The full Azure Firewall resource object."
  value       = module.avm_firewall.resource
}

output "resource_id" {
  description = "The ID of the Azure Firewall."
  value       = module.avm_firewall.resource_id
}

output "name" {
  description = "The name of the Azure Firewall."
  value       = module.avm_firewall.resource.name
}

output "private_ip_address" {
  description = "The private IP address of the Azure Firewall."
  value       = try(module.avm_firewall.resource.ip_configuration[0].private_ip_address, null)
}

output "ip_configuration" {
  description = "The IP configuration of the Azure Firewall."
  value       = module.avm_firewall.resource.ip_configuration
}
