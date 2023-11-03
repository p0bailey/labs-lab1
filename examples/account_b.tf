resource "aws_iam_role" "poweruser_role_account_b" {
  name = "PowerUserAccountB"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          "AWS": "arn:aws:iam::{33333333333}:role/Vault"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "poweruser_attachment" {
  role       = aws_iam_role.poweruser_role.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

