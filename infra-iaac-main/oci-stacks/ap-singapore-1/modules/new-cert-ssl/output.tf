output "certificate_id" {
  description = "The OCID of the SSL certificate."
  value       = oci_load_balancer_certificate.certificate.id
}

output "certificate_name" {
  description = "The name of the SSL certificate."
  value       = oci_load_balancer_certificate.certificate.certificate_name
}
