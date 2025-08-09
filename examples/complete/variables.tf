variable "org_name" {
  description = "The Okta organization name"
  type        = string
}

variable "base_url" {
  description = "The Okta base URL"
  type        = string
  default     = "okta.com"
}

variable "client_id" {
  description = "OAuth 2.0 client ID for Okta API authentication"
  type        = string
  sensitive   = true
}

variable "private_key_id" {
  description = "The ID of the private key used for OAuth 2.0 authentication"
  type        = string
  sensitive   = true
}

variable "private_key" {
  description = "The private key (PEM format) used for OAuth 2.0 authentication"
  type        = string
  sensitive   = true
}