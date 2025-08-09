# Terraform Okta Departments Module Examples

This directory contains examples showing how to use the Okta Departments module in various configurations.

## Examples

### Basic Example

The [basic example](./basic) demonstrates the simplest usage of the module to create a department group with automatic user assignment.

### Complete Example

The [complete example](./complete) shows a more comprehensive configuration including:
- Integration with existing mailing lists
- Application group associations
- Push group connections
- Custom notes and metadata

## Running the Examples

1. Navigate to the example directory:
   ```bash
   cd examples/basic
   # or
   cd examples/complete
   ```

2. Create a `terraform.tfvars` file with your Okta credentials:
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

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Important Notes

- Ensure your OAuth 2.0 application has the required scopes: `okta.groups.manage` and `okta.groups.read`
- The examples assume you're running them from within the example directory
- Always review the plan output before applying changes to production environments