# Terraform - CS API - AWS - CICD

## Build Status

| Branch | Status |
|:---:|:---:|
| master |[![CircleCI](https://circleci.com/gh/rb-org/cs-api-aws-cicd/tree/master.svg?style=svg&circle-token=c94de7fdc129aa41593c25aa5b8ddb0509470d9b)](https://circleci.com/gh/rb-org/cs-api-aws-cicd/tree/master)|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id | AWS Account ID | string | `""` | no |
| default\_tags | Map of default tags applied to all resources | map | `<map>` | no |
| region | AWS Region | string | `""` | no |
| remote\_state\_s3 |  | string | `"xyz-tfm-state"` | no |

## Outputs

| Name | Description |
|------|-------------|
| codebuild\_role\_arn |  |
| codebuild\_role\_name |  |
| codepipeline\_role\_arn |  |
| codepipeline\_role\_name |  |
