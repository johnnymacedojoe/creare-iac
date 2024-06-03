output "nsg_id_blackpool" {
  value = module.nsg-blackpool.nsg_id
}

resource "tls_private_key" "rsa-4096-blackpool" {
  algorithm = "RSA"
}

output "private_key_blackpool" {
  value     = tls_private_key.rsa-4096-blackpool.private_key_pem
  sensitive = true
}

output "public_key_blackpool" {
  value     = tls_private_key.rsa-4096-blackpool.public_key_openssh
  sensitive = true
}

output "ip_address_blackpool" {
  value = module.oci_core_instance_blackpool.instance_ip
}

module "oci_core_instance_blackpool" {
  source = "../../../modules/new-instance-v2"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.production
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "blackpool"
  private_ip                  = "10.1.1.91" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-blackpool.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-blackpool.public_key_openssh
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
      display_name = "bv-blackpool-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-blackpool-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

module "nsg-blackpool" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.production
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-blackpool"
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
      description = "All ports change after configuration change for only necessary ports"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-k4.nsg_id
      min_port    = 9090
      max_port    = 9099
      description = "Stonkan pd Ports from Services"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-malaga
      min_port    = 3306
      max_port    = 3306
      description = "For Kafka Iot Positions Purpose"
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
      source      = var.nsg_gateshead
      min_port    = 8082
      max_port    = 8082
      description = "Kong to CMS server"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-sevilha
      min_port    = null
      max_port    = null
      description = "All from k8s sevilha pd"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-blackpool.nsg_id
}
