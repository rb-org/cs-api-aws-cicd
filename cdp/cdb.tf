resource "aws_codebuild_project" "cs_api" {
  name          = "${local.cdb_project_name}"
  description   = "CS API CodeBuild Project"
  build_timeout = "5"
  service_role  = "${var.codebuild_role_arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${var.s3_cicd_arn}"
  }

  environment {
    compute_type    = "${var.cdb_compute}"
    image           = "${var.cdb_image}"
    type            = "${var.cdb_image_type}"
    privileged_mode = true                    # To be able to run a container within a container

    environment_variable {
      "name"  = "db_user"
      "value" = "${data.aws_ssm_parameter.cs_api_user_name.value}"
    }

    environment_variable {
      "name"  = "db_password"
      "value" = "${data.aws_ssm_parameter.cs_api_user_pass.value}"
    }

    environment_variable {
      "name"  = "db_address"
      "value" = "${data.aws_ssm_parameter.db_endpoint.value}"
    }

    environment_variable {
      "name"  = "db_database"
      "value" = "${data.aws_ssm_parameter.db_name.value}"
    }

    environment_variable {
      "name"  = "db_port"
      "value" = "${local.db_ports[var.db_engine]}"
    }

    environment_variable {
      "name"  = "db_type"
      "value" = "${var.db_engine}"
    }

    environment_variable {
      "name"  = "image_repo_url"
      "value" = "${var.cs_api_repository_url}"
    }

    environment_variable {
      "name"  = "image_version"
      "value" = "${var.image_version}"
    }
  }

  source {
    type = "CODEPIPELINE"
  }

  tags = "${merge(var.default_tags, map(
      "Name", "${local.cdb_project_name}"
    ))}"
}
