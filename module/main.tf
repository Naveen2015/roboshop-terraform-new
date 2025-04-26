
resource "aws_instance" "instance" {
  ami = "ami-0b4f379183e5706b9"
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  tags = {
    Name = local.name
  }


}

resource "null_resource" "provisioner" {
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

resource "aws_iam_role" "role" {
  name = "${var.component_name}--${var.env}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.component_name}--${var.env}-role"
  }
}

resource "aws_iam_role_policy" "ssm-ps-policy" {
  name = "${var.component_name}-${var.env}-ssm-ps-policy"
  role = aws_iam_role.role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          "arn:aws:ssm:us-east-1:071312222500:parameter/dev.catalogue.*",
          "arn:aws:kms:us-east-1:071312222500:key/2c5cbdcc-7978-489b-88b7-1f2df783e6c7"
        ]
      }
    ]
  }
   )
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.env}.${var.component_name}-profile"
  role = aws_iam_role.role.name
}

