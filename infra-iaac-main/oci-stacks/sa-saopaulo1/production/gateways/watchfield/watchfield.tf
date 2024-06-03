module "instance-watchfield" {
  source = "../../../modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.production
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "watchfield"
  private_ip                  = "10.1.1.70"
  nsg_ids                     = [var.nsg-spo1p-linux-server, var.nsg-spo1p-docker-host, module.nsg-watchfield.nsg_id] //module.nsg-maidenhead.nsg_id
  ssh_public_key_path         = "./oci.pub"
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  instance_userdata           = file("./user_data.sh")
  defined_tags                = var.defined_tags_set

  source_details = {
    source_type             = "image"
    source_id               = var.img-docker-host-1-3
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E4.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "4"
    ocpus                     = "1"
  }

  volumes = [
    {
      display_name = "bv-watchfield-var-lib"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-watchfield-docker-containers"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "watchfield_ip_address" {
  value = module.instance-watchfield.instance_ip
}
