// Codebuild

// Lambda function for sending codebuild status via Cloudwatch to Slack
resource "aws_lambda_function" "codebuild" {
  filename      = "${path.root}/lambda/release.zip"
  function_name = "${local.name_prefix}-cdb-status"

  role             = "${module.slack_lambda_role.role_arn}"
  handler          = "src/index.handler"
  source_code_hash = "${base64sha256(file("${path.root}/lambda/release.zip"))}"
  runtime          = "nodejs6.10"
  timeout          = 10

  environment {
    variables = {
      HookUrl = "${var.slack_webhook}"
      Channel = "${local.slack_channel}"
    }
  }

  tracing_config {
    mode = "Active"
  }
}

resource "aws_lambda_permission" "codebuild" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.codebuild.function_name}"
  principal      = "events.amazonaws.com"
  source_account = "${var.account_id}"
  source_arn     = "${aws_cloudwatch_event_rule.codebuild.arn}"
}

// Cloudwatch event for Codebuild status 
resource "aws_cloudwatch_event_rule" "codebuild" {
  name        = "${local.name_prefix}-cdb-status"
  description = "CodeBuild Build State Change"

  # role_arn    = "${aws_iam_role.cloudwatch_lambda_role.arn}"

  event_pattern = <<PATTERN
{
  "source": [
    "aws.codebuild"
  ],
  "detail-type": [
    "CodeBuild Build State Change"
  ],
  "detail": {
    "build-status": [
      "FAILED",
      "STOPPED",
      "IN_PROGRESS",
      "SUCCEEDED"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "codebuild" {
  rule      = "${aws_cloudwatch_event_rule.codebuild.name}"
  target_id = "${local.name_prefix}-cdb-status"
  arn       = "${aws_lambda_function.codebuild.arn}"
}
