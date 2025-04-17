data "aws_ami" "example" {
  most_recent = true
  owners = ["973714476881"]
  name_regex       = "Centos-8-DevOps-Practice"
}


data "aws_security_group" "allow-all" {
  name = "allow-all"
}

variable "components" {
  default = {
    frontend = {
      name = "frontend"
      instance_type = "t3.micro"
    }
    mongod = {
      name = "mongo"
      instance_type = "t3.micro"
    }
    catalogue = {
      name = "catalogue"
      instance_type = "t3.micro"
    }
    user = {
      name = "user"
      instance_type = "t3.micro"
    }
    cart = {
      name = "cart"
      instance_type = "t3.micro"
    }
    mysql = {
      name = "mysql"
      instance_type = "t3.micro"
    }
    rabbitmq = {
      name = "rabbitmq"
      instance_type = "t3.micro"
    }
    redis = {
      name = "redis"
      instance_type = "t3.micro"
    }
    shipment = {
      name = "shipment"
      instance_type = "t3.small"
    }
    payment = {
      name = "payment"
      instance_type = "t3.micro"
    }
  }
}
resource "aws_instance" "instance" {
  for_each = var.components
  ami = data.aws_ami.example.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  tags = {
    Name = each.value["name"]
  }

}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z09176702TOWG3ZLR2YN1"
  name    = "${each.value["name"]}-dev.kruthikadevops.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}
