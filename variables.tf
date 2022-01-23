variable "parameters" {
  description = "parameters"
  default     = null
  type        = list(map(string))
}

variable "region" {
  description = "Default region terraform deteced will be used without specifying this variable."
  default     = null
  type        = string
}

variable "profile" {
  description = "You can specify a profile or 'default' will be used regardless of terraform's current profile."
  default     = null
  type        = string
}

variable "STATELESS_SSM_PROFILE" {
  description = "You can set your personal profile by doing 'TF_VAR_STATELESS_SSM_PROFILE=profile2 terraform apply'. This will overwrite var.profile."
  default     = "default"
  type        = string
}

variable "exec_log_suppresser" {
  # https://github.com/hashicorp/terraform/pull/26611
  description = "Preventing logging generated raw cli commands which include decrypted plain parameters."
  type        = string
  default     = "foo"
  sensitive   = true
}
