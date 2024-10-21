locals {
  ec2_name     = "${var.project_name}-${var.environment}"
  db_subnet_id = element(split(",", data.aws_ssm_parameter.db_subnet_ids.value), 0)

}