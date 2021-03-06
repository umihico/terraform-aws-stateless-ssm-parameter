# stateless-ssm-parameter

Terraform module which creates ssm paratemers without leaking raw values on git and tfstates

## Usage

```hcl
module "ssm_parameters" {
  source = "umihico/stateless-ssm-parameter/aws"
  parameters = [
    {
      name            = "stateless-ssm-parameters-demo-aws-access-key-id"
      encrypted_value = "AQICAHhknPcMN2mPQjlgkKH9EhrUk79o+4j1nUtJMmNPXkAKWgHMyR2vUsqH8wKITgQmgvysAAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMGIi7bRe0nfMJk4LHAgEQgC+8pD0sNt3aXQ97B7mAenZLWSTa9xrUYxEObS0c6M5PcJsUY96yPqpWR8d11rkk1w=="
      # plain text is AKIAIOSFODNN7EXAMPLE
    },
    {
      name            = "stateless-ssm-parameters-demo-aws-access-secret-key"
      encrypted_value = "AQICAHhknPcMN2mPQjlgkKH9EhrUk79o+4j1nUtJMmNPXkAKWgFJO3StxQSrfvTKupiSxQ9fAAAAhzCBhAYJKoZIhvcNAQcGoHcwdQIBADBwBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDA+oQzzMdeJwKG35QwIBEIBD14aLRt9gKfEBZjiCL1/QfbmhPqknTM3lo7MCoj7vKHWxqir4x0Gafylx/piwspv40i+3523obtUfWiN0dxhJXdsG5g=="
      # plain text is wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    },
  ]
}
```

## Benefits

- Parameters are encrypted and version controllable by git
- **Original values will be never contained and leak from tfstate**
- Only ARNs and names, such insensitive values are referenceable for [ECS enviroment variable reference](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/specifying-sensitive-data-parameters.html).

## How to encrypt

```bash
# encrypting value 'AKIAIOSFODNN7EXAMPLE'
aws kms encrypt \
 --key-id alias/stateless-ssm-parameter-sample \
 --plaintext "$(echo -n 'AKIAIOSFODNN7EXAMPLE' | base64)" \
 --output text \
 --query CiphertextBlob
```

If you don't have kms key or alias yet, please create like below.

```bash
# with terraform
resource "aws_kms_key" "sample" {
  description         = "stateless-ssm-parameter-sample-master-key"
  enable_key_rotation = true
  is_enabled          = true
}

resource "aws_kms_alias" "sample" {
  name          = "alias/stateless-ssm-parameter-sample"
  target_key_id = aws_kms_key.sample.key_id
}

# with aws cli
aws kms create-alias --alias-name "alias/stateless-ssm-parameter-sample2" --target-key-id $(aws kms create-key --output text --query "KeyMetadata.KeyId" --description "stateless-ssm-parameter-sample2-master-key")
```

## Inputs

| Name       | Description                                                                                                                                                                                                                | Type                                                                              | Default     | Required |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | ----------- | :------: |
| parameters | Takes name(s) and encrypted_value(s) as same as [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) takes name and value                                        | `<pre>list(object({<br> name = string<br> encrypted_value = string<br> }))</pre>` | -           |   yes    |
| region     | Optional, and detected region by terraform will be used without this                                                                                                                                                       | `string`                                                                          | `null`      |    no    |
| profile    | If terraform works with named profile, you need to specify same one here, or if the name is personal, you can overwrite by TF_VARS without commiting it like this. `TF_VAR_STATELESS_SSM_PROFILE=profile2 terraform apply` | `string`                                                                          | `"default"` |    no    |

## Outputs

| Name               |                                                                                      Description                                                                                       |
| ------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
| aws_ssm_parameters | Returns list of arn, name, type and value(encrypted) as same as [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) returns |
