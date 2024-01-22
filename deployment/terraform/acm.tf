# resource "aws_acm_certificate" "cert" {
#   domain_name       = var.domain_name
#   validation_method = "DNS"

#   # tags = {
#   #   Environment = "devops-demo"
#   # }

#   lifecycle {
#     create_before_destroy = true
#   }
  
# }

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "= 5.0.0"

  domain_name  = "levinux.com"
  zone_id      = "Z06315811JBZBZGWOUE0X"

  validation_method = "DNS"

  subject_alternative_names = [
    "*.levinux.com",
    "app.sub.levinux.com",
  ]

  wait_for_validation = true

  # tags = {
  #   Name = "my-domain.com"
  # }
}