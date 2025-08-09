# Data sources to look up groups by name
data "okta_group" "mailing_groups" {
  for_each = toset(var.mailing_list_names)
  name     = each.value
}

data "okta_group" "application_groups" {
  for_each = toset(var.application_group_names)
  name     = each.value
}

data "okta_group" "push_groups" {
  for_each = toset(var.push_group_names)
  name     = each.value
}

# Create the department group
resource "okta_group" "department_group" {
  name                      = local.group_name
  description               = local.group_description
  custom_profile_attributes = jsonencode(local.custom_attributes)
}

# Configure automatic assignment rule
resource "okta_group_rule" "department_rule" {
  name              = local.group_rule_name
  status            = "ACTIVE"
  group_assignments = local.groups_list
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department==\"${var.department_name}\""
}
