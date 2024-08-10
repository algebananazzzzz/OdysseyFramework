terraform {
  backend "s3" {
    bucket               = "{{.GlobalConfig.BackendConfig.bucket}}"
    key                  = "{{.Code}}"
    workspace_key_prefix = "{{.GlobalConfig.BackendConfig.workspace_key_prefix}}"
    region               = "{{.GlobalConfig.BackendConfig.region}}"
  }
}
