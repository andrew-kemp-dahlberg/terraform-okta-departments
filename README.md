# terraform-okta-departments

A Terraform module for managing Okta department groups with automatic user assignment based on the department attribute. This module creates department-specific groups and configures rules to automatically assign users to appropriate groups based on their department attribute.

## Features

- Creates Okta groups for departments with consistent naming (DEPT-{department_name})
- Automatically assigns users to department groups based on their `user.department` attribute
- Associates departments with existing mailing lists, application groups, and push groups
- Provides comprehensive outputs for all created and associated resources
- Supports custom profile attributes for enhanced group metadata

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| okta | ~> 4.13.1 |

## Usage

### Basic Example

```hcl
module "engineering_department" {
  source = "path/to/terraform-okta-departments"

  # Okta OAuth Configuration
  org_name       = "mycompany"
  base_url       = "okta.com"
  client_id      = var.okta_client_id
  private_key_id = var.okta_private_key_id
  private_key    = var.okta_private_key

  # Department Configuration
  department_name = "Engineering"
}
```

### Complete Example with Group Associations

```hcl
module "sales_department" {
  source = "path/to/terraform-okta-departments"

  # Okta OAuth Configuration
  org_name       = "mycompany"
  base_url       = "okta.com"
  client_id      = var.okta_client_id
  private_key_id = var.okta_private_key_id
  private_key    = var.okta_private_key

  # Department Configuration
  department_name = "Sales"
  
  # Associate with existing groups
  mailing_list_names = ["Sales-MailingList"]
  
  application_group_names = [
    "CRM-Users",
    "Sales-Dashboard-Access"
  ]
  
  push_group_names = ["Sales-Push-Group"]
  
  # Custom notes
  notes = "Sales department group - includes Inside Sales and Field Sales teams"
}
```

## Providers

| Name | Version |
|------|---------|
| okta | ~> 4.13.1 |

## Resources

The module creates the following resources:

- `okta_group.department_group` - The main department group
- `okta_group_rule.department_rule` - Automatic assignment rule for the department

The module also uses data sources to look up existing groups:

- `data.okta_group.mailing_groups` - Existing mailing list groups
- `data.okta_group.application_groups` - Existing application access groups
- `data.okta_group.push_groups` - Existing push notification groups

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client_id | OAuth 2.0 client ID for Okta API authentication. Must have okta.groups.manage and okta.groups.read scopes | `string` | n/a | yes |
| org_name | The Okta organization name (e.g., 'mycompany' for mycompany.okta.com) | `string` | n/a | yes |
| base_url | The Okta base URL (e.g., 'okta.com', 'oktapreview.com', 'okta-emea.com') | `string` | `"okta.com"` | no |
| private_key_id | The ID of the private key used for OAuth 2.0 authentication with Okta | `string` | n/a | yes |
| private_key | The private key (PEM format) used for OAuth 2.0 authentication with Okta | `string` | n/a | yes |
| department_name | The name of the department. This will be used in group naming and for matching user.department attribute | `string` | n/a | yes |
| mailing_list_names | List of existing Okta mailing group names to associate with the department | `list(string)` | `[]` | no |
| application_group_names | List of existing Okta application/role group names to associate with the department | `list(string)` | `[]` | no |
| push_group_names | List of existing Okta push group names to associate with the department | `list(string)` | `[]` | no |
| notes | Custom notes to add to the department group's profile | `string` | `"Group is managed by Terraform. Do not edit manually."` | no |

## Outputs

| Name | Description |
|------|-------------|
| department_group_id | The ID of the created department group |
| department_group_name | The name of the created department group |
| department_rule_id | The ID of the created department group rule |
| department_rule_name | The name of the created department group rule |
| department_rule_status | The status of the department group rule |
| mailing_group_ids | The IDs of associated mailing groups |
| mailing_group_names | The names of associated mailing groups |
| application_group_ids | The IDs of associated application groups |
| application_group_names | The names of associated application groups |
| push_group_ids | The IDs of associated push groups |
| push_group_names | The names of associated push groups |
| all_assigned_group_ids | All group IDs that users will be assigned to via the rule |
| custom_profile_attributes | The custom profile attributes assigned to the department group |

## How It Works

1. **Group Creation**: The module creates a department group with the naming convention `DEPT-{department_name}`
2. **Automatic Assignment**: A group rule is created that automatically assigns users to the department group when:
   - Their `user.department` attribute matches the specified department name
   - Their account is active (`user.active == true`)
3. **Group Associations**: Users in the department are also automatically added to any specified mailing lists, application groups, or push groups
4. **Custom Attributes**: The department group includes custom profile attributes that document the associated groups and notes

## Authentication

This module requires OAuth 2.0 authentication with Okta. You'll need:

1. An OAuth 2.0 application in Okta with the following scopes:
   - `okta.groups.manage`
   - `okta.groups.read`
2. A private key and key ID for JWT authentication

See the [Okta Terraform Provider documentation](https://registry.terraform.io/providers/okta/okta/latest/docs) for detailed authentication setup instructions.

## Development

### Dependencies

This project can install most dependencies automatically using a package manager:

* Windows: [Chocolatey](https://chocolatey.org/)
* MacOS: [Homebrew](https://brew.sh/)

Run `make install` to install most tools automatically.

> [!WARNING]
> [pre-commit](https://pre-commit.com/#install) and [Checkov](https://www.checkov.io/2.Basics/Installing%20Checkov.html) need to be installed manually on Windows.

### Pre-Commit Hooks

After cloning this repository, run `make precommit_install` to initialize pre-commit hooks.

### Available Make Commands

- `make chores` - Update documentation with Terraform-Docs and run automatic formatting
- `make test_security` - Run Trivy and Checkov security scans
- `make test_tflint` - Run TFLint for Terraform linting
- `make fix_tflint` - Automatically fix TFLint issues (review changes before committing)
- `make documentation` - Generate documentation using terraform-docs

## Examples

See the [examples](./examples) directory for complete usage examples:

- [Basic](./examples/basic) - Simple department setup
- [Complete](./examples/complete) - Advanced setup with multiple departments and group associations

## License

[Specify your license]