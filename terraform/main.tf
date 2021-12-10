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
            echo "[demo]" > ../ansible/inventory
            echo "${aws_instance.ec2_server.public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=/home/joel/terraform.pem" >> ../ansible/inventory
            EOF
    }

    provisioner "local-exec" {
        command = <<EOF
            ANSIBLE_HOST_KEY_CHECKING=False \
            ansible-playbook -i ../ansible/inventory ../ansible/site.yml
            EOF
    }
}
