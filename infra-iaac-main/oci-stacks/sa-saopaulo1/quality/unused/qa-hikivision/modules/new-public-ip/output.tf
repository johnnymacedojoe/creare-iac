output "public_ip" {
  value       = oci_core_public_ip.public_ip.id
  description = "The public IP address"
}