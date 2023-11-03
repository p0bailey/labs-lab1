resource "vault_jwt_auth_backend_role" "example" {
  backend           = "jwt"
  role_name         = var.workspace
  token_policies    = [var.workspace]
  token_max_ttl     = var.jwt_token_max_ttl
  bound_audiences   = ["https://github.com/${var.github_owner}"]
  bound_claims_type = "glob"
  bound_claims      = { "sub" = "repo:${var.github_owner}/${var.workspace}:ref:refs/*" }
  user_claim        = "workflow"
  role_type         = "jwt"
}

data "vault_policy_document" "this" {
  rule {
    path         = "${var.workspace}/creds/*"
    capabilities = ["read"]
    description  = "Allow to read aws secret engine path and generate STS credentials"
  }
}

resource "vault_policy" "this" {
  name   = var.workspace
  policy = data.vault_policy_document.this.hcl
}
