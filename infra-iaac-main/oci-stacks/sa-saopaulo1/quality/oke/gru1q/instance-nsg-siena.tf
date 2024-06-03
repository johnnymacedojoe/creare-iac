module "oci_core_instance_siena" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.quality
  subnet_id           = module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q2"]
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "siena"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-siena.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-siena.public_key_openssh
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = local.latest_ol_arm_image_id
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.A1.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "8"
    ocpus                     = "2"

  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-siena-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-siena-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_siena" {
  value = module.oci_core_instance_siena.instance_ip
}


module "nsg-siena" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.quality
  vnc_id         = module.vcn-oci-oke-gru1q.vcn_id
  nsg_name       = "nsg-siena"
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
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.1.121/32"
      min_port    = null
      max_port    = null
      description = "VPN acess"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.1.122/32"
      min_port    = 15500
      max_port    = 15500
      description = "VPN Cannes access"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"   // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 15500
      max_port    = 15500
      description = "QA Redis Passanger Port"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"   // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 15501
      max_port    = 15501
      description = "QA Isadatapro pgsql Port"
    }
  ]
}

output "nsg_id_siena" {
  value = module.nsg-siena.nsg_id
}


resource "tls_private_key" "rsa-4096-siena" {
  algorithm = "RSA"
}

output "private_key_siena" {
  value     = tls_private_key.rsa-4096-siena.private_key_pem
  sensitive = true
}

output "public_key_siena" {
  value     = tls_private_key.rsa-4096-siena.public_key_openssh
  sensitive = true
}
