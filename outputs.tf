output "department_group_name" {
  description = "ID of created group"
  value       = okta_group.group.name
}
output "department_group_id" {
  description = "ID of created group"
  value       = okta_group.group.id
}

output "department_rule_name" {
  description = "Name of the created group rule for the department"
  value       = okta_group.group.id
}

output "mailing_group_names" {
  description = "Existing mailing list Okta group names that you want assigned to the department"
  value       = local.mailing_group_names    
}

output "application_group_names" {
  description = "List of application groups added"
  value       = local.app_group_names
}

output "push_group_names" {
  description = "Existing mailing list IDs to combine with the new group"
  value       = local.push_group_names
}

output "mailing_list_ids" {
  description = "Existing mailing list Okta group IDs that you want assigned to the department"
  value       = var.mailing_list_ids
}

output "application_group_ids" {
  description = "Existing group IDs that assign applications/roles"
  value       = var.application_group_ids
}

output "push_group_ids" {
  description = "Existing push group Okta IDs that you want to assign to the department"
  value       = var.application_group_ids
}

