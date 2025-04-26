
resource "aws_instance" "instance" {
  ami = data.aws_ami.ami.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  tags = {
    Name = local.name
  }


}

resource "null_resource" "provisioner" {
  count = var.provisioner ? 1 : 0
  depends_on = [aws_instance.instance,aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip

    }

    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}

resource "aws_route53_record" "records" {
  depends_on = [aws_instance.instance]
  zone_id = "Z09176702TOWG3ZLR2YN1"
  name    = "${var.component_name}-${var.env}.kruthikadevops.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
