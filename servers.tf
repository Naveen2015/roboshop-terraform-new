
data "aws_ami" "example" {
  most_recent = true
  owners = ["973714476881"]
  name_regex       = "Centos-8-DevOps-Practice"
  }

data "aws_security_group" "allow-all" {
  name = "allow-all"
}

output "data" {
  value = data.aws_security_group.allow-all.id
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
