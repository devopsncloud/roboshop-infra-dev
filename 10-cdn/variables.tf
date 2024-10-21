variable "common_tags" {
  default = {
    project     = "roboshop"
    Environment = "dev"
    Terraform   = "true"
  }
}


variable "tags" {
  default = {
    Component = "cdn"
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