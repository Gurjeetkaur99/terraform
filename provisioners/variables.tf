variable "region" {
    description = "AWS region"
    default = "us-east-2"
}

variable "ami_id" {
    description = "This is ami id"
    default = "ami-0942ecd5d85baa812"
}


variable "instance_type" {
    description = "This is instance type"
    default = "t2.micro"  
}

variable "public_key_path" {
    description = "This is path for public key"
    default = "~/.ssh/id_rsa.pub"  
}

variable "private_key_path" {
    description = "This is path for private key"
    default = "~/.ssh/id_rsa"  
}