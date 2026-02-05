variable "name" {
  type        = string
  description = "The name of the Azure Firewall."

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{0,78}[a-zA-Z0-9]$", var.name))
    error_message = "The name must be between 2 and 80 characters, start and end with an alphanumeric character, and contain only alphanumeric characters and hyphens."
  }
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Azure Firewall."
}

variable "location" {
  type        = string
  description = "The Azure region where the Azure Firewall should be created."

  validation {
    condition     = contains(["australiaeast", "australiasoutheast"], var.location)
    error_message = "The location must be either 'australiaeast' or 'australiasoutheast'."
  }
}

variable "sku_name" {
  type        = string
  description = "The SKU name of the Azure Firewall. Possible values are AZFW_Hub and AZFW_VNet."
  default     = "AZFW_VNet"

  validation {
    condition     = contains(["AZFW_Hub", "AZFW_VNet"], var.sku_name)
    error_message = "The sku_name must be either 'AZFW_Hub' or 'AZFW_VNet'."
  }
}

variable "sku_tier" {
  type        = string
  description = "The SKU tier of the Azure Firewall. Possible values are Basic, Standard, and Premium."
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_tier)
    error_message = "The sku_tier must be one of 'Basic', 'Standard', or 'Premium'."
  }
}

variable "firewall_policy_id" {
  type        = string
  description = "The ID of the Firewall Policy to associate with the Azure Firewall."
  default     = null
}

variable "ip_configuration" {
  type = list(object({
    name                 = string
    subnet_id            = optional(string)
    public_ip_address_id = string
  }))
  description = "List of IP configurations for the Azure Firewall. At least one IP configuration is required."
  default     = []

  validation {
    condition     = length(var.ip_configuration) > 0
    error_message = "At least one IP configuration must be provided."
  }
}

variable "management_ip_configuration" {
  type = object({
    name                 = string
    subnet_id            = string
    public_ip_address_id = string
  })
  description = "The management IP configuration for the Azure Firewall. Required for Basic SKU tier."
  default     = null
}

variable "private_ip_ranges" {
  type        = list(string)
  description = "List of private IP ranges to which traffic will not be SNAT'd."
  default     = []
}

variable "virtual_hub" {
  type = object({
    virtual_hub_id  = string
    public_ip_count = optional(number, 1)
  })
  description = "Virtual Hub configuration when using AZFW_Hub SKU."
  default     = null
}

variable "zones" {
  type        = list(string)
  description = "Specifies the Availability Zones in which the Azure Firewall should be located."
  default     = []

  validation {
    condition     = alltrue([for zone in var.zones : contains(["1", "2", "3"], zone)])
    error_message = "Zones must be a list of strings containing '1', '2', and/or '3'."
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "enable_telemetry" {
  type        = bool
  description = "This variable controls whether or not telemetry is enabled for the module."
  default     = true
}

variable "lock" {
  type = object({
    kind = string
    name = optional(string, null)
  })
  description = "The lock level to apply to the Azure Firewall. Possible values are CanNotDelete and ReadOnly."
  default     = null

  validation {
    condition     = var.lock == null || contains(["CanNotDelete", "ReadOnly"], var.lock.kind)
    error_message = "The lock kind must be either 'CanNotDelete' or 'ReadOnly'."
  }
}

variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  description = "A map of role assignments to apply to the Azure Firewall."
  default     = {}
}
