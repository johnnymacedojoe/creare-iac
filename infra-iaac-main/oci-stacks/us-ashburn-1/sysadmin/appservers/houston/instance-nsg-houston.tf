module "oci_core_instance_houston" {
  source = "../../../modules/new-instance-v3-kali"

  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp
  subnet_id           = var.subnet_iad1p2
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "houston"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-houston.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-houston.public_key_openssh
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = var.kali_linux_image
    boot_volume_size_in_gbs = 98
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E3.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "16"
    ocpus                     = "1"

  }
  //create_attachment = false // set this to false if you dont wanna create attachments
}

output "ip_address_houston" {
  value = module.oci_core_instance_houston.instance_ip
}


module "nsg-houston" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-corp
  vnc_id         = var.vcn_iad1p
  nsg_name       = "nsg-houston"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "default egress"
    }
    /**{
      direction   = "INGRESS"
      protocol    = "all"        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.40.8.0/21"
      min_port    = 18433
      max_port    = 18433
      description = "Instance Pods OKE gru1q to Nifi-registry"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.20.8.0/21"
      min_port    = 18433
      max_port    = 18433
      description = "Instance Pods OKE sin1p to Nifi-registry"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.21.8.0/21"
      min_port    = 18433
      max_port    = 18433
      description = "Instance Pods OKE sin1q to Nifi-registry"
    }**/
  ]
}

output "nsg_id_houston" {
  value = module.nsg-houston.nsg_id
}


resource "tls_private_key" "rsa-4096-houston" {
  algorithm = "RSA"
}

output "private_key_houston" {
  value     = tls_private_key.rsa-4096-houston.private_key_pem
  sensitive = true
}

output "public_key_houston" {
  value     = tls_private_key.rsa-4096-houston.public_key_openssh
  sensitive = true
}
