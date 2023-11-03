variable "region" {}

variable "statefile_bucket" {}

variable "deploy_terraform_demo" {}

variable "role_arns" {}

variable "workspace" {}

variable "vault_address" {}

variable "github_owner" {}

variable "vault_token" {}

variable "github_token" {}

variable "github_runner" {
  description = "Determines whether the Github runner is self-hosted in your VPC or runs on GitHub platform"
  type        = string
}

