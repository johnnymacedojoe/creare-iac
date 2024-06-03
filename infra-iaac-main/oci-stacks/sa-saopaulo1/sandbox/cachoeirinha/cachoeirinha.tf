

module "oci_core_instance_cachoeirinha" {
  source = "./new-instance"

  availability_domain = var.availability_domain_sp
  compartment_id      = var.Sandbox-compartment_ocid
  subnet_id           = var.sn-oci-spo1p2
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "cachoeirinha"
  //private_ip                  = "10.5.0.3"
  nsg_ids                     = [var.nsg-spo1p-linux-server, "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaxhirutxlcmfiwbwlkizfaf4kqb5xi23khyghh6yzoedimwt7asna"]
  ssh_public_key_path         = "./oci.pub"
  assign_public_ip            = false
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  instance_userdata           = file("./user_data.sh")

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
    memory_in_gbs             = "8"
    ocpus                     = "1"
  }
  volumes = [
    {
      display_name = "bv-cachoeirinha-vol1"
      size_in_gbs  = 50
      device       = "/dev/oracleoci/oraclevdb"
    }
    /*{
      display_name = "bv-cachoeirinha-var-lib"
      size_in_gbs  = 50
      device       =  "/dev/oracleoci/oraclevdc" 
    }*/
  ]

}


output "ip_address" {
  value = module.oci_core_instance_cachoeirinha.instance_ip
}


