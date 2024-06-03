output "nsg_id_stockport" {
  value = module.nsg-stockport.nsg_id
}

resource "tls_private_key" "rsa-4096-stockport" {
  algorithm = "RSA"
}

output "private_key_stockport" {
  value     = tls_private_key.rsa-4096-stockport.private_key_pem
  sensitive = true
}

output "public_key_stockport" {
  value     = tls_private_key.rsa-4096-stockport.public_key_openssh
  sensitive = true
}

output "ip_address_stockport" {
  value = module.oci_core_instance_stockport.instance_ip
}

module "oci_core_instance_stockport" {
  source = "../../../modules/new-instance-v2"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.production
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "stockport"
  private_ip                  = "10.1.1.71" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-stockport.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-stockport.public_key_openssh
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
    memory_in_gbs             = "24"
    ocpus                     = "2"
  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-stockport-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-stockport-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

module "nsg-stockport" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.production
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-stockport"
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
      description = "PGSQL admin VPN port "
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-plus.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "pd-jimi-g5-v6-plus-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-plus.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 1935
      max_port    = 1936
      description = "pd-jimi-g5-v6-plus-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-plus.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "pd-jimi-g5-v6-plus-services-media-8881"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-plus.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "pd-jimi-g5-v6-plus-services-upload-23010"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-oxford
      min_port    = 15477
      max_port    = 15477
      description = "PGSQL for Kafka"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.2/32"
      min_port    = 9001
      max_port    = 9002
      description = "Portainer"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-sevilha
      min_port    = null
      max_port    = null
      description = "Acess tasks"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-london
      min_port    = 8881
      max_port    = 10000
      description = "Access Streamer London"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-gateshead
      min_port    = 40106
      max_port    = 40106
      description = "Access FileList Jimi"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-stockport.nsg_id
}
