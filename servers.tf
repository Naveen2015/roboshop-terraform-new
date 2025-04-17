data "aws_ami" "example" {
  most_recent = true
  owners = ["973714476881"]
  name_regex       = "Centos-8-DevOps-Practice"
  }

output "data" {
  value = data.aws_ami.example.image_id
}
