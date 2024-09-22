resource "aws_instance" "Ansible" {
    ami = var.ami_id
    vpc_security_group_ids = var.sg_id
    instance_type = var.instance_type
    user_data = file("ansible.sh")
    tags = var.tags
}