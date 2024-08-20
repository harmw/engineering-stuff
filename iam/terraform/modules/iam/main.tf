resource "aws_iam_group" "default" {
  name = "${var.name}${var.suffix}"
}

resource "aws_iam_user" "default" {
  name = "${var.name}${var.suffix}"
  path = "/system/"

  tags = {
    tag-key = "provisioner:terraform"
  }
}

resource "aws_iam_user_group_membership" "default" {
  user = aws_iam_user.default.name

  groups = [
    aws_iam_group.default.name,
  ]
}

resource "aws_iam_role_policy" "default" {
  name = "${var.name}${var.suffix}"
  role = aws_iam_role.default.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = []
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role" "default" {
  name = "${var.name}${var.suffix}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "sts.amazonaws.com"
        }
      },
    ]
  })
}
