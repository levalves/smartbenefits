module "alb" {
    source = "terraform-aws-modules/alb/aws"
		version = "v8.7.0"

		name    = "${var.business_owner}-${var.environment}-${var.product}-alb" #32 char
		vpc_id  = var.vpc_id
		subnets = ["subnet-0bcfc36e71764832c", "subnet-072dbb4514c19c193"]

    create_security_group = false
		security_groups = [module.alb_sg.security_group_id]
    # security_groups = [module.demo_alb_sg_us_west_1.security_group_id]
    idle_timeout = 90
    http_tcp_listeners = [{
    port = 80
    protocol = "HTTP"
    action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = module.acm.acm_certificate_arn
      # certificate_arn    = aws_acm_certificate.cert.arn 
      target_group_index = 0
    }
  ]

    target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = "80"
      target_type      = "ip"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "80"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        protocol            = "HTTP"
        matcher             = "200"
      }      
    }
  ]
  
}