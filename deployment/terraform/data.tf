# data "aws_caller_identity" "current" {}
# data "aws_region" "current" {}
# data "aws_route53_zone" "site" {
#   name = "levalves.tech."
# }

# data "aws_secretsmanager_secret" "secret" {
#   name = "datadog-secret-${var.environment}"
# }

# data "aws_acm_certificate" "cert" {
#   domain = (var.environment == "production" ? "*.levalves.tech" :
#   "*.${var.environment}.levalves.tech")
#   statuses    = ["ISSUED"]
#   most_recent = true
# }

# data "terraform_remote_state" "transaction" {
#   backend   = "s3"
#   workspace = terraform.workspace
#   config = {
#     bucket = "levalves-terraform-tfstates"
#     region = "us-east-2"
#     key    = "transaction/terraform.state"
#   }
# }

# data "terraform_remote_state" "ecr" {
#   backend   = "s3"
#   workspace = terraform.workspace
#   config = {
#     bucket = "levalves-terraform-tfstates"
#     region = "us-east-2"
#     key    = "transaction/banking_ecr_terraform.state"
#   }
# }

# data "terraform_remote_state" "ecs" {
#   backend   = "s3"
#   workspace = terraform.workspace
#   config = {
#     bucket = "banking-tfstates"
#     region = "us-east-2"
#     key    = "ECS/banking-ecs-cluster-terraform.state"
#   }
# }

# data "terraform_remote_state" "sns_webhooks" {
#   backend   = "s3"
#   workspace = terraform.workspace
#   config = {
#     bucket = "levalves-terraform-tfstates"
#     region = "us-east-2"
#     key    = "transaction/banking-sns-webhooks-terraform.state"
#   }
# }

# data "terraform_remote_state" "pix_metrics_ingestor" {
#   backend   = "s3"
#   workspace = terraform.workspace
#   config = {
#     region = "us-east-2"
#     bucket = "levalves-terraform-tfstates"
#     key    = "notransaction/banking-pix-metrics-ingestor.state"
#   }
# }

# data "terraform_remote_state" "banking_vertical" {
#   backend   = "s3"
#   workspace = terraform.workspace
#   config = {
#     bucket               = "levalves-terraform-tfstates"
#     region               = "us-east-2"
#     key                  = "banking.state"
#     workspace_key_prefix = "custom-domain"
#   }
# }

# data "template_file" "container_definitions" {
#   template = file("${path.module}/templates/container-definitions.json")
#   vars = {
#     name                      = "${var.environment}-${var.application}"
#     environment               = var.environment
#     container_port            = var.container_port
#     server_port               = var.container_port
#     container_cpu             = var.container_cpu
#     container_hard_memory     = var.container_hard_memory
#     container_soft_memory     = var.container_soft_memory
#     task_region               = var.region
#     image_name                = var.image_name
#     image_tag                 = var.commit_hash
#     repository_url            = var.repository_url
#     dd_service_name           = var.application
#     dd_service_version        = var.build_version
#     mongdb_uri                = "${aws_secretsmanager_secret.secrets.arn}:MONGODB_URI::"
#     mongodb_password          = "${aws_secretsmanager_secret.secrets.arn}:MONGODB_PASSWORD::"
#     mongodb_user              = "${aws_secretsmanager_secret.secrets.arn}:MONGODB_USER::"
#     jd_password               = "${aws_secretsmanager_secret.secrets.arn}:JD_PASSWORD::"
#     jd_username               = "${aws_secretsmanager_secret.secrets.arn}:JD_USERNAME::"
#     jd_baseurl                = "${aws_secretsmanager_secret.secrets.arn}:JD_BASE_URL::"
#     db_adm_user               = "${aws_secretsmanager_secret.secrets.arn}:DB_ADM_USER::"
#     db_adm_pass               = "${aws_secretsmanager_secret.secrets.arn}:DB_ADM_PASS::"
#     slack_token               = "${aws_secretsmanager_secret.secrets.arn}:SLACK_TOKEN::"
#     sms_username              = "${aws_secretsmanager_secret.secrets.arn}:SMS_USERNAME::"
#     sms_token                 = "${aws_secretsmanager_secret.secrets.arn}:SMS_TOKEN::"
#     xms                       = var.xms
#     xmx                       = var.xms
#     max_metaspace             = var.max_metaspace
#     application_artifacts     = var.application_artifacts
#     export_metrics_topic_name = data.terraform_remote_state.pix_metrics_ingestor.outputs.topic_name
#   }
# }

# data "aws_iam_policy_document" "sns_pix_qrcode_accreditation_task_policy" {
#   statement {
#     sid    = "SNSExecutionTask"
#     effect = "Allow"
#     actions = [
#       "sns:ListTopics",
#       "sns:GetSubscriptionAttributes",
#       "sns:ListSubscriptions",
#       "sns:GetEndpointAttributes",
#       "sns:ListPlatformApplications",
#     ]
#     resources = ["arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
#   }
#   statement {
#     sid     = "SNSTaskExecution"
#     effect  = "Allow"
#     actions = ["sns:*", ]
#     resources = [
#       "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:sns-${var.application}-webhooks-${var.environment}",
#     ]
#   }
# }

# data "aws_iam_policy_document" "sqs_pix_qrcode_task_policy" {
#   statement {
#     sid    = "SQSExecutionTask"
#     effect = "Allow"
#     actions = [
#       "sqs:ListQueues",
#       "sqs:GetQueueUrl",
#       "sqs:ListQueueTags",
#       "sqs:GetQueueAttributes",
#       "sqs:ReceiveMessage",
#       "sqs:DeleteMessage",
#       "sqs:SendMessage",
#     ]
#     resources = [
#       "arn:aws:sqs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
#     ]
#   }
#   statement {
#     sid     = "SQSTaskExecution"
#     effect  = "Allow"
#     actions = ["sqs:*", ]
#     resources = [
#       "arn:aws:sqs:${var.region}:327667905059:sqs-${var.application}-confirm-phone-deadletter-${var.environment}",
#       "arn:aws:sqs:${var.region}:327667905059:sqs-${var.application}-confirm-email-${var.environment}"
#     ]
#   }
# }