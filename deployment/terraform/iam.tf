/* ASSUME ROLE */
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_execution_role" {
  name               = "${var.environment}-${var.application}"
  path               = "/${var.application}/ecs/${var.environment}/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "secrets_manager" {
  statement {
    sid = "SM"
    actions = [
      "ssm:GetParameters",
      "secretsmanager:GetRandomPassword",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = [
      "${aws_secretsmanager_secret.secrets.arn}"
    ]
  }

  # statement {
  #   sid = "ParameterStoreAccess"
  #   actions = [
  #     "ssm:*"
  #   ]
  #   resources = [
  #     # data.aws_ssm_parameter.app_config.arn
  #     aws_ssm_parameter.app_config.arn

  #   ]
  # }
}

data "aws_iam_policy_document" "secretsmanager_task_policy" {
  statement {
    sid    = "AllowSNS"
    effect = "Allow"
    actions = [
      "secretsmanager:GetRandomPassword",
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
  }

  statement {
    sid    = "S3ExecutionTask"
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.environment}-${var.application}",
      "arn:aws:s3:::${var.environment}-${var.application}/*",
    ]
  }
}

resource "aws_iam_role_policy_attachment" "secrets_manager_task" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.secrets_manager.arn
}

resource "aws_iam_policy" "secrets_manager" {
  name   = "${var.environment}-${var.application}"
  path   = "/${var.application}/ecs/${var.environment}/"
  policy = data.aws_iam_policy_document.secrets_manager.json
}

resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "secrets_manager" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.secrets_manager.arn
}

resource "aws_iam_role" "task_role" {
  name               = "${var.environment}-task-${var.application}"
  path               = "/${var.application}/ecs/${var.environment}/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# data "aws_iam_policy_document" "sns_task_policy" {
#   statement {
#     sid    = "AllowSNS"
#     effect = "Allow"
#     actions = [
#       "sns:ListTopics",
#       "sns:GetSubscriptionAttributes",
#       "sns:ListSubscriptions",
#       "sns:GetEndpointAttributes",
#       "sns:ListPlatformApplications"
#     ]
#     resources = ["arn:aws:sns:${var.region}:327667905059:*"]
#   }

#   statement {
#     sid     = "AllowShedulerSNS"
#     effect  = "Allow"
#     actions = ["sns:*"]
#     resources = [data.terraform_remote_state.sns_webhooks.outputs.sns_arn,
#     data.terraform_remote_state.pix_metrics_ingestor.outputs.topic_arn]
#   }
# }

# resource "aws_iam_policy" "sns_policy" {
#   name   = "${var.environment}-sns-policy-${var.application}"
#   path   = "/${var.application}/ecs/${var.environment}/"
#   policy = data.aws_iam_policy_document.sns_task_policy.json
# }

# resource "aws_iam_role_policy_attachment" "sns_attachment" {
#   role       = aws_iam_role.task_role.name
#   policy_arn = aws_iam_policy.sns_policy.arn
# }