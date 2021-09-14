resource "aws_s3_bucket" "assets" {
  bucket = var.name
  acl    = "private"

  tags = {
    Environment = var.env
  }
}

resource "aws_iam_user" "s3_asset_access" {
  name = var.name

  tags = {
    Environment = var.env
  }
}

resource "aws_iam_access_key" "s3_asset_access" {
  user = aws_iam_user.s3_asset_access.name
}


data "aws_iam_policy_document" "s3_asset_access" {
  statement {
    sid = "1"

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
    ]

    resources = [
      aws_s3_bucket.assets.arn,
    ]
  }

  statement {
    sid = "2"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "${aws_s3_bucket.assets.arn}/*",
    ]
  }
}

resource "aws_iam_user_policy" "s3_asset_access" {
  name = "s3_access"
  user = aws_iam_user.s3_asset_access.name
  policy = data.aws_iam_policy_document.s3_asset_access.json
}