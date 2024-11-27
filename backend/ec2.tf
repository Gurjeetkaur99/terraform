resource "aws_instance" "vm1" {
  ami           = "ami-0942ecd5d85baa812"
  instance_type = "t2.micro"
}