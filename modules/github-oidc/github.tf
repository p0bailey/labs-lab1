resource "github_repository" "this" {
  name       = var.workspace
  visibility = "private"
  auto_init  = true

}

output "git_repo" {
  value = github_repository.this.full_name
}

data "github_repository" "this" {
  full_name = github_repository.this.full_name
}

resource "github_actions_secret" "secrets" {
  for_each = {
    "VAULT_URL"              = var.vault_address
    "VAULT_ROLE"             = var.workspace
    "AWS_SECRET_ENGINE_PATH" = var.workspace
  }
  secret_name     = each.key
  plaintext_value = each.value
  repository      = data.github_repository.this.name
}

resource "github_branch" "development" {
  count      = var.deploy_terraform_demo ? 1 : 0
  repository = data.github_repository.this.name
  branch     = "development"
}

resource "github_repository_file" "workflow_vault" {
  repository          = data.github_repository.this.name
  branch              = "development"
  commit_message      = "Update Github Actions Vault workflow"
  overwrite_on_create = true
  file                = ".github/workflows/vault.yml"

  content = templatefile("${path.module}/workflows/vault.yaml", {
    github_runner = var.github_runner
  })
  depends_on = [
    github_branch.development
  ]
}

resource "github_repository_file" "provider_dev" {
  count               = var.deploy_terraform_demo ? 1 : 0
  repository          = data.github_repository.this.name
  branch              = "development"
  commit_message      = "Update Github Actions Terraform code"
  overwrite_on_create = true
  file                = "provider.tf"
  content = templatefile("${path.module}/workflows/provider.tf", {
    workspace        = var.workspace
    statefile_bucket = var.statefile_bucket
    region           = var.region
  })
  depends_on = [
    github_branch.development
  ]
}

resource "github_repository_file" "terraform_demo" {
  count               = var.deploy_terraform_demo ? 1 : 0
  repository          = data.github_repository.this.name
  branch              = "development"
  commit_message      = "Update Github Actions Terraform code"
  overwrite_on_create = true
  file                = "main.tf"
  content = templatefile("${path.module}/workflows/main.tf", {
    workspace        = var.workspace
    statefile_bucket = var.statefile_bucket
    region           = var.region
  })

  depends_on = [
    github_branch.development
  ]
}
