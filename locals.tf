locals {
  # Department group configuration
  group_name        = "DEPT-${var.department_name}"
  group_description = "Group for the ${var.department_name} department\nManaged by Terraform. Do not edit manually."

  # Extract names from the data sources (for custom attributes)
  mailing_list_names = [for name in var.mailing_list_names : "ML-${name}"]
  app_group_names = [for name in var.application_group_names : "APP-ROLE-${name}"]
  push_group_names = [for name in var.push_group_names : "PG-${name}"]

  # Extract IDs from the data sources
  mailing_group_ids = [for grp in data.okta_group.mailing_groups : grp.id]
  app_group_ids     = [for grp in data.okta_group.application_groups : grp.id]
  push_group_ids    = [for grp in data.okta_group.push_groups : grp.id]



  # Ensure Terraform management note is always included
  notes = var.notes == "Group is managed by Terraform. Do not edit manually." ? var.notes : "${var.notes}\nGroup is managed by Terraform. Do not edit manually."

  # Build custom attributes for the group
  custom_attributes = merge(
    { notes = local.notes },
    length(local.app_group_names) > 0 ?{ applicationAssignments = [for grp in data.okta_group.application_groups : grp.name ] } : {},
    length(local.mailing_list_names) > 0 ? { mailingLists = [for grp in data.okta_group.mailing_groups : grp.name ] } : {},
    length(local.push_group_names) > 0 ? { pushGroups = [for grp in data.okta_group.push_groups : grp.name ] } : {},
    { assignmentProfile = "Not an application assignment group" }
  )

  # Group rule configuration
  group_rule_name = "${var.department_name} Department Group Rule"
  groups_list     = concat([okta_group.department_group.id], local.mailing_group_ids, local.app_group_ids, local.push_group_ids)
}