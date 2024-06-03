module "oci_core_instance_gateshead1" {
  source = "../../../modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.production
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "gateshead1"
  private_ip                  = "10.1.1.131"
  nsg_ids                     = [module.nsg-gateshead.nsg_id]
  ssh_public_key_path         = "./oci.pub"
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
    memory_in_gbs             = "4"
    ocpus                     = "2"
  }

  /*volumes = [
    {
      display_name = "bv-cachoeirinha-docker-containers"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb" 
    },
    {
      display_name = "bv-cachoeirinha-var-lib"
      size_in_gbs  = 50
      device       =  "/dev/oracleoci/oraclevdc" 
    }
  ]*/

}

output "ip_address_gateshead1" {
  value = module.oci_core_instance_gateshead1.instance_ip
}


