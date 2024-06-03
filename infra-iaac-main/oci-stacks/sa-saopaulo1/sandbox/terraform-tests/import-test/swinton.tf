module "oci_core_instance_swinton" {
  source = "./modules/new-instance"

  availability_domain         = var.availability_domain_sp
  compartment_id              = var.cs-compartment_ocid
  subnet_id                   = var.sn-oci-spo1p2
  fault_domain                = "FAULT-DOMAIN-2"
  instance_name               = "swinton"
  private_ip                  = "10.1.2.16"
  nsg_ids                     = [var.nsg-spo1p-linux-server, "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaazzluq452htw5xvo4riuurraeig6pqom4lizfhhv5mwjutfmqzhwq"]
  ssh_public_key_path         = "./oci.pub"
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
      display_name = "bv-swinton-docker-containers"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    },
    {
      display_name = "bv-swinton-var-lib-docker"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdc"
    }
  ]
}

output "ip_address" {
  value = module.oci_core_instance_swinton.instance_ip
}
