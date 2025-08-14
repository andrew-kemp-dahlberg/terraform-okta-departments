# Terraform Okta Departments Module

A Terraform module for automating the creation and management of department-based groups in Okta. This module creates standardized department groups with automatic user assignment rules based on department attributes.

## Features

- **Automated Department Groups**: Creates department groups with consistent naming convention (`DEPT-{department_name}`)
- **Automatic User Assignment**: Configures group rules to automatically assign users based on their department attribute
- **Group Integration**: Links department groups with existing mailing lists, application groups, and push groups
- **Metadata Management**: Maintains custom profile attributes for tracking group relationships
- **Terraform Lifecycle Management**: Ensures groups are properly marked as Terraform-managed

## Requirements

- Terraform >= 1.0
- Okta Provider ~> 4.13.1
- Okta API access with the following scopes:
  - `okta.groups.manage`
  - `okta.groups.read`

## Usage

### Basic Example

```hcl
module "engineering_department" {
  source = "./terraform-okta-departments"

  # Okta Configuration
  org_name       = "your-org"
  base_url       = "okta.com"
  client_id      = var.okta_client_id
  private_key_id = var.okta_private_key_id
  private_key    = var.okta_private_key

  # Department Configuration
  department_name = "Engineering"
}
```

### Advanced Example with Group Integration

```hcl
module "sales_department" {
  source = "./terraform-okta-departments"

  # Okta Configuration
  org_name       = "your-org"
  base_url       = "okta.com"
  client_id      = var.okta_client_id
  private_key_id = var.okta_private_key_id
  private_key    = var.okta_private_key

  # Department Configuration
  department_name = "Sales"
  
  # Link to existing groups by name
  mailing_list_names = ["all-sales", "sales-announcements"]
  application_group_names = ["salesforce-users", "crm-{admin}"]
  push_group_names = ["sales-push-notifications"]
  
  # Custom notes
  notes = "Sales department group for CRM access"
}
```

## Variables

### Authentication Variables

| Name | Description | Type | Required | Sensitive |
|------|-------------|------|----------|-----------|
| `client_id` | OAuth 2.0 client ID for Okta API authentication | `string` | yes | yes |
| `private_key_id` | Private key ID for OAuth 2.0 authentication | `string` | yes | yes |
| `private_key` | Private key PEM for OAuth 2.0 authentication | `string` | yes | yes |
| `org_name` | Okta organization name | `string` | yes | no |
| `base_url` | Okta base URL (e.g., okta.com, oktapreview.com) | `string` | no | no |

### Department Configuration

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `department_name` | Name of the department | `string` | - | yes |
| `mailing_list_names` | List of Okta mailing group names to include (will be prefixed with ML-) | `list(string)` | `[]` | no |
| `application_group_names` | List of Okta application/role group names to include (will be prefixed with APP- or APP-ROLE-) | `list(string)` | `[]` | no |
| `push_group_names` | List of Okta push notification group names to include (will be prefixed with PG-) | `list(string)` | `[]` | no |
| `notes` | Custom notes for the department group | `string` | `"MANAGED BY TERRAFORM - DO NOT MODIFY MANUALLY"` | no |

## Outputs

| Name | Description | Type |
|------|-------------|------|
| `department_group_name` | The name of the created department group | `string` |
| `department_rule_name` | The ID of the created department group | `string` |
| `mailing_group_names` | Names of associated mailing groups | `map(string)` |
| `application_group_names` | Names of associated application groups | `map(string)` |
| `push_group_names` | Names of associated push groups | `map(string)` |

## How It Works

1. **Group Creation**: The module creates a department group with the name `DEPT-{department_name}`
2. **Rule Configuration**: A group rule is created that automatically assigns users when their `user.department` attribute matches the specified department name
3. **Group Integration**: If additional group names are provided, they are looked up and included in the assignment rule, allowing users to be added to multiple groups simultaneously. Groups are automatically prefixed:
   - Mailing lists: `ML-` prefix
   - Push groups: `PG-` prefix  
   - Application groups: `APP-` prefix (or `APP-ROLE-` for groups with `{application}-{role}` pattern)
4. **Metadata Management**: Custom profile attributes are stored on the group to track:
   - Management notes
   - Associated application groups
   - Associated mailing lists
   - Associated push groups

## Group Assignment Logic

The module creates an Okta group rule with the following expression:
```
user.department == "{department_name}"
```

This rule ensures that:
- Users are automatically added to the department group when their department attribute matches
- Users are removed from the group if their department changes
- Assignment happens in real-time as user attributes are updated

## Best Practices

1. **Naming Conventions**: Department names should be consistent with your organization's user profile data
2. **Group Reuse**: Link existing functional groups (mailing lists, app groups) rather than creating duplicates
3. **Access Control**: Ensure your Okta API credentials have appropriate permissions and are stored securely
4. **State Management**: Use remote state backend for team collaboration
5. **Change Management**: Review Terraform plans carefully before applying changes to production

## Example Directory Structure

```
.
├── main.tf          # Main module configuration
├── providers.tf     # Provider configuration
├── variables.tf     # Variable definitions
├── outputs.tf       # Output definitions
└── departments/     # Department-specific configurations
    ├── engineering.tf
    ├── sales.tf
    └── marketing.tf
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**: Ensure your OAuth 2.0 credentials are valid and have the required scopes
2. **Group Already Exists**: Check if a group with the same name already exists in Okta
3. **Rule Conflicts**: Verify that no conflicting group rules exist for the same user criteria
4. **Missing Groups**: Ensure all referenced group names (mailing, application, push) exist in your Okta organization

### Debug Commands

```bash
# Validate configuration
terraform validate

# Plan changes
terraform plan

# Show current state
terraform state list
terraform state show module.engineering_department.okta_group.department_group
```

## Contributing

When contributing to this module:
1. Follow Terraform best practices and style conventions
2. Update documentation for any new features or changes
3. Test changes in a non-production environment first
4. Submit pull requests with clear descriptions of changes

## License

[Specify your license here]

## Support

For issues or questions:
- Check existing issues in the repository
- Review Okta Terraform provider documentation
- Contact your organization's infrastructure team