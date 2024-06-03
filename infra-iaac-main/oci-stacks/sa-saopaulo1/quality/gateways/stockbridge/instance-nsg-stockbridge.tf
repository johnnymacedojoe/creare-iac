output "nsg_id_stockbridge" {
  value = module.nsg-stockbridge.nsg_id
}

resource "tls_private_key" "rsa-4096-stockbridge" {
  algorithm = "RSA"
}

output "private_key_stockbridge" {
  value     = tls_private_key.rsa-4096-stockbridge.private_key_pem
  sensitive = true
}

output "public_key_stockbridge" {
  value     = tls_private_key.rsa-4096-stockbridge.public_key_openssh
  sensitive = true
}

output "ip_address_stockbridge" {
  value = module.oci_core_instance_stockbridge.instance_ip
}

module "oci_core_instance_stockbridge" {
  source = "../../../modules/new-instance-v2"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.BU-Safety-compartment_ocid
  subnet_id                   = var.sn-oci-spo1p2
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "stockbridge"
  private_ip                  = "10.1.2.71" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-stockbridge.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-stockbridge.public_key_openssh
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
    memory_in_gbs             = "16"
    ocpus                     = "2"
  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-stockbridge-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-stockbridge-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

module "nsg-stockbridge" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Safety-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-stockbridge"
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
      source      = var.nsg-cannes
      min_port    = 40089
      max_port    = 40089
      description = "Rabbit MQ admin port"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 40089
      max_port    = 40089
      description = "Rabbit MQ admin port "
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
      source      = module.nsg-qa-lbgw-cs-g5-plus.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "qa-jimi-g5-v6-plus-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5-plus.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 9080
      max_port    = 9080
      description = "qa-jimi-g5-v6-plus-services-api-9080"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5-plus.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 1935
      max_port    = 1936
      description = "qa-jimi-g5-v6-plus-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5-plus.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "qa-jimi-g5-v6-plus-services-media-8881"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"             // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5-plus.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "qa-jimi-g5-v6-plus-services-upload-23010"
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
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 9080
      max_port    = 9080
      description = "Request API internal VPN"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 15477
      max_port    = 15477
      description = "PGSQL for normal VPN"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-bradford
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
      source      = var.nsg-esparta
      min_port    = null
      max_port    = null
      description = "Acess tasks"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-atenas
      min_port    = null
      max_port    = null
      description = "Access Streamer Atenas"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-gateshead
      min_port    = 40106
      max_port    = 40106
      description = "Access FileList Jimi"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 9080
      max_port    = 9080
      description = "Access API from VPN Cannes"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 40106
      max_port    = 40106
      description = "Access Listener from VPN Cannes"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-stockbridge.nsg_id
}
