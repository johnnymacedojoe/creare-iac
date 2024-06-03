module "oci_core_instance_hunderton" {
  source = "./modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.BU-Safety-compartment_ocid
  subnet_id                   = var.sn-oci-spo1p1
  fault_domain                = "FAULT-DOMAIN-1"
  instance_name               = "hunderton"
  private_ip                  = "10.1.1.16"
  nsg_ids                     = [module.nsg-hunderton.nsg_id, var.nsg-spo1p-linux-server]
  ssh_public_key_path         = "./oci_import.pub"
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  //instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = var.img-docker-host-1-3
    boot_volume_size_in_gbs = 47
    boot_volume_vpus_per_gb = 10
    kms_key_id              = var.vault-block-volume-key
  }

  shape = "VM.Standard.E4.Flex"
  shape_config = {
    baseline_ocpu_utilization = "BASELINE_1_1" // non-burstable
    memory_in_gbs             = "8"
    ocpus                     = "1"

  }

  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-hunderton-docker-containers"
      size_in_gbs  = 60
      device       = "/dev/oracleoci/oraclevdc"
    },
    {
      display_name = "bv-hunderton-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    }
  ]
}

output "ip_address_hunderton" {
  value = module.oci_core_instance_hunderton.instance_ip
}
