resource "aws_kms_key" "ekskms" {
  description = "eks kms key"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {"AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"},
            "Action": "kms:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.infra_id}-${var.env}-${var.cluster}"
  target_key_id = aws_kms_key.ekskms.id

  depends_on = [aws_kms_key.ekskms]
}

data "aws_kms_alias" "eks" {
  name = "alias/${var.infra_id}-${var.env}-${var.cluster}"

  depends_on = [aws_kms_alias.alias]
}