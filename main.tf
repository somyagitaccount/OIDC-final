resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"  # Example URL, ensure this is correct
  client_id_list  = ["sts.amazonaws.com"]  # Client ID for assuming the role
  thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "custom_trust_policy_role" {
  name = "custom_trust_policy_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_actions.arn
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
          },
          StringLike = {
            "token.actions.githubusercontent.com:sub": "repo:somyagitaccount/OIDC-final:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "full_access_policy" {
  name        = "full_access_policy"
  description = "Policy granting full access to everything"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_full_access_policy" {
  role       = aws_iam_role.custom_trust_policy_role.name
  policy_arn = aws_iam_policy.full_access_policy.arn
}
