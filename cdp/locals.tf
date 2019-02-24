locals {
  name_prefix      = "${terraform.workspace}"
  cdp_name         = "${local.name_prefix}-cdp-${var.app_name}"
  cdp_webhook_name = "${local.name_prefix}-cdp-webhook-${var.app_name}"
  cdb_project_name = "${local.name_prefix}-cdb-${var.app_name}"

  db_ports = {
    mysql = "3306"
    mssql = "1433"
  }

  webhook_secret = "${random_string.webhook_secret.result}"
}
