terraform {
  backend "s3" {
    bucket = "terraformb72"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
