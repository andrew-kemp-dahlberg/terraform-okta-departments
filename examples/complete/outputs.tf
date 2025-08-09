# Sales Department Outputs
output "sales_department_group_id" {
  description = "The ID of the Sales department group"
  value       = module.sales_department.department_group_id
}

output "sales_department_group_name" {
  description = "The name of the Sales department group"
  value       = module.sales_department.department_group_name
}

output "sales_all_assigned_groups" {
  description = "All group IDs that Sales users will be assigned to"
  value       = module.sales_department.all_assigned_group_ids
}

output "sales_custom_attributes" {
  description = "Custom profile attributes for the Sales department group"
  value       = module.sales_department.custom_profile_attributes
}

# Marketing Department Outputs
output "marketing_department_group_id" {
  description = "The ID of the Marketing department group"
  value       = module.marketing_department.department_group_id
}

output "marketing_department_group_name" {
  description = "The name of the Marketing department group"
  value       = module.marketing_department.department_group_name
}

# Example Groups Created
output "example_groups_created" {
  description = "IDs of example groups created for this demo"
  value = {
    sales_mailing_list = okta_group.sales_mailing_list.id
    crm_users          = okta_group.crm_users.id
    sales_dashboard    = okta_group.sales_dashboard.id
    sales_push         = okta_group.sales_push.id
  }
}