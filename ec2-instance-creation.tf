resource "aws_instance" "MyFirstInstance" {
  ami = "ami-***"
  instance_type = "t2.micro"
  tags {
    Name = "First_Instance"
  }
}
