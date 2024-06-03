module "oci_core_instance" {
  source = "../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.sandbox
  subnet_id           = var.sandbox_subnet_instance
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = var.instance_name
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096.public_key_openssh
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = local.latest_ol_amd_image_id
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault_block_volume_key
  }

  shape = "VM.Standard.E5.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = var.memory_instance
    ocpus                     = var.ocpu_instance

  }

}

output "ip_address" {
  value = module.oci_core_instance.instance_ip
}


module "nsg" {
  source         = "../../modules/new-nsg"
  compartment_id = var.sandbox
  vnc_id         = var.sandbox_vcn_nsg
  nsg_name       = var.nsg_name
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "default egress"
    },
    {
      direction        = "INGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "default ingress for sandbox"
    }
  ]
}

output "nsg_id" {
  value = module.nsg.nsg_id
}


resource "tls_private_key" "rsa-4096" {
  algorithm = "RSA"
}

output "private_key" {
  value     = tls_private_key.rsa-4096.private_key_pem
  sensitive = true
}

output "public_key" {
  value     = tls_private_key.rsa-4096.public_key_openssh
  sensitive = true
}
