module "s3" {
  source = "./s3"

  account_id = "${data.aws_caller_identity.current.account_id}"

  # Tags
  default_tags = "${var.default_tags}"
}

module "iam" {
  source = "./iam"

  app_name        = "${var.app_name}"
  s3_cicd_arn     = "${module.s3.cicd_arn}"
  ecr_arn         = "${data.terraform_remote_state.cs_api_ecr.cs_api_ecr_arn}"
  account_id      = "${data.aws_caller_identity.current.account_id}"
  region          = "${data.aws_region.current.name}"
  eks_cluster_arn = "${data.terraform_remote_state.cs_api_eks.eks_cluster_arn}"
  kubeconfig_path = "${data.terraform_remote_state.cs_api_eks.kubeconfig_path}"
}

module "notify" {
  source = "./notify"

  account_id = "${data.aws_caller_identity.current.account_id}"

  # Codebuild 
  codebuild_prj_arn  = "${module.cdp.cdb_arn}"
  codebuild_role_arn = "${module.iam.codebuild_role_arn}"

  # Notifications
  slack_webhook = "${var.aws2slack_webhook}"

  # Tags
  default_tags = "${var.default_tags}"
}

module "cdp" {
  source = "./cdp"

  # CS API
  app_name = "${var.app_name}"

  # RDS 
  db_engine            = "${data.terraform_remote_state.cs_api_rds.db_engine}"
  ssm_db_endpoint      = "${data.terraform_remote_state.cs_api_rds.rds_db_name}"
  ssm_db_name          = "${data.terraform_remote_state.cs_api_rds.rds_db_endpoint}"
  ssm_cs_api_user_name = "${data.terraform_remote_state.cs_api_rds.cs_api_db_user_name}"
  ssm_cs_api_user_pass = "${data.terraform_remote_state.cs_api_rds.cs_api_db_user_pass}"

  # ECR
  cs_api_repository_url = "${data.terraform_remote_state.cs_api_ecr.cs_api_repository_url}"

  # IAM
  codepipeline_role_arn = "${module.iam.codepipeline_role_arn}"
  codebuild_role_arn    = "${module.iam.codebuild_role_arn}"

  # S3
  s3_cicd_bucket = "${module.s3.cicd_id}"
  s3_cicd_arn    = "${module.s3.cicd_arn}"

  # Github
  github_org   = "${var.github_org}"
  github_repo  = "${var.github_repo}"
  github_token = "${var.github_token}"

  # Tags
  default_tags = "${var.default_tags}"

  # EKS
  kubeconfig_path = "${data.terraform_remote_state.cs_api_eks.kubeconfig_path}"
  cluster_region  = "${data.terraform_remote_state.cs_api_eks.eks_cluster_region}"
  cluster_name    = "${data.terraform_remote_state.cs_api_eks.eks_cluster_name}"
}
