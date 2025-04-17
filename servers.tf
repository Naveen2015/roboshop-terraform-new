terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
data "aws_ami" "example" {
  most_recent = true
  owners = ["973714476881"]
  name_regex       = "Centos-8-DevOps-Practice"
  }

output "data" {
  value = data.aws_ami.example.image_id
}

resource "aws_instance" "frontend" {
  ami = data.aws_ami.example.image_id
  instance_type = "t3.micro"
  tags = {
    Name = "frontend"
  }

}

resource "aws_route53_record" "frontend" {
  zone_id ="Z09176702TOWG3ZLR2YN1"
  name    = "frontend-dev.kruthikadevops.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.frontend.private_ip]
}
