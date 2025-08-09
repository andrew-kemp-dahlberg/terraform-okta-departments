provider "okta" {
  org_name       = var.org_name
  base_url       = var.base_url
  client_id      = var.client_id
  private_key_id = var.private_key_id
  private_key    = var.private_key
  scopes         = ["okta.groups.manage", "okta.groups.read"]
}

# Create some example groups to demonstrate integration
resource "okta_group" "sales_mailing_list" {
  name        = "Sales-MailingList"
  description = "Mailing list for Sales department communications"
}

resource "okta_group" "crm_users" {
  name        = "CRM-Users"
  description = "Users with access to the CRM application"
}

resource "okta_group" "sales_dashboard" {
  name        = "Sales-Dashboard-Access"
  description = "Users with access to the Sales Dashboard"
}

resource "okta_group" "sales_push" {
  name        = "Sales-Push-Group"
  description = "Sales department Okta Verify push notifications"
}

# Create the Sales department using the module
module "sales_department" {
  source = "../.."

  # Okta Configuration
  org_name       = var.org_name
  base_url       = var.base_url
  client_id      = var.client_id
  private_key_id = var.private_key_id
  private_key    = var.private_key

  # Department Configuration
  department_name = "Sales"
  
  # Link to existing groups by name
  mailing_list_names = [
    okta_group.sales_mailing_list.name
  ]
  
  application_group_names = [
    okta_group.crm_users.name,
    okta_group.sales_dashboard.name
  ]
  
  push_group_names = [
    okta_group.sales_push.name
  ]
  
  # Custom notes
  notes = "Sales department group - includes Inside Sales and Field Sales teams"

  # Ensure the module waits for groups to be created
  depends_on = [
    okta_group.sales_mailing_list,
    okta_group.crm_users,
    okta_group.sales_dashboard,
    okta_group.sales_push
  ]
}

# Create another department to show multiple departments
module "marketing_department" {
  source = "../.."

  # Okta Configuration
  org_name       = var.org_name
  base_url       = var.base_url
  client_id      = var.client_id
  private_key_id = var.private_key_id
  private_key    = var.private_key

  # Department Configuration
  department_name = "Marketing"
  
  # Marketing might share some groups with Sales
  application_group_names = [
    okta_group.crm_users.name  # Marketing also needs CRM access
  ]
  
  notes = "Marketing department group - includes Digital Marketing and Brand teams"

  depends_on = [
    okta_group.crm_users
  ]
}