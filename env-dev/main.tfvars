bastion_cidr = ["172.31.4.135/32"]
env = "dev"
default_vpc_id = "vpc-0d0bd5e5843b157e8"
default_vpc_cidr = "172.31.0.0/16"
default_route_table_id = "rtb-0c5496d94302cb8e9"
kms_arn = "arn:aws:kms:us-east-1:071312222500:key/2c5cbdcc-7978-489b-88b7-1f2df783e6c7"
domain_id = "Z09176702TOWG3ZLR2YN1"
domain_name = "kruthikadevops.online"
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
    desired_capacity = 1
    max_size = 10
    min_size = 1
    allow_app_cidr = "public"
    app_port = 80
    priority = 1
    lb_type = "public"
    dns_name = "dev"
    parameters = []
  }
  catalogue = {
    name = "catalogue"
    instance_type = "t3.small"
    subnet_name = "app"
    desired_capacity = 1
    max_size = 10
    min_size = 1
    allow_app_cidr = "app"
    app_port = 8080
    priority = 1
    lb_type = "private"
    parameters = ["docdb"]
  }
  user = {
    name = "user"
    instance_type = "t3.small"
    subnet_name = "app"
    desired_capacity = 1
    max_size = 10
    min_size = 1
    allow_app_cidr = "app"
    app_port = 8080
    priority = 2
    lb_type = "private"
    parameters = ["docdb"]
  }
  cart = {
    name = "cart"
    instance_type = "t3.small"
    subnet_name = "app"
    desired_capacity = 1
    max_size = 10
    min_size = 1
    allow_app_cidr = "app"
    app_port = 8080
    priority = 3
    lb_type = "private"
    parameters = []
  }
  shipping = {
    name = "shipping"
    instance_type = "t3.small"
    subnet_name = "app"
    desired_capacity = 1
    max_size = 10
    min_size = 1
    allow_app_cidr = "app"
    app_port = 8080
    priority = 4
    lb_type = "private"
    parameters = ["rds"]
  }
  payment = {
    name = "payment"
    instance_type = "t3.small"
    subnet_name = "app"
    desired_capacity = 1
    max_size = 10
    min_size = 1
    allow_app_cidr = "app"
    app_port = 8080
    priority = 5
    lb_type = "private"
    parameters = []
  }
}


docdb = {
    main = {
      subnet_name = "db"
      engine_version = "4.0.0"
      allow_db_cidr = "app"
      instance_count = 1
      instance_class = "db.t3.medium"
    }
}
rds = {
  main = {
    subnet_name = "db"
    engine_version = "5.7.mysql_aurora.2.11.2"
    allow_db_cidr = "app"
    instance_count = 1
    instance_class = "db.t3.small"
  }
}
elasticache = {
  main = {
    subnet_name = "db"
    engine_version = "6.x"
    allow_db_cidr = "app"
    replicas_per_node_group = 1
    num_node_groups = 1
    node_type = "cache.t3.micro"
  }
}
rabbitmq = {
  main = {
    subnet_name = "db"
    allow_db_cidr = "app"
    instance_type = "t3.small"
  }
}

alb = {
  public = {
    name = "public"
    subnet_name = "public"
    allow_alb_cidr = null
    internal = false
  }
  private = {
    name = "private"
    subnet_name = "app"
    allow_alb_cidr = "web"
    internal = true
  }
}
