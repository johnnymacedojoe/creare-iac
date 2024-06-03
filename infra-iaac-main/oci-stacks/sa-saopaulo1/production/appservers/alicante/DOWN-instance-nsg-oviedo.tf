/*module "oci_core_instance_oviedo" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.BU-Corp-compartment_ocid
  subnet_id           = var.sn-oci-spo1p1
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "oviedo"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-oviedo.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-oviedo.public_key_openssh
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
    memory_in_gbs             = "256"
    ocpus                     = "24"
  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-oviedo-vol1"
      size_in_gbs  = 3072
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-oviedo-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_oviedo" {
  value = module.oci_core_instance_oviedo.instance_ip
}


module "nsg-oviedo" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-oviedo"
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
      description = "VPN admin access"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 22
      max_port    = 22
      description = "Marselha AWX"
    }
  ]
}

output "nsg_id_oviedo" {
  value = module.nsg-oviedo.nsg_id
}


resource "tls_private_key" "rsa-4096-oviedo" {
  algorithm = "RSA"
}

output "private_key_oviedo" {
  value     = tls_private_key.rsa-4096-oviedo.private_key_pem
  sensitive = true
}

output "public_key_oviedo" {
  value     = tls_private_key.rsa-4096-oviedo.public_key_openssh
  sensitive = true
}
*/