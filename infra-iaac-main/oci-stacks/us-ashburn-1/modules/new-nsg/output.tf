output "nsg_id" {
  description = "The OCID of the created load balancer"
  value       = oci_core_network_security_group.nsg.id
}