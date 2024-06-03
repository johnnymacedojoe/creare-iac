module "oci_core_instance_devon" {
  source = "../../../modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.BU-Safety-compartment_ocid
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "devon"
  private_ip                  = "10.1.1.100" //Verificar IP Ñ ESQUECER
  nsg_ids                     = [module.nsg-devon.nsg_id, var.nsg-spo1p-linux-server]
  ssh_public_key_path         = "./oci.pub"
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")
  defined_tags = var.defined_tags_set

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
    memory_in_gbs             = "32"
    ocpus                     = "2"

  }
  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-devon-docker-containers"
      size_in_gbs  = 350
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-devon-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address_devon" {
  value = module.oci_core_instance_devon.instance_ip
}
