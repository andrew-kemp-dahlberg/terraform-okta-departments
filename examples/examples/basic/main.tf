terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.13.1"
    }
  }
  required_version = "~> 1.0"
}

# Replace these variables with the ones for your tests.
variable "test_input" {
  type    = string
  default = "test"
}

# Pass in any variables that the module requires.
# If your module has a `name` field don't forget to add some randomness.
module "basic_example" {
  source = "../../"
  input = var.test_input
}

# Replace this output with the one for your tests.
output "test_output" {
  value = module.basic_example.output
}
