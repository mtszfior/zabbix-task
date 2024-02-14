resource "aws_key_pair" "tf_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}



resource "local_file" "tf_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = var.file_name

}

module "zabbix_ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.app_name}-ec2-master"

  instance_type          = "t2.micro"
  key_name               = var.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.zabbix_sg.security_group_id]
  subnet_id              = module.zabbix_vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  depends_on = [
    module.zabbix_sg,
    module.zabbix_vpc
  ]
}