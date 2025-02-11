# variables.tf
variable "client_id" {
  description = "Okta Client ID"
  type        = string
  sensitive   = true
}

variable "org_name" {
  description = "Okta org name ie. company"
  type        = string
}

variable "base_url" {
  description = "Okta Base URL ie. okta.com"
  type        = string
}

variable "private_key_id" {
  description = "Okta Oauth private key id"
  type        = string
  sensitive   = true
}

variable "private_key" {
  description = "Okta Oauth private key"
  type        = string
  sensitive   = true
}

variable "department_name" {
  description = "Name of department"
  type        = string
}

variable "mailing_list_ids" {
  description = "Existing mailing list Okta group IDs that you want assigned to the department"
  type        = list(string)
  default     = [] 
}

variable "application_group_ids" {
  description = "Existing group IDs that assign applications/roles"
  type        = list(string)
  default     = []
}

variable "push_group_ids" {
  description = "Existing push group Okta IDs that you want to assign to the department"
  type        = list(string)
  default     = []
}

variable "notes" {
  description = "Any notes you want to manually add"
  type        = string
  default     = "Group is managed by Terraform. Do not edit manually." 
}
