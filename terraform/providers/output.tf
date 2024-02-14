#output "zabbix_vpc_id" {
#  description = "The ID of the VPC"
#  value       = try(zabbix_vpc.this[0].id, null)
#}
#
#output "zabbix_sg_id" {
#  description = "The ID of the security group"
#  value       = try(zabbix_sg.this[0].id, zabbix_sg.this_name_prefix[0].id, "")
#}