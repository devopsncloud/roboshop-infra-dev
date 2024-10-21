variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "common_tags" {
    default = {
        project = "roboshop"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "vpc_tags" {
     default = {}
}

variable "project_name"{
    default = "roboshop"
}

variable "environment"{
    default = "dev"
}

variable "public_subnets_cidr"{
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_subnets_cidr"{
    default = ["10.0.11.0/24","10.0.12.0/24"]
}

variable "db_subnets_cidr"{
    default = ["10.0.21.0/24","10.0.22.0/24"]
}

###################################
variable "is_peering_required"{
    default = true
}

variable "acceptor_vpc_id" {
    type = string
    default = ""
}


data "aws_vpc" "default_vpc" {
  default = true
}
