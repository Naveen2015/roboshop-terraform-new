module "vpc" {
  source = "git::https://github.com/Naveen2015/tf-module-vpc-new.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags = local.tags
  env = var.env

}


output "vpc_main_module" {
  value = module.vpc
}

module "app" {
  source   = "git::https://github.com/Naveen2015/tf-module-app-new.git"
  for_each = var.app
  instance_type = each.value["instance_type"]
  name = each.value["name"]
  env = var.env

  desired_capactiy = each.value["desired_capacity"]
  max_size = each.value["max_size"]
  min_size = each.value["min_size"]
  bastion_cidr = var.bastion_cidr
  vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
  allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["allow_app_cidr"],null),"subnet_cidrs",null)


}


