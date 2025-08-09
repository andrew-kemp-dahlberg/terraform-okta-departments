output "department_group_id" {
  description = "The ID of the created department group"
  value       = module.engineering_department.department_group_id
}

output "department_group_name" {
  description = "The name of the created department group"
  value       = module.engineering_department.department_group_name
}

output "department_rule_id" {
  description = "The ID of the created department group rule"
  value       = module.engineering_department.department_rule_id
}

output "department_rule_name" {
  description = "The name of the created department group rule"
  value       = module.engineering_department.department_rule_name
}