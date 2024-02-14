#------------------
#Key Pair Variables
#------------------
variable "key_pair_name" {
  description = "Key Pair for ssh access to instance"
  type        = string
  default     = "default_keypair"
}

variable "file_name" {
  description = "Name of the key pair file"
  type        = string
  default     = "default_name"
}

###############################
#### VARIABLES FOR EVERY MODULE
###############################
variable "app_name" {
  description = "app name"
  type = string
  default = "zabbix"
}

###############################
#### VPC MODULES VARIABLES
###############################
variable "vpc_cidr_block" {
    description = "cidr block for VPC"
    default = "10.0.0.0/16"
}

###############################
#### SG MODULES VARIABLES
###############################

variable "ingress_cidr_block" {
    description = "ingress cidr address"
    default = ["10.0.1.0/24"]
}