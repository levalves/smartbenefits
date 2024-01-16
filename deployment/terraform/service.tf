# module "ecs_service" {
#   source  = "git@github.com:levalves/tf-module-ecs-application.git?ref=v1"
#   name    = "${var.environment}-${var.application}"
#   region  = var.region
#   tg_name = var.tg_name
  

#   execution_role_arn = aws_iam_role.task_execution_role.arn
#   task_role_arn      = aws_iam_role.task_role.arn

#   ecs_cluster_arn = data.terraform_remote_state.ecs.outputs.ecs_cluster_arn
#   vpc_id          = var.vpc_id
#   subnets         = var.private_subnets

#   container_definitions = data.template_file.container_definitions.rendered
#   container_port        = var.container_port
#   desired_count         = var.desired_count

#   alb_listener_arn = data.terraform_remote_state.ecs.outputs.alb_listener_arn

#   deregistration_delay = var.deregistration_delay

#   alb_dns_name   = data.terraform_remote_state.ecs.outputs.alb_dns_name
#   alb_zone_id    = data.terraform_remote_state.ecs.outputs.alb_zone_id
#   domain_zone_id = var.domain_zone_id

#   health_check_path     = var.health_check_path
#   health_check_matcher  = var.health_check_matcher
#   health_check_interval = var.health_check_interval
#   healthy_threshold     = var.healthy_threshold
#   unhealthy_threshold   = var.unhealthy_threshold
#   health_check_timeout  = var.health_check_timeout

#   ingress_cidr_blocks = var.ingress_cidr_blocks

#   cluster_name            = data.terraform_remote_state.ecs.outputs.ecs_cluster_name
#   max_capacity            = var.max_capacity
#   min_capacity            = var.min_capacity
#   enable_auto_scaling_cpu = true
#   enable_auto_scaling_mem = true

#   nlb_listner_settings = {
#     load_balancer_arn = "${var.environment == "stresstest" ? var.load_balancer_arn : data.terraform_remote_state.banking_vertical.outputs.nlb_arn}"
#     port              = var.nlb_listener_port,
#     ssl = {
#       policy          = "ELBSecurityPolicy-2016-08"
#       certificate_arn = data.aws_acm_certificate.cert.arn
#     }
#   }

#   capacity_provider_strategies = [
#     {
#       capacity_provider = data.terraform_remote_state.ecs.outputs.ecs_cluster_cas_name
#       weight            = 100
#   }]

#   tags = ""
# }