output "nsg_id_alicante" {
  value = module.nsg-alicante.nsg_id
}

resource "tls_private_key" "rsa-4096-alicante" {
  algorithm = "RSA"
}

output "private_key_alicante" {
  value     = tls_private_key.rsa-4096-alicante.private_key_pem
  sensitive = true
}

output "public_key_alicante" {
  value     = tls_private_key.rsa-4096-alicante.public_key_openssh
  sensitive = true
}

output "ip_address_alicante" {
  value = module.oci_core_instance_alicante.instance_ip
}

module "oci_core_instance_alicante" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.production
  subnet_id           = var.sn-oci-spo1p1
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "alicante"
  //private_ip                  = "10.1.2.71" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-alicante.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-alicante.public_key_openssh
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")
  defined_tags = var.defined_tags_set

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
    memory_in_gbs             = "12"
    ocpus                     = "1"
  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-alicante-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-alicante-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

module "nsg-alicante" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.production
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-alicante"
  defined_tags   = var.defined_tags_set
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
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = null
      max_port    = null
      description = "Admin VPN with full access"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-alicante.nsg_id
}
