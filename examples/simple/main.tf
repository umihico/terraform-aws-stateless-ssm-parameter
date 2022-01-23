resource "aws_kms_key" "sample" {
  description         = "stateless-ssm-parameter-sample-master-key"
  enable_key_rotation = true
  is_enabled          = true
}

resource "aws_kms_alias" "sample" {
  name          = "alias/stateless-ssm-parameter-sample"
  target_key_id = aws_kms_key.sample.key_id
}

module "ssm_parameters" {
  source = "../.."
  parameters = [
    {
      name            = "stateless-ssm-parameters-demo-aws-access-key-id"
      encrypted_value = "AQICAHhagoO2WfJ8W544wyeIhy6uH5BVh+foRUiIL+aHTBasWAEerJxJ916nQiZZ/iyG1R/QAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMwkGbReMOfMz1hskbAgEQgC/06wdTixGxA1JXjv5P2Wsc3cWQDrga6Fr812KWShIrzkqkQuu1Eh9wQu+/SaYkOQ=="
      # plain text is AKIAIOSFODNN7EXAMPLE
    },
    {
      name            = "stateless-ssm-parameters-demo-aws-access-secret-key"
      encrypted_value = "AQICAHhagoO2WfJ8W544wyeIhy6uH5BVh+foRUiIL+aHTBasWAErLRzCt7+7fB70huDHz2dXAAAAhzCBhAYJKoZIhvcNAQcGoHcwdQIBADBwBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDOCJ2grtpOxNiQ8lhwIBEIBDhm+XF+Ij/b7mgpjnHB0ERjc7J7bXQLXfuZ/JB94sy45aKpAcihP8aK7jBa2nsifO9pVd9j7L/N4f9WxdXKGp9r75yw=="
      # plain text is wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    },
  ]
}
