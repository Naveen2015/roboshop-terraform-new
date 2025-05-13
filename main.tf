module "vpc" {
  source = "git::https://github.com/Naveen2015/tf-module-vpc-new.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags = local.tags
  env = var.env
  default_vpc_id = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  default_route_table_id = var.default_route_table_id

}


output "vpc_main_module" {
  value = module.vpc
}

# module "app" {
#   source   = "git::https://github.com/Naveen2015/tf-module-app-new.git"
#   for_each = var.app
#   instance_type = each.value["instance_type"]
#   name = each.value["name"]
#   env = var.env
#   tags = local.tags
#   desired_capacity = each.value["desired_capacity"]
#   max_size = each.value["max_size"]
#   min_size = each.value["min_size"]
#   bastion_cidr = var.bastion_cidr
#   subnet_ids = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["subnet_name"],null),"subnet_ids",null)
#   vpc_id = local.vpc_id
#   allow_app_cidr = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["allow_app_cidr"],null),"subnet_cidrs",null)
#
#
# }

module "docdb" {
  source   = "git::https://github.com/Naveen2015/tf-module-docdb-new.git"
  for_each = var.docdb
  tags = local.tags
  env = var.env
  subnets = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["subnet_name"],null),"subnet_ids",null)
  engine_version = each.value["engine_version"]
  vpc_id = local.vpc_id
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["allow_db_cidr"],null),"subnet_cidrs",null)
  kms_arn = var.kms_arn
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]

}

module "rds" {
  source = "git::https://github.com/Naveen2015/tf-module-rds-new.git"
  for_each = var.rds
  env = var.env
  tags = local.tags
  subnets = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["subnet_name"],null),"subnet_ids",null)
  engine_version = each.value["engine_version"]
  vpc_id = local.vpc_id
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["allow_db_cidr"],null),"subnet_cidrs",null)
  kms_arn = var.kms_arn
  instance_count = each.value["instance_count"]
  instance_class = each.value["instance_class"]

}

module "elastic" {
  source = "git::https://github.com/Naveen2015/tf-module-elasticache.git"
  for_each = var.elasticache
  env = var.env
  tags = local.tags
  subnets = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["subnet_name"],null),"subnet_ids",null)
  engine_version = each.value["engine_version"]
  vpc_id = local.vpc_id
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["allow_db_cidr"],null),"subnet_cidrs",null)
  kms_arn = var.kms_arn
  replicas_per_node_group = each.value["replicas_per_node_group"]
  num_node_groups = each.value["num_node_groups"]
  node_type = each.value["node_type"]

}

module "rabbitmq" {
  source = "git::https://github.com/Naveen2015/tf-module-amazon-mq.git"
  for_each = var.rabbitmq
  env = var.env
  tags = local.tags
  subnets = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["subnet_name"],null),"subnet_ids",null)
  instance_type = each.value["instance_type"]
  vpc_id = local.vpc_id
  allow_db_cidr = lookup(lookup(lookup(lookup(module.vpc,"main",null),"subnets",null),each.value["allow_db_cidr"],null),"subnet_cidrs",null)
  kms_arn = var.kms_arn
  bastion_cidr = var.bastion_cidr

}






