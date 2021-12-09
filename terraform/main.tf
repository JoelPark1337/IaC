provider "aws" {
    region = var.region
    profile = "default"
}

resource "aws_instance" "ec2_server" {
    ami = var.ami_id
    instance_type = "t2.micro"
    key_name = var.key_name
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.sg_id]
    associate_public_ip_address = true
}
