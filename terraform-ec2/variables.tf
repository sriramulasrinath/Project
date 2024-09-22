variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "sg_id" {
    type = list
    default = ["sg-00d8e884e38dae954"]
}

variable "instance_type" {
    default = "t3.micro"
}

variable "tags" {
    default = {
        Name = "Ansible"
    }
}

