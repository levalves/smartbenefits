module "alb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name        = "${var.application}-alb-sg"
  description = "Security group for *-alb-sg with custom ports open within VPC open"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["http-80-tcp"]
  egress_rules             = ["all-all"]
}

module "computed_source_alb_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
  
  name        = "${var.application}-service-sg"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = var.vpc_id

  computed_ingress_with_source_security_group_id = [
    {
      rule            = "all-all"
      source_security_group_id = module.alb_sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}
