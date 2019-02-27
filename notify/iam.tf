// Lambda role

module "slack_lambda_role" {
  source = "git@github.com:rb-org/terraform-aws-iam-misc//service_role"

  name                  = "${local.name_prefix}-lambda-slack-role"
  principal_identifiers = ["lambda.amazonaws.com"]
  principal_type        = "Service"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/CloudWatchEventsReadOnlyAccess",
  ]
}

// Lambda XRay Tracing Policy
resource "aws_iam_role_policy" "lambda_xray_policy" {
  name = "${local.name_prefix}-lambda-xray-policy"
  role = "${module.slack_lambda_role.role_id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Allow",
        "Action": [
            "xray:PutTraceSegments",
            "xray:PutTelemetryRecords"
        ],
        "Resource": [
            "*"
        ]
    }
}
EOF
}

// Cloudwatch invoke lambda

resource "aws_iam_role" "cloudwatch_lambda_role" {
  name = "${local.name_prefix}-cdb-cw-lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch_lambda_policy" {
  name = "${local.name_prefix}-cdb-cw-lambda-policy"
  role = "${aws_iam_role.cloudwatch_lambda_role.id}"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "lambda:InvokeFunction"
         ],
         "Resource": [
             "${aws_lambda_function.codebuild.arn}"
         ]
      }
   ]
}
EOF
}
