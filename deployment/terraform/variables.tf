variable "environment" {}
variable "region" {}

variable "business_owner" {
  default = "itsseg"
}

# variable "service" {
#   default     = "transactional"
#   description = "Type of service, could be transaction or notransaction."
# }

variable "application" {
  default = "smartbenefits-front"
}

variable "domain_zone_id" {}

variable "bastion_host_cidr" {
  default = ["172.31.0.116/32"]
}

# variable "role_arn" {
#   default = "arn:aws:iam::245017079162:role/CrossAccount-levalves-NonProd"
# }

# variable "on_demand_percentage_above_base_capacity" {
#   default = 0
# }

# variable "on_demand_base_capacity" {
#   default = 0
# }

/* ECS  */
# variable "deregistration_delay" {
#   default = 30
# }

# variable "alb_listener_rule_priority" {
#   default = 200
# }

variable "image_name" {}
variable "container_hard_memory" {}
variable "container_soft_memory" {}
variable "container_cpu" {}
variable "repository_url" {}
variable "container_port" {}
variable "desired_count" {}
variable "xms" {}
variable "xmx" {}
variable "max_metaspace" {}
variable "commit_hash" {}

# variable "policy" {
#   default = 0
# }

variable "ingress_cidr_blocks" {
  default = []
}

# variable "application_artifacts" {}

# variable "health_check_interval" {
#   default = 30
# }

# variable "healthy_threshold" {
#   default = 2
# }

# variable "unhealthy_threshold" {
#   default = 2
# }

# variable "health_check_timeout" {
#   default = 10
# }

# variable "health_check_path" {
#   default = "/actuator/health"
# }

# variable "health_check_matcher" {
#   default = "200"
# }

variable "max_capacity" {
  default = 1
}

variable "min_capacity" {
  default = 1
}

# variable "enable_auto_scaling_cpu" {
#   description = "Enable auto scaling policies based on CPU if set to true."
#   default     = false
# }

# variable "enable_auto_scaling_mem" {
#   description = "Enable auto scaling policies based on MEM if set to true."
#   default     = false
# }

variable "email" {}

# /* NLB */
variable "nlb_listener_port" {}

variable "load_balancer_arn" {
  default = null
}

# /* VPC */
variable "vpc_id" {}
variable "private_subnets" {}
variable "private_subnets_cidr_block" {}

variable "azs" {}

# /* CLOUDFRONT */
# variable "price_class" {
#   default = "PriceClass_All"
# }

# variable "cloudfront_certificate_arn" {}

# variable "build_version" {
#   default = "1.0.0"
# }

# variable "organization_owner" {
#   default = "itsseg"
# }

variable "product" {
  default = "dot-net"
}

# variable "cc" {
#   default = "8110BCT"
# }

# variable "repo_url" {
#   description = "AWS Tag: Repo"
#   type        = string
#   default     = "https://github.com/getlevalves/pix-qrcode"
# }

# variable "tg_name" {
#   description = "Target Group name, needed because of resource name size limitations."
#   default     = "tg-pix-qrcode"
# }

# variable "sub_domain" {
#   description = "Sub domain to be added to route53 records."
#   type        = string
#   default     = "tg-pix-qrcode-nlb"
# }

# variable "monitoring" {
#   description = "Enable monitoring if set to true."
#   default     = true
# }

# variable "backup" {
#   description = "Enable backup if set to true."
#   default     = false
# }

variable "terraform" {
  description = "Inform if the resource is being created by terraform."
  default     = true
}

variable "s3_bucket_name" {
  description = "Inform the bucket name for tfstates"
  default     = "levalves-terraform-tfstates"
}
