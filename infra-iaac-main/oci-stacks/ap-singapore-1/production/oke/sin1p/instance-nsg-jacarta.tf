module "oci_core_instance_jacarta" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu_april
  subnet_id           = module.vcn-oci-oke-sin1p.subnet_ids["sn-oci-oke-sin1p2"]
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "jacarta"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-jacarta.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-jacarta.public_key_openssh
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
      display_name = "bv-jacarta-vol1"
      size_in_gbs  = 100
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-jacarta-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_jacarta" {
  value = module.oci_core_instance_jacarta.instance_ip
}


module "nsg-jacarta" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.bu_april
  vnc_id         = module.vcn-oci-oke-sin1p.vcn_id
  nsg_name       = "nsg-jacarta"
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
      protocol    = "all"        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.1.32/32"
      min_port    = 15480
      max_port    = 15480
      description = "Instance Firenze HA Keycloak"
    }
    ,
    {
      direction   = "INGRESS"
      protocol    = "all"                    // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods-pd.nsg_id
      min_port    = 15480
      max_port    = 15480
      description = "Instance Pods to Keycloak PGSQL"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"                    // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods-pd.nsg_id
      min_port    = 27017
      max_port    = 27017
      description = "Instance Pods to MONGO"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"                    // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods-pd.nsg_id
      min_port    = 15472
      max_port    = 15472
      description = "Instance Pods to FCC DB PGSQL"
    }
  ]
}

output "nsg_id_jacarta" {
  value = module.nsg-jacarta.nsg_id
}


resource "tls_private_key" "rsa-4096-jacarta" {
  algorithm = "RSA"
}

output "private_key_jacarta" {
  value     = tls_private_key.rsa-4096-jacarta.private_key_pem
  sensitive = true
}

output "public_key_jacarta" {
  value     = tls_private_key.rsa-4096-jacarta.public_key_openssh
  sensitive = true
}
