locals {
  name_prefix = "${terraform.workspace}"
  bucket_name = "${local.name_prefix}-cs-api-cicd-${var.account_id}"
}
