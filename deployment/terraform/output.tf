# output "cluster_name" {
#   value = data.terraform_remote_state.ecs.outputs.ecs_cluster_name
# }

# output "ecs_service_arn" {
#   value = module.ecs_service.ecs_service_arn
# }

# output "ecs_service_name" {
#   value = module.ecs_service.ecs_service_name
# }

# output "ecs_service_cluster" {
#   value = module.ecs_service.ecs_service_cluster
# }

# output "ecs_task_definition_arn" {
#   value = module.ecs_service.ecs_task_definition_arn
# }

# output "ecs_task_definition_family" {
#   value = module.ecs_service.ecs_task_definition_family
# }

# output "ecs_task_definition_revision" {
#   value = module.ecs_service.ecs_task_definition_revision
# }

# output "application_fqdn" {
#   value = module.ecs_service.route53_fqdn
# }

# output "secret_manager_id" {
#   value = aws_secretsmanager_secret.secrets.id
# }

# output "secret_manager_arn" {
#   value = aws_secretsmanager_secret.secrets.arn
# }

# output "bucket_website_endpoint" {
#   value = module.pix-qrcode.bucket_website_endpoint
# }

# output "bucket_website_domain" {
#   value = module.pix-qrcode.bucket_website_domain
# }

# output "banking_pix_email" {
#   value = aws_ses_email_identity.email.*.arn
# }

# /* S3 */
# output "banking_pix_bucket_id" {
#   value = module.pix-qrcode.bucket_id
# }

# output "banking_pix_bucket_arn" {
#   value = module.pix-qrcode.bucket_arn
# }

# output "banking_pix_bucket_name" {
#   value = module.pix-qrcode.bucket_name
# }

# output "bucket_regional_domain_name" {
#   value = module.pix-qrcode.bucket_regional_domain_name
# }

# # /* BUCKET WEBSITE */
# output "banking_pix_bucket_website_endpoint" {
#   value = module.pix-qrcode.bucket_website_endpoint
# }

# output "banking_pix_bucket_website_domain" {
#   value = module.pix-qrcode.bucket_website_domain
# }

# output "banking_pix_bucket_regional_domain_name" {
#   value = module.pix-qrcode.bucket_regional_domain_name
# }

# output "banking_pix_bucket_domain_name" {
#   value = module.pix-qrcode.bucket_domain_name
# }

# /* BUCKET PIX QRCODE CLOUDFRONT LOG */
# output "banking_pix_bucket_log_id" {
#   value = module.pix-qrcode-log.bucket_id
# }

# output "banking_pix_bucket_log_arn" {
#   value = module.pix-qrcode-log.bucket_arn
# }

# output "banking_pix_bucket_log_name" {
#   value = module.pix-qrcode-log.bucket_name
# }

# /* BANKING PIX QRCODE CLOUDFRONT */
# output "banking_pix_cloudfront_id" {
#   value = aws_cloudfront_distribution.pix_qrcode_s3_distribution.id
# }

# output "banking_pix_cloudfront_arn" {
#   value = aws_cloudfront_distribution.pix_qrcode_s3_distribution.arn
# }

# output "banking_pix_cloudfront_domain_name" {
#   value = aws_cloudfront_distribution.pix_qrcode_s3_distribution.domain_name
# }

# /* BANKING PIX QRCODE CLOUDFRONT ROUTE53 CLOUDFRONT */
# output "banking_pix_s3_fqdn" {
#   value = aws_route53_record.pix_qrcode_cloudfront_s3.fqdn
# }

# output "banking_pix_s3_name" {
#   value = aws_route53_record.pix_qrcode_cloudfront_s3.name
# }