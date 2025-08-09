# Basic Example - Okta Departments Module

This example demonstrates the basic usage of the Okta Departments module to create a simple department group with automatic user assignment.

## What This Example Creates

- A department group named `DEPT-Engineering`
- An automatic assignment rule that adds users to the group when their `user.department` attribute equals "Engineering"
- Custom profile attributes marking the group as Terraform-managed

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

## Outputs

After applying, you'll see:
- `department_group_id` - The ID of the created department group
- `department_group_name` - The name of the department group (DEPT-Engineering)
- `department_rule_id` - The ID of the automatic assignment rule
- `department_rule_name` - The name of the assignment rule

## Clean Up

To remove all resources created by this example:
```bash
terraform destroy
```