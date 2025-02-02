# main.tf
data "okta_group" "mailing_group_names" {
  for_each = toset(var.mailing_list_ids)
  id       = each.key
}

data "okta_group" "app_group_names" {
  for_each = toset(var.application_group_ids)
  id       = each.key
}

data "okta_group" "push_group_names" {
  for_each = toset(var.push_group_ids)
  id       = each.key
}
  
locals {
  group_name        = "DEPT-${var.department_name}"
  group_description = "Group for the ${var.department_name} department"
  app_group_names   = [for grp in data.okta_group.app_group_names : grp.name]
  push_group_names  = [for grp in data.okta_group.push_group_names : grp.name]
  mailing_group_names = [for grp in data.okta_group.mailing_group_names : grp.name]
  notes = var.notes == "Group is managed by Terraform. Do not edit manually." ? var.notes : "${var.notes}\nGroup is managed by Terraform. Do not edit manually."
  custom_attributes = merge(
  { notes = local.notes },
  length(local.app_group_names) > 0 ? { applicationAssignments = local.app_group_names } : {},
  length(local.mailing_group_names) > 0 ? { mailingLists = local.mailing_group_names } : {},
  length(local.push_group_names) > 0 ? { pushGroups = local.push_group_names } : {}
)
}

resource "okta_group" "group" {
  name         = local.group_name
  description  = local.group_description
  custom_profile_attributes = jsonencode(local.custom_attributes)  # Use the merged attributes
}

locals {
  group_rule_name = "${var.department_name} Depart Group Rule"
  groups_list     = concat([okta_group.group.id], var.mailing_list_ids, var.application_group_ids, var.push_group_ids)
}

resource "okta_group_rule" "group_rule" {
  name              = local.group_rule_name
  status            = "ACTIVE"
  group_assignments = local.groups_list
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = "user.department==\"${var.department_name}\""
}
