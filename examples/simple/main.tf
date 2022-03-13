module "ssm_parameters" {
  source = "../.."
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
