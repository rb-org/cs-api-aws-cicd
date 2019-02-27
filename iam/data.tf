# Data Resources

data "aws_ssm_parameter" "kubeconfig" {
  name            = "/${var.kubeconfig_path}"
  with_decryption = false
}
