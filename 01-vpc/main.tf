module "roboshop"{
    #source = "../terraform-aws-vpc"
    ####Refering module from git hub==> using others's module hosted on github
    source = "git::https://github.com/devopsncloud/terraform-aws-vpc.git?ref=main"
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    vpc_tags = var.vpc_tags

    #public subnets
    public_subnets_cidr = var.public_subnets_cidr

    #private subnets
    private_subnets_cidr = var.private_subnets_cidr

    #db subnets
    db_subnets_cidr = var.db_subnets_cidr

    #peering
    is_peering_required = var.is_peering_required


}
