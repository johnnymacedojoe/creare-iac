module "oci_core_instance_rosia" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.production
  subnet_id           = module.vcn-oci-oke-gru1p.subnet_ids["sn-oci-oke-gru1p2"]
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "rosia"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-rosia.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-rosia.public_key_openssh
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = local.latest_ol_amd_image_id
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E5.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "8"
    ocpus                     = "1"

  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-rosia-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-rosia-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_rosia" {
  value = module.oci_core_instance_rosia.instance_ip
}


module "nsg-rosia" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.production
  vnc_id         = module.vcn-oci-oke-gru1p.vcn_id
  nsg_name       = "nsg-rosia"
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
  ]
}

output "nsg_id_rosia" {
  value = module.nsg-rosia.nsg_id
}


resource "tls_private_key" "rsa-4096-rosia" {
  algorithm = "RSA"
}

output "private_key_rosia" {
  value     = tls_private_key.rsa-4096-rosia.private_key_pem
  sensitive = true
}

output "public_key_rosia" {
  value     = tls_private_key.rsa-4096-rosia.public_key_openssh
  sensitive = true
}
