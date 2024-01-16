resource "aws_secretsmanager_secret" "secrets" {
  name                    = "${var.environment}-sm-${var.application}"
  recovery_window_in_days = var.environment == "production" ? 7 : 0
  description             = "${var.environment}-sm-${var.application}"
}

variable "secrets_structure" {
  default = {
    MONGODB_URI      = ""
    MONGODB_PASSWORD = ""
    MONGODB_USER     = ""
    JD_PASSWORD      = ""
    JD_USERNAME      = ""
    JD_BASE_URL      = ""
    DB_ADM_USER      = ""
    DB_ADM_PASS      = ""
    SLACK_TOKEN      = ""
    SMS_USERNAME     = ""
    SMS_TOKEN        = ""
  }
  type = map(any)
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secrets.id
  secret_string = jsonencode(var.secrets_structure)

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}
