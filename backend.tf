terraform {
  required_version = "~>0.11.11"

  backend "s3" {
    bucket                  = "xyz-tfm-state"
    region                  = "eu-west-1"
    key                     = "cs-api-cicd.tfstate"
    encrypt                 = "true"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "default"
  }
}

data "terraform_remote_state" "cs_api_base" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_s3}"
    region = "eu-west-1"
    key    = "env:/${terraform.workspace}/cs-api-base.tfstate"
  }
}

data "terraform_remote_state" "cs_api_ecr" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_s3}"
    region = "eu-west-1"
    key    = "env:/${terraform.workspace}/cs-api-ecr.tfstate"
  }
}

data "terraform_remote_state" "cs_api_rds" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_s3}"
    region = "eu-west-1"
    key    = "env:/${terraform.workspace}/cs-api-rds.tfstate"
  }
}
