bastion_cidr = ["172.31.4.135/32"]
env = "dev"
default_vpc_id = "vpc-0d0bd5e5843b157e8"
default_vpc_cidr = "172.31.0.0/16"
default_route_table_id = "rtb-0c5496d94302cb8e9"
vpc = {
main = {
  cidr_block = "10.0.0.0/16"
  subnets = {
    public = {
      name = "public"
      cidr_block = ["10.0.0.0/24","10.0.1.0/24"]
      azs = ["us-east-1a","us-east-1b"]
    }
    web = {
      name = "web"
      cidr_block = ["10.0.2.0/24","10.0.3.0/24"]
      azs = ["us-east-1a","us-east-1b"]
    }
    app = {
      name = "app"
      cidr_block = ["10.0.4.0/24","10.0.5.0/24"]
      azs = ["us-east-1a","us-east-1b"]
    }
    db = {
      name = "db"
      cidr_block = ["10.0.6.0/24","10.0.7.0/24"]
      azs = ["us-east-1a","us-east-1b"]
    }

  }
}

}

app = {
  frontend = {
    name = "frontend"
    instance_type = "t3.small"
    subnet_name = "web"
    desired_capacity = 2
    max_size = 10
    min_size = 2
    allow_app_cidr = "public"
  }
  catalogue = {
    name = "catalogue"
    instance_type = "t3.small"
    subnet_name = "app"
    desired_capacity = 2
    max_size = 10
    min_size = 2
    allow_app_cidr = "web"
  }
}