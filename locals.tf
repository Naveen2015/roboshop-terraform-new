locals {
  vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
  tags = {
    business_unit = "ecomm"
    business_type = "retail"
    project = "roboshop"
    env = var.env
  }
}