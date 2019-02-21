locals {
  cdp_role_name = "${terraform.workspace}-cdp-role"
  cdb_role_name = "${terraform.workspace}-cdb-role"
}

# https://www.terraform.io/docs/providers/aws/r/codepipeline.html


# read perms (get) to builds bucket


# write perms (get put list) to logging bucket


# s3:*

