module "oci_core_instance_lecco" {
  source = "../../../modules/new-instance"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.quality
  subnet_id           = var.sn-oci-spo1p2
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "lecco"
  //private_ip                  = "10.1.2.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-lecco.nsg_id, var.nsg-spo1p-linux-server]
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

  shape = "VM.Standard.E4.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "64"
    ocpus                     = "3"

  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-lecco-vol1"
      size_in_gbs  = 300
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-lecco-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_lecco" {
  value = module.oci_core_instance_lecco.instance_ip
}