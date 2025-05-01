module "vpc" {
  source = "git::https://github.com/Naveen2015/tf-module-vpc-new.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  tags = merge(local.tags, { Name = "${var.env}-vpc"})

}

output "vpc_main_module" {
  value = module.vpc
}