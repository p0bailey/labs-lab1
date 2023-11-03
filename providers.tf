terraform {
  required_version = "~> 1.6.0"
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.9.1"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.39.0"
    }
  }
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}
provider "github" {
  token = var.github_token
  owner = var.github_owner
}
