data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::33333333333:role/Vault"]
    }
  }
}

resource "aws_iam_role" "poweruser_role_account_a" {
  name               = "PowerUserAccountA"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "poweruser_attachment" {
  role       = aws_iam_role.poweruser_role_account_a.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
