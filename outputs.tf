output "department_group_id" {
  description = "The ID of the created department group"
  value       = okta_group.department_group.id
}

output "department_group_name" {
  description = "The name of the created department group"
  value       = okta_group.department_group.name
}

output "department_rule_id" {
  description = "The ID of the created department group rule"
  value       = okta_group_rule.department_rule.id
}

output "department_rule_name" {
  description = "The name of the created department group rule"
  value       = okta_group_rule.department_rule.name
}

output "department_rule_status" {
  description = "The status of the department group rule"
  value       = okta_group_rule.department_rule.status
}

output "mailing_group_ids" {
  description = "The IDs of associated mailing groups"
  value       = { for k, v in data.okta_group.mailing_groups : k => v.id }
}

output "mailing_group_names" {
  description = "The names of associated mailing groups"
  value       = { for k, v in data.okta_group.mailing_groups : k => v.name }
}

output "application_group_ids" {
  description = "The IDs of associated application groups"
  value       = { for k, v in data.okta_group.application_groups : k => v.id }
}

output "application_group_names" {
  description = "The names of associated application groups"
  value       = { for k, v in data.okta_group.application_groups : k => v.name }
}

output "push_group_ids" {
  description = "The IDs of associated push groups"
  value       = { for k, v in data.okta_group.push_groups : k => v.id }
}

output "push_group_names" {
  description = "The names of associated push groups"
  value       = { for k, v in data.okta_group.push_groups : k => v.name }
}

output "all_assigned_group_ids" {
  description = "All group IDs that users will be assigned to via the rule"
  value       = local.groups_list
}

output "custom_profile_attributes" {
  description = "The custom profile attributes assigned to the department group"
  value       = local.custom_attributes
}