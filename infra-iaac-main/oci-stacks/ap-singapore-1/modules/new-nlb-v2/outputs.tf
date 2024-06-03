output "load_balancer_id" {
  description = "The OCID of the created load balancer"
  value       = oci_network_load_balancer_network_load_balancer.nbl.id
}

