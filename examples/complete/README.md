# Complete Example - Okta Departments Module

This example demonstrates a comprehensive usage of the Okta Departments module with multiple departments and group integrations.

## What This Example Creates

### Example Groups (for demonstration)
- `Sales-MailingList` - Mailing list for Sales communications
- `CRM-Users` - Application group for CRM access
- `Sales-Dashboard-Access` - Application group for Sales Dashboard
- `Sales-Push-Group` - Okta Verify push notification group

### Department Groups
1. **Sales Department**
   - Group: `DEPT-Sales`
   - Integrated with all example groups above
   - Custom notes describing the team structure
   - Automatic assignment rule for users with `department = "Sales"`

2. **Marketing Department**
   - Group: `DEPT-Marketing`
   - Shares CRM access with Sales
   - Custom notes describing the team structure
   - Automatic assignment rule for users with `department = "Marketing"`

## Key Features Demonstrated

- **Group Integration**: Shows how to link existing groups (mailing lists, app groups, push groups)
- **Multiple Departments**: Demonstrates creating multiple departments in one configuration
- **Shared Resources**: Marketing and Sales share CRM access
- **Custom Metadata**: Custom notes and profile attributes for each department
- **Dependencies**: Proper dependency management between resources

## Usage

1. Create a `terraform.tfvars` file with your Okta credentials:
   ```hcl
   org_name       = "your-org"
   client_id      = "your-client-id"
   private_key_id = "your-private-key-id"
   private_key    = <<-EOT
   -----BEGIN RSA PRIVATE KEY-----
   your-private-key-content
   -----END RSA PRIVATE KEY-----
   EOT
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the planned changes:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

## How It Works

When a user's `department` attribute is set to "Sales":
1. They are automatically added to `DEPT-Sales`
2. They are also added to:
   - `Sales-MailingList` (for department communications)
   - `CRM-Users` (for CRM application access)
   - `Sales-Dashboard-Access` (for dashboard access)
   - `Sales-Push-Group` (for Okta Verify)

When a user's `department` attribute is set to "Marketing":
1. They are automatically added to `DEPT-Marketing`
2. They are also added to:
   - `CRM-Users` (shared with Sales)

## Outputs

The example provides detailed outputs including:
- Department group IDs and names
- All assigned group IDs for each department
- Custom profile attributes showing the metadata
- IDs of all example groups created

## Clean Up

To remove all resources created by this example:
```bash
terraform destroy
```

**Note**: This will delete all groups created by this example. Ensure no users depend on these groups before destroying.