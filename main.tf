# Configure the AWS Provider
provider "aws" {
  region                  = "eu-west-1"
  shared_credentials_file = "/home/ubuntu/.aws/credentials"
}

module "VPC" {
  source = "./VPC"

}

module "EC2" {
  source    = "./EC2"
  ec2sub = module.VPC.ec2subnet
  secID = module.VPC.securityID
  pub-key = var.public-key
}