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

resource "aws_eip" "lb" {
  vpc = true
}

output "eip" {
  value = aws_eip.lb.public_ip
}

#allocate the EIP to instance 
resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.MyFirstInstance.id
  allocation_id = aws_eip.lb.id
}

#Creating new security group and allow the particular EIP in inbound rules
resource "aws_security_group" "allow_tls" {
  name = "test-sg"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
  }
}

#S3 Bucket Creation 
resource "aws_s3_bucket" "data" {
  bucket = "webserver-bucket"
  acl = "private"
} 

output "mys3bucket" {
  value = aws_s3_bucket.data.bucket_domain_name
}