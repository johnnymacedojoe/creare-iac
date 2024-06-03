output "load_balancer_id" {
  description = "The OCID of the created load balancer."
  value       = oci_load_balancer_load_balancer.lb.id
}

/*output "backend_ids" {
  value = { for b in oci_load_balancer_backend.backend : b.name => b.id }
  description = "The IDs of the backend resources."
}*/
