output "aws_key_id" {
  value = aws_iam_access_key.s3_asset_access.id
}

output "aws_key_secret" {
  value = aws_iam_access_key.s3_asset_access.secret
  sensitive = true
}

output "bucket" {
  value = aws_s3_bucket.assets.bucket
}