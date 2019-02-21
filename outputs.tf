# Outputs

output "codepipeline_role_name" {
  value = "${module.iam.codepipeline_role}"
}

output "codepipeline_role_arn" {
  value = "${module.iam.codepipeline_role_arn}"
}

output "codebuild_role_name" {
  value = "${module.iam.codebuild_role}"
}

output "codebuild_role_arn" {
  value = "${module.iam.codebuild_role_arn}"
}
