variable "region" {
    type = string
}

variable "profile" {
    description = "AWS credentials profile you want to use"
}

variable "ami_id"{
    type = string
}
variable "subnet_id" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "sg_id" {
    type = string
}

variable "key_name" {
    type = string
}