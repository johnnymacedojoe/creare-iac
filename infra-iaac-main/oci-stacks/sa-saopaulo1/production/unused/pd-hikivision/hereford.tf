module "oci_core_instance_hereford" {
  source = "./modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.BU-Safety-compartment_ocid
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "hereford"
  private_ip                  = "10.1.1.15"
  nsg_ids                     = [module.nsg-hereford.nsg_id]
  ssh_public_key_path         = "./oci.pub"
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = var.img-windows-standard-2016
    boot_volume_size_in_gbs = 100
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E4.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "16"
    ocpus                     = "1"
  }

  volumes = [
    {
      display_name = "bv-hereford-disk-d"
      size_in_gbs  = 100
    }
  ]
}

output "ip_address" {
  value = module.oci_core_instance_hereford.instance_ip
}
