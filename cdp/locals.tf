locals {
  name_prefix      = "${terraform.workspace}"
  cdp_name         = "${local.name_prefix}-cdp-cs-api"
  cdp_webhook_name = "${local.name_prefix}-cdp-webhook-cs-api"
  cdb_project_name = "${local.name_prefix}-cdb-cs-api"

  db_ports = {
    mysql = "3306"
    mssql = "1433"
  }

  webhook_secret = "${random_string.webhook_secret.result}"
}
