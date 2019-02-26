# Variables
variable "default_tags" {
  type = "map"
}

variable "region" {}

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

# Codebuild

variable "cdb_compute" {
  default = "BUILD_GENERAL1_SMALL"
}

variable "cdb_image" {
  default = "aws/codebuild/python:3.6.5"
}

variable "cdb_image_type" {
  default = "LINUX_CONTAINER"
}

variable "cs_api_port" {
  default = 5000
}

# ECR
variable "cs_api_repository_url" {}

variable "image_version" {
  default = "latest"
}

# CS API
variable "app_name" {}

# EKS 
variable "kubeconfig_path" {}

variable "cluster_region" {}
variable "cluster_name" {}
