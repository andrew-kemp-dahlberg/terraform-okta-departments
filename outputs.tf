output "department_group_name" {
  description = "ID of created group"
  value       = okta_group.group.name
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


