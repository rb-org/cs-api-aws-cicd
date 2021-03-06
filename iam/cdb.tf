resource "aws_iam_role" "codebuild_role" {
  name = "${local.cdb_role_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${local.cdb_role_name}"
  role = "${aws_iam_role.codebuild_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${var.s3_cicd_arn}",
        "${var.s3_cicd_arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"        
      ],
      "Resource": "arn:aws:logs:*:*:*"      
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "eks:*"
      ],
      "Resource": "${var.eks_cluster_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ],
      "Resource": [
          "${var.ecr_arn}"
        ]
    },
    {
      "Effect": "Allow",
      "Action": [
          "ssm:Describe*",
          "ssm:Get*",
          "ssm:List*"
      ],
      "Resource":[
        "arn:aws:ssm:${var.region}:${var.account_id}:parameter/${terraform.workspace}/${var.app_name}/*",
        "arn:aws:ssm:${var.region}:${var.account_id}:parameter/${var.kubeconfig_path}"
        ]
    }
  ]
}
EOF
}
