# S3 Bucket for CodePipeline Outputs

resource "aws_s3_bucket" "cicd" {
  bucket = "${local.bucket_name}"
  acl    = "private"

  versioning {
    enabled = "${var.enable_versioning}"
  }

  lifecycle_rule {
    enabled = "${var.enable_lifecycle_rule}"

    expiration {
      days = "${var.expiration_days}"
    }
  }

  tags = "${merge(
    var.default_tags, 
    map(
      "Name", "${local.bucket_name}",
      "Workspace", "${terraform.workspace}"
    )
  )}"
}

resource "aws_s3_bucket_object" "output" {
  bucket     = "${local.bucket_name}"
  key        = "output/"
  source     = "/dev/null"
  depends_on = ["aws_s3_bucket.cicd"]
}

resource "aws_s3_bucket_object" "cache" {
  bucket     = "${local.bucket_name}"
  key        = "cache/"
  source     = "/dev/null"
  depends_on = ["aws_s3_bucket.cicd"]
}
