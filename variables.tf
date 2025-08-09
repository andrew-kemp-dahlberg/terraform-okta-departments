# variables.tf
variable "client_id" {
  description = "OAuth 2.0 client ID for Okta API authentication. Must have okta.groups.manage and okta.groups.read scopes."
  type        = string
  sensitive   = true
}

variable "org_name" {
  description = "The Okta organization name (e.g., 'mycompany' for mycompany.okta.com)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.org_name))
    error_message = "Organization name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "base_url" {
  description = "The Okta base URL (e.g., 'okta.com', 'oktapreview.com', 'okta-emea.com')"
  type        = string
  default     = "okta.com"
  
  validation {
    condition     = contains(["okta.com", "oktapreview.com", "okta-emea.com"], var.base_url)
    error_message = "Base URL must be one of: okta.com, oktapreview.com, okta-emea.com"
  }
}

variable "private_key_id" {
  description = "The ID of the private key used for OAuth 2.0 authentication with Okta"
  type        = string
  sensitive   = true
}

variable "private_key" {
  description = "The private key (PEM format) used for OAuth 2.0 authentication with Okta"
  type        = string
  sensitive   = true
}

variable "department_name" {
  description = "The name of the department. This will be used in group naming and for matching user.department attribute."
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9 _-]*[a-zA-Z0-9]$", var.department_name)) && length(var.department_name) <= 50
    error_message = "Department name must start and end with alphanumeric characters, can contain spaces, hyphens, and underscores, and be 50 characters or less."
  }
}

variable "mailing_list_names" {
  description = "List of existing Okta mailing group names to associate with the department. Users will be added to these groups when they match the department."
  type        = list(string)
  default     = []
  
  validation {
    condition     = alltrue([for name in var.mailing_list_names : length(name) > 0])
    error_message = "Mailing list names cannot be empty strings."
  }
}

variable "application_group_names" {
  description = "List of existing Okta application/role group names to associate with the department. These typically grant access to specific applications."
  type        = list(string)
  default     = []
  
  validation {
    condition     = alltrue([for name in var.application_group_names : length(name) > 0])
    error_message = "Application group names cannot be empty strings."
  }
}

variable "push_group_names" {
  description = "List of existing Okta push group names to associate with the department. These are used for Okta Verify push notifications."
  type        = list(string)
  default     = []
  
  validation {
    condition     = alltrue([for name in var.push_group_names : length(name) > 0])
    error_message = "Push group names cannot be empty strings."
  }
}

variable "notes" {
  description = "Custom notes to add to the department group's profile. The Terraform management warning will be automatically appended."
  type        = string
  default     = "Group is managed by Terraform. Do not edit manually."
  
  validation {
    condition     = length(var.notes) <= 1000
    error_message = "Notes must be 1000 characters or less."
  }
}
