variable "region" {
  description = "Default AWS region"
  type        = string
}

variable "statefile_bucket" {
  description = "AWS S3 bucket where to store terraform statefile."
  type        = string
}

variable "workspace" {
  description = "Defines the whole structure and segretates pipelines, secrets and environments"
  type        = string
}

variable "vault_address" {
  description = "Address of the vault server"
  type        = string
}

variable "github_token" {}

variable "vault_token" {
  description = "Address of the vault server"
  type        = string
}

variable "github_owner" {
  description = "This is the target GitHub organization or individual user account to manage."
  type        = string
}

variable "github_runner" {
  description = "Determines whether the Github runner is self-hosted in your VPC or runs on GitHub platform"
  type        = string
}

variable "deploy_terraform_demo" {
  description = "Determines whether to lauch terraform code from the demo pipeline"
  type        = bool
}

# JWT Variables

variable "jwt_mount" {
  description = "JWT mount point"
  type        = string
  default     = "jwt"
}

variable "jwt_token_max_ttl" {
  type        = number
  description = "The maximum lifetime for generated tokens in number of seconds."
  default     = 600
}

variable "jwt_path" {
  type        = string
  description = "JWT  Path"
  default     = "jwt"
}

# aws secret engine variables

variable "default_lease_ttl_seconds" {
  description = "The default TTL for credentials issued by AWS Secret engine"
  default     = "300"
}

variable "max_lease_ttl_seconds" {
  description = "The maximum TTL that can be requested  by AWS Secret engine"
  default     = "3600"
}

variable "role_arns" {
  description = "Specifies the ARNs of the AWS roles this Vault role is allowed to assume. Required when credential_type is assumed_role and prohibited otherwise."
}

