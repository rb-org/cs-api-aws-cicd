module "s3" {
  source = "./s3"

  account_id = "${data.aws_caller_identity.current.account_id}"

  # Tags
  default_tags = "${var.default_tags}"
}

module "iam" {
  source = "./iam"

  s3_cicd_arn = "${module.s3.cicd_arn}"
}
