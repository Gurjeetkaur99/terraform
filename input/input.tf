variable "ec2_ami_id" {
    description = "This is ami id"
    type = string
    default = "ami-0942ecd5d85baa812"
}

variable "instance_type" {
    description = "This is instance type"
    type = string
    default = "t2.micro"  
}