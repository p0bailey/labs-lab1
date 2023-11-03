# Define a map between AWS accounts and IAM roles 
variable "account_role_map" {
  description = "Mapping AWS account numbers to target accounts role names"
  type        = map(string)
  default = {
    "111111111111" = "PowerUserAccountA",
    "222222222222" = "PowerUserAccountB"
  }
}
# Generates the for loop to iterate through accounts and roles 
locals {
  generated_arns = [for acc, role in var.account_role_map : "arn:aws:iam::${acc}:role/${role}"]
}


# Define the trust relationship for Vault EC2 using aws_iam_policy_document
data "aws_iam_policy_document" "ec2_vault_trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Define an IAM policy for EC2 using aws_iam_policy_document
data "aws_iam_policy_document" "ec2_vault_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = local.generated_arns
  }
}

# Create an EC2 IAM role with the trust relationship
resource "aws_iam_role" "ec2_vault_role" {
  name               = "ec2-vault-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_vault_trust_policy.json
}

# Create the IAM policy using the policy document
resource "aws_iam_policy" "ec2_vault_policy" {
  name        = "ec2-vault-policy"
  description = "An example policy for EC2 instances"
  policy      = data.aws_iam_policy_document.ec2_vault_policy_document.json
}

# Attach the IAM policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_vault_policy_attach" {
  role       = aws_iam_role.ec2_vault_role.name
  policy_arn = aws_iam_policy.ec2_vault_policy.arn
}

