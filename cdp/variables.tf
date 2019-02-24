# Variables
variable "default_tags" {
  type = "map"
}

variable "codepipeline_role_arn" {}
variable "codebuild_role_arn" {}

variable "s3_cicd_bucket" {}
variable "s3_cicd_arn" {}

variable "github_org" {}
variable "github_repo" {}

variable "github_repo_branch" {
  default = "master"
}

variable "github_token" {}

variable "db_engine" {}

variable "ssm_db_endpoint" {}

variable "ssm_db_name" {}

variable "ssm_cs_api_user_name" {}

variable "ssm_cs_api_user_pass" {}
