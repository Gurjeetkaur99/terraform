resource "aws_instance" "myinstance" {
  ami           = "ami-0942ecd5d85baa812"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform ec2"
    env = "Prod"
  }
}