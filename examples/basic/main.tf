provider "okta" {
  org_name       = var.org_name
  base_url       = var.base_url
  client_id      = var.client_id
  private_key_id = var.private_key_id
  private_key    = var.private_key
  scopes         = ["okta.groups.manage", "okta.groups.read"]
}

module "engineering_department" {
  source = "../.."

  # Okta Configuration
  org_name       = var.org_name
  base_url       = var.base_url
  client_id      = var.client_id
  private_key_id = var.private_key_id
  private_key    = var.private_key

  # Department Configuration
  department_name = "Engineering"
}