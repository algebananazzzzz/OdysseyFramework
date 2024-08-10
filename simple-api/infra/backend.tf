terraform {
  backend "s3" {
    bucket               = "com-all-bucket-tfstate-algebananazzzzz"
    key                  = "simple-api.tfstate"
    workspace_key_prefix = "tf-state"
    region               = "ap-southeast-1"
  }
}
