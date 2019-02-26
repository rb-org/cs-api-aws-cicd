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
    location = "${var.s3_cicd_bucket}/cache"
  }

  environment {
    compute_type    = "${var.cdb_compute}"
    image           = "${var.cdb_image}"
    type            = "${var.cdb_image_type}"
    privileged_mode = true                    # To be able to run a container within a container

    environment_variable {
      "name"  = "db_user"
      "value" = "${data.aws_ssm_parameter.cs_api_user_name.name}"
      "type"  = "PARAMETER_STORE"
    }

    environment_variable {
      "name"  = "db_password"
      "value" = "${data.aws_ssm_parameter.cs_api_user_pass.name}"
      "type"  = "PARAMETER_STORE"
    }

    environment_variable {
      "name"  = "db_address"
      "value" = "${data.aws_ssm_parameter.db_endpoint.name}"
      "type"  = "PARAMETER_STORE"
    }

    environment_variable {
      "name"  = "db_database"
      "value" = "${data.aws_ssm_parameter.db_name.name}"
      "type"  = "PARAMETER_STORE"
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

    environment_variable {
      "name"  = "cs_api_port"
      "value" = "${var.cs_api_port}"
    }

    environment_variable {
      "name"  = "kubeconfig"
      "value" = "${data.aws_ssm_parameter.kubeconfig.name}"
    }

    environment_variable {
      "name"  = "cluster_region"
      "value" = "${var.cluster_region}"
    }

    environment_variable {
      "name"  = "cluster_name"
      "value" = "${var.cluster_name}"
    }
  }

  source {
    type = "CODEPIPELINE"
  }

  tags = "${merge(var.default_tags, map(
      "Name", "${local.cdb_project_name}"
    ))}"
}
