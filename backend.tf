terraform {
  backend "s3" {
    bucket = "ky-s3-terraform"
    key    = "ky-tf-asg2.7.tfstate"
    region = "us-east-1"
  }
}