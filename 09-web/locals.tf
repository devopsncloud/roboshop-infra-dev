locals {
  name         = "${var.project_name}-${var.environment}"
  current_time = formatdate("DD-MM-YYYY_HH-mm", timestamp())
}