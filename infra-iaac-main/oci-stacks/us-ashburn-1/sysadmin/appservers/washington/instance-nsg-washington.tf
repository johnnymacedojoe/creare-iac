module "oci_core_instance_washington" {
  source = "../../../modules/new-instance-v2"

  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.SysAdmin
  subnet_id           = var.subnet_iad1p2
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "washington"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-washington.nsg_id]
  ssh_public_key              = tls_private_key.rsa-4096-washington.public_key_openssh
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
    ocpus                     = "4"

  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-washington-docker-containers"
      size_in_gbs  = 200
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-washington-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_washington" {
  value = module.oci_core_instance_washington.instance_ip
}


module "nsg-washington" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.SysAdmin
  vnc_id         = var.vcn_iad1p
  nsg_name       = "nsg-washington"
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

output "nsg_id_washington" {
  value = module.nsg-washington.nsg_id
}


resource "tls_private_key" "rsa-4096-washington" {
  algorithm = "RSA"
}

output "private_key_washington" {
  value     = tls_private_key.rsa-4096-washington.private_key_pem
  sensitive = true
}

output "public_key_washington" {
  value     = tls_private_key.rsa-4096-washington.public_key_openssh
  sensitive = true
}
