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

