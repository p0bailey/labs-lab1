module "github_oidc_aws" {
  source                = "./modules/github-oidc/"
  workspace             = var.workspace
  role_arns             = var.role_arns
  github_owner          = var.github_owner
  vault_address         = var.vault_address
  statefile_bucket      = var.statefile_bucket
  region                = var.region
  deploy_terraform_demo = var.deploy_terraform_demo
  github_runner         = var.github_runner
  vault_token           = var.vault_token
  github_token          = var.github_token
}
