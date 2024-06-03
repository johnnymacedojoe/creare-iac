module "oci_core_instance_viamao" {
  source = "./new-instance"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.Sandbox-compartment_ocid
  subnet_id           = var.sn-oci-spo1s0
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "viamao"
  //private_ip                  = "10.5.0.3"
  //nsg_ids                     = [var.nsg-spo1p-linux-server]
  ssh_public_key_path         = "./oci.pub"
  assign_public_ip            = true
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

  //create_attachment = false // set this to false if you dont wanna create attachments

  volumes = [
    {
      display_name = "bv-viamao-disk-d"
      size_in_gbs  = 100
      //device       = "/dev/oracleoci/oraclevdb" 
    }
  ]
}

output "ip_address" {
  value = module.oci_core_instance_viamao.instance_ip
}
