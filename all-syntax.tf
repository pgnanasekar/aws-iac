#provider configuration
terraform {
 required_providers {
   aws = {                      # provider local name
     source  = "hashicorp/aws"  # global and unique source address
     version = "~> 3.0"         # version constraint
   } 
 }
}

# Configure the AWS Provider
provider "aws" {
 region = "us-central-1" # provider configuration options
}

provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

#VPC Creation
resource "aws_vpc" "TestVPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    tags = {
        "Name" = "TestVPC"
    }
}

#EC2 instance creation 
resource "aws_instance" "MyFirstInstance" {
  ami = "ami-***"
  instance_type = "t2.micro"
  tags {
    Name = "First_Instance"
  }
}

#S3 Bucket Creation 
resource "aws_s3_bucket" "data" {
  bucket = "webserver-bucket"
  acl = "private"
} 
