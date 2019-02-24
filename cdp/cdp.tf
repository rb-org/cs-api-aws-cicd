# Main

resource "aws_codepipeline" "cs_api" {
  name     = "${local.cdp_name}"
  role_arn = "${var.codepipeline_role_arn}"

  artifact_store {
    location = "${var.s3_cicd_bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["cs-api-code"]

      configuration = {
        Owner      = "${var.github_org}"
        Repo       = "${var.github_repo}"
        Branch     = "${var.github_repo_branch}"
        OAuthToken = "${var.github_token}"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["cs-api-code"]
      version         = "1"

      configuration = {
        ProjectName = "${local.cdb_project_name}"
      }
    }
  }
}

resource "github_repository_webhook" "cs_api" {
  repository = "${var.github_repo}"

  name = "web"

  configuration {
    url          = "${aws_codepipeline_webhook.cs_api.url}"
    content_type = "form"
    insecure_ssl = true
    secret       = "${local.webhook_secret}"
  }

  events = ["push"]
}

resource "aws_codepipeline_webhook" "cs_api" {
  name            = "${local.cdp_webhook_name}"
  authentication  = "GITHUB_HMAC"
  target_action   = "Source"
  target_pipeline = "${aws_codepipeline.cs_api.name}"

  authentication_configuration {
    secret_token = "${local.webhook_secret}"
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
}
