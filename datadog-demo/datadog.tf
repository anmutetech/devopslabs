# Create a new Datadog - Amazon Web Services integration
resource "datadog_integration_aws" "sandbox" {
  account_id  = data.aws_caller_identity.current.account_id
  role_name   = "DatadogAWSIntegrationRole"
  account_specific_namespace_rules = {
    auto_scaling = false
    opsworks     = false
  }
}