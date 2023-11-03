resource "vault_aws_secret_backend" "this" {
  path                      = var.workspace
  default_lease_ttl_seconds = var.default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.max_lease_ttl_seconds
}

resource "vault_aws_secret_backend_role" "aws_secret_backend_role" {
  backend         = vault_aws_secret_backend.this.path
  name            = var.workspace
  credential_type = "assumed_role"
  role_arns       = [var.role_arns]
}

