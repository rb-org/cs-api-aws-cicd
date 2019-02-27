# Outputs

output "cdb_arn" {
  value = "${aws_codebuild_project.cs_api.arn}"
}
