####################DATA-BASE-SECURITY GROUPS#######################################
module "mongodb" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for Mongodb"
  sg_name      = "mongodb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "redis" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for redis"
  sg_name      = "redis"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "mysql" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for mysql"
  sg_name      = "mysql"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "rabbitmq" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for rabbitmq"
  sg_name      = "rabbitmq"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

####################APP-SECURITY GROUPS#######################################

module "catalogue" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for Catalogue"
  sg_name      = "catalogue"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}


module "user" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for user"
  sg_name      = "user"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "cart" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for cart"
  sg_name      = "cart"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}


module "shipping" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for shipping"
  sg_name      = "shipping"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

module "payment" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for payment"
  sg_name      = "payment"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}



############################WEB-SECURITY-GROUP#################################

module "web" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group for web"
  sg_name      = "web"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

##############################APP-LOAD-BALANCER-SG################################

module "app_alb" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group App LB"
  sg_name      = "app-alb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

##############################WEB-LOAD-BALANCER-SG################################

module "web_alb" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_ssm_parameter.vpc_id.value
  sg_desc      = "security group Web LB"
  sg_name      = "web-alb"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}


############################VPN-SECURITY-GROUP#################################

module "vpn" {
  source       = "git::https://github.com/devopsncloud/roboshop-infra-dev.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = data.aws_vpc.default.id
  sg_desc      = "security group for VPN"
  sg_name      = "vpn"
  # sg_ingress_rules = var.mongodb_sg_ingress_rules
}

##################################INGRESS-RULES################################

#Mongodb accepting connections from catalogue,user and vpn
resource "aws_security_group_rule" "mongodb_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id

}

resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id

}

resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id

}

#redis accepting connections from cart,user and vpn

resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

#MYSQL accepting connections from shipping and vpn
resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

#RABBITMQ accepting connections from vpn and payment
resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

#CATALOGUE
resource "aws_security_group_rule" "catalogue_vpn_http" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

# resource "aws_security_group_rule" "catalogue_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }

resource "aws_security_group_rule" "catalogue_app_lb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}


# resource "aws_security_group_rule" "catalogue_cart" {
#   source_security_group_id = module.cart.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.catalogue.sg_id
# }


#USER <-- VPN
resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

# resource "aws_security_group_rule" "user_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

# resource "aws_security_group_rule" "user_payment" {
#   source_security_group_id = module.payment.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.user.sg_id
# }

#CART 
resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

# resource "aws_security_group_rule" "cart_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.cart.sg_id
# }

resource "aws_security_group_rule" "cart_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}




resource "aws_security_group_rule" "cart_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}
#SHIPPING
resource "aws_security_group_rule" "shipping_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}

# resource "aws_security_group_rule" "shipping_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.shipping.sg_id
# }


resource "aws_security_group_rule" "shipping_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.shipping.sg_id
}


#PAYMENT
resource "aws_security_group_rule" "payment_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

# resource "aws_security_group_rule" "payment_web" {
#   source_security_group_id = module.web.sg_id
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = module.payment.sg_id
# }


resource "aws_security_group_rule" "payment_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.payment.sg_id
}

#######WEB
resource "aws_security_group_rule" "web_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}

resource "aws_security_group_rule" "web_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.web.sg_id
}


##App_ALB should accept connections only form VPN, since it is internal.
resource "aws_security_group_rule" "app_alb_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

##App_ALB should accept connections only form WEB
resource "aws_security_group_rule" "app_alb_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

##Web_ALB should accept connections only form Internet, since it is external.
resource "aws_security_group_rule" "web_alb_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = module.web_alb.sg_id
}


##App_ALB should accept connections only form CART
resource "aws_security_group_rule" "app_alb_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

##App_ALB should accept connections only form SHIPPING
resource "aws_security_group_rule" "app_alb_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}


##App_ALB should accept connections only form PAYMENT
resource "aws_security_group_rule" "app_alb_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}


####################################
#openvpn sg rule
resource "aws_security_group_rule" "vpn_home" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}