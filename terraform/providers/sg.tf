module "zabbix_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.app_name}-sg"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = module.zabbix_vpc.vpc_id

  ingress_cidr_blocks = var.vpc_cidr_block
  ingress_rules       = ["basic-rules"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "185.56.211.202/32" # My IP address
    },
    #{
    #  rule        = ""
    #  cidr_blocks = "0.0.0.0/0"
    #},
  ]
  depends_on = [module.zabbix_vpc]
}