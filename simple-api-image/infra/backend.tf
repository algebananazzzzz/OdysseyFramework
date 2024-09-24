terraform {
  backend "s3" {
    bucket               = "{{.GlobalConfig.BackendConfig.Bucket}}"
    key                  = "{{.Code}}"
    workspace_key_prefix = "{{.GlobalConfig.BackendConfig.WorkspaceKeyPrefix}}"
    region               = "{{.GlobalConfig.BackendConfig.Region}}"
  }
}
