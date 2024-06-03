resource "oci_file_storage_file_system" "du_file_system" {
  #Required
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp

  #Optional
  display_name = "Docker Uploads"
}

resource "oci_file_storage_file_system" "dr_file_system" {
  #Required
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp

  #Optional
  display_name = "Docker Repository"
}

resource "oci_file_storage_file_system" "stage_file_system" {
  #Required
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp

  #Optional
  display_name = "stage"
}

resource "oci_file_storage_file_system" "iot_file_system" {
  #Required
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp

  #Optional
  display_name = "iot"
}

resource "oci_file_storage_file_system" "appdata_file_system" {
  #Required
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp

  #Optional
  display_name = "appdata"
}

resource "oci_file_storage_mount_target" "iad1p_mount_target" {
  #Required
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.BU-corp
  subnet_id           = var.sn-oci-oke-iad1p2

  #Optional
  display_name   = "MT - Dockers Instances"
  ip_address     = "10.10.2.50"
  hostname_label = "fs-docker-iad1p"
  nsg_ids        = [module.nsg-mt-docker-repo.nsg_id]
}


