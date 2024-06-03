output "vcn_id" {
  description = "The OCID of the created vcn"
  value       = oci_core_vcn.cs_core_vcn.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = oci_core_internet_gateway.cs_internet_gateway.id
}

output "custom_security_list_ids" {
  value = { for sl in oci_core_security_list.custom_security_list : sl.display_name => sl.id }
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = oci_core_nat_gateway.cs_nat_gateway.id
}

output "service_gateway_id" {
  value       = oci_core_service_gateway.cs_service_gateway[0].id
  description = "The OCID of the service gateway"
  sensitive   = false
}

output "route_table_ids" {
  value       = { for k, rt in oci_core_route_table.cs_route_table : k => rt.id }
  description = "The IDs of the route tables"
}

output "subnet_ids" {
  value       = { for subnet in oci_core_subnet.cs_subnet : subnet.display_name => subnet.id }
  description = "Map of subnet display names to their IDs"
}

output "default_security_list_id" {
  value       = oci_core_default_security_list.default_security_list.id
  description = "The OCID of the default security list"
}