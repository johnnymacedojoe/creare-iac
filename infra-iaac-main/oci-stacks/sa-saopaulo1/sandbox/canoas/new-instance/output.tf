output "instance_id" {
  description = "The OCID of the instance"
  value       = oci_core_instance.instance.id
}

output "instance_ip" {
  description = "The ip of the instance"
  value       = oci_core_instance.instance.private_ip
}
