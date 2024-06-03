module "oci_core_instance_floripa" {
  source = "./modules/new-instance"

  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.bryancloud-compartment_ocid
  subnet_id           = module.vcn-oci-spo1i.subnet_ids["sn-oci-spo1i0"]
  fault_domain        = "FAULT-DOMAIN-1"
  instance_name       = "floripa"
  //private_ip                  = "10.5.0.3"
  nsg_ids                     = [module.nsg-floripa.nsg_id]
  ssh_public_key_path         = "./id_rsa.pub"
  assign_public_ip            = true
  is_live_migration_preferred = true
  recovery_action             = "RESTORE_INSTANCE"
  instance_userdata           = file("./user_data.sh")

  source_details = {
    source_type             = "image"
    source_id               = local.latest_ol_arm_image_id //"ocid1.image.oc1.iad.aaaaaaaalw7mfv2zza67zvyxwz23tiz5pfeq3no7ejyou5e42eiggb7b4bpq" //Oracle-Linux-9.2-aarch64-2023.07.31-0 image OCID
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    //kms_key_id              = var.vault-block-volume-key
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

output "ip_address_floripa" {
  value = module.oci_core_instance_floripa.instance_ip
}


