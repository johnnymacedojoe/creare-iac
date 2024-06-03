module "oci_core_instance_vigo" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.quality
  subnet_id           = var.sn-oci-spo1p2
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "vigo"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-vigo.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-vigo.public_key_openssh
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
      display_name = "bv-vigo-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-vigo-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_vigo" {
  value = module.oci_core_instance_vigo.instance_ip
}


module "nsg-vigo" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.quality
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-vigo"
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
      description = "VPN admin acess"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 22
      max_port    = 22
      description = "Marselha AWX"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.21.2.133/32"
      min_port    = null
      max_port    = null
      description = "Instance Bandung SIN"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-toledo3
      min_port    = 48080
      max_port    = 48080
      description = "Access Kong Keycloak DV"
    }
  ]
}

output "nsg_id_vigo" {
  value = module.nsg-vigo.nsg_id
}


resource "tls_private_key" "rsa-4096-vigo" {
  algorithm = "RSA"
}

output "private_key_vigo" {
  value     = tls_private_key.rsa-4096-vigo.private_key_pem
  sensitive = true
}

output "public_key_vigo" {
  value     = tls_private_key.rsa-4096-vigo.public_key_openssh
  sensitive = true
}
