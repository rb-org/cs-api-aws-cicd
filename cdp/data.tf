# Data Resources

data "aws_ssm_parameter" "db_endpoint" {
  name            = "${var.ssm_db_endpoint}"
  with_decryption = true
}

data "aws_ssm_parameter" "db_name" {
  name            = "${var.ssm_db_name}"
  with_decryption = true
}

data "aws_ssm_parameter" "cs_api_user_name" {
  name            = "${var.ssm_cs_api_user_name}"
  with_decryption = true
}

data "aws_ssm_parameter" "cs_api_user_pass" {
  name            = "${var.ssm_cs_api_user_pass}"
  with_decryption = true
}

resource "random_string" "webhook_secret" {
  length  = 16
  special = true
}
