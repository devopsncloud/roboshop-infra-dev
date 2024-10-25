variable "common_tags" {
  default = {
    project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}


variable "tags" {
  default = {
    Component = "shipping"
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "zone_name" {
  default = "roboriya.shop"
}

variable "iam_instance_profile" {
  default = "Roboshop"
}