/*
module "oci_nsg" {
  source         = "../../modules/new-nsg"
  compartment_id = var.cs-compartment_ocid
  vnc_id         = var.vcn-oci-spo1s
  nsg_name       = "nsg-esteio"
  nsg_rules = [
    {
      id               = "rule1"
      direction        = "INGRESS"
      protocol         = "all"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type      = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source           = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK" // This is not actually used in the INGRESS rule but needs to be provided.
      destination      = "0.0.0.0/0"  // This is not actually used in the INGRESS rule but needs to be provided.
      min_port         = 22
      max_port         = 65536
    },
    {
      id               = "rule2"
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      source_type      = "CIDR_BLOCK" // This is not actually used in the EGRESS rule but needs to be provided.
      source           = "0.0.0.0/0"  // This is not actually used in the EGRESS rule but needs to be provided.
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
    }
  ]
}

module "oci_core_instance" {
  source = "./modules/new-instance"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.cs-compartment_ocid
  subnet_id           = var.sn-oci-spo1s0
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "esteio"
  private_ip                  = "10.5.0.3"
  //nsg_ids                     = "" //[var.nsg-spo1p-linux-server, module.oci_nsg.nsg_id]
  ssh_public_key_path         = "~/.ssh/oci.pub"
  assign_public_ip            = true
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = ""//file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = var.img-docker-host-1-4
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E4.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "8"
    ocpus                     = "1"
  }

  volumes = [
    {
      display_name = "bv-esteio-var-lib-docker"
      size_in_gbs  = 50
    },
    {
      display_name = "bv-esteio-docker-container"
      size_in_gbs  = 50
    }
  ]
}

output "ip_address" {
  value = module.oci_core_instance.instance_ip
}


*/