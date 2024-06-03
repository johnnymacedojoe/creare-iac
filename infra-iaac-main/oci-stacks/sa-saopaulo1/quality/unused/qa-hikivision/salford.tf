module "oci_core_instance_salford" {
  source = "./modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.BU-Safety-compartment_ocid
  subnet_id                   = var.sn-oci-spo1p2
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "salford"
  private_ip                  = "10.1.2.15"
  nsg_ids                     = [module.nsg-salford.nsg_id]
  ssh_public_key_path         = "./oci.pub"
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = var.img-windows-h7-base-image-2016
    boot_volume_size_in_gbs = 100
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E4.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "32"
    ocpus                     = "3"
  }

}

resource "oci_core_volume_attachment" "volume_salford_attachment" {
  attachment_type                     = "paravirtualized"
  instance_id                         = module.oci_core_instance_salford.instance_id
  volume_id                           = var.bv-salford-disk-d
  is_pv_encryption_in_transit_enabled = true
  depends_on                          = [module.oci_core_instance_salford]
}

output "ip_address_salford" {
  value = module.oci_core_instance_salford.instance_ip
}
