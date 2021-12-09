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

    provisioner "local-exec" {
        command = <<EOF
            echo "[demo]" > inventory
            echo "${aws_instance.demo.public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=~/.ssh/your_private_key.pem" >> inventory
            EOF
    }

    provisioner "local-exec" {
        command = <<EOF
            ANSIBLE_HOST_KEY_CHECKING=False \
            ansible-playbook -i inventory site.yml
            EOF
    }
}