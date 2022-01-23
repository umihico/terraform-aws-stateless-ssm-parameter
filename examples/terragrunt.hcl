locals {
  backend_path = "terraform-backend-${run_cmd("aws", "sts", "get-caller-identity", "--query", "Account", "--output", "text")}-stateless-ssm-parameter"
}

remote_state {
  backend = "s3"
  generate = {
    path              = "remote_state_override.tf"
    if_exists         = "overwrite"
    disable_signature = true
  }
  config = {
    region               = "ap-northeast-1"
    bucket               = local.backend_path
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    encrypt              = true
    workspace_key_prefix = "workspaces"
    dynamodb_table       = local.backend_path
  }
}

generate "provider" {
  path              = "provider_override.tf"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<EOF
provider "aws" {
  region  = "ap-northeast-1"
}
EOF
}
