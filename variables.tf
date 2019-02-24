variable "region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "account_id" {
  description = "AWS Account ID"
  default     = ""
}

variable "default_tags" {
  type        = "map"
  description = "Map of default tags applied to all resources"

  default = {
    Github-Repo = "rb-org/cs-api-aws-cicd"
    Terraform   = "true"
  }
}

variable "remote_state_s3" {
  default = "xyz-tfm-state"
}

# Github
variable "github_org" {
  default = "rb-org"
}

variable "github_repo" {
  default = "cs-api-app"
}

variable "github_token" {}
