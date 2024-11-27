output "public_ip" {
  description = "This is Public ip of ec2 instance"
  value = aws_instance.myec2instance.public_ip
}

output "instance_id" {
  description = "This is instance id"
  value = aws_instance.myec2instance.id
}