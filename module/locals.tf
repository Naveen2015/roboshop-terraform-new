locals {
  name = var.env != "" ? "${var.component_name}-${var.env}" : var.component_name
  db_commands = [
    "rm -rf roboshop-shell-new",
    "git clone https://github.com/Naveen2015/roboshop-shell-new.git",
    "cd roboshop-shell-new",
    "echo sudo bash ${var.component_name}.sh ${var.password}",
    "sudo bash ${var.component_name}.sh ${var.password}"

  ]
  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/Naveen2015/roboshop-ansible-new -e env=${var.env} roboshop.yml -e role_name = ${var.component_name}"

  ]
}