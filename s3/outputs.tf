output "cicd_id" {
  value = "${aws_s3_bucket.cicd.id}"
}

output "cicd_arn" {
  value = "${aws_s3_bucket.cicd.arn}"
}
