resource "oci_file_storage_file_system" "du_file_system" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu-agro

  #Optional
  display_name = "Docker Uploads"
}

resource "oci_file_storage_file_system" "dr_file_system" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu-agro

  #Optional
  display_name = "Docker Repository"
}

resource "oci_file_storage_file_system" "stage_file_system" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu-agro

  #Optional
  display_name = "stage"
}

resource "oci_file_storage_file_system" "iot_file_system" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu-agro

  #Optional
  display_name = "iot"
}

resource "oci_file_storage_file_system" "appdata_file_system" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu-agro

  #Optional
  display_name = "appdata"
}

resource "oci_file_storage_mount_target" "sin1q_mount_target" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu-agro
  subnet_id           = var.sn-oci-oke-sin1q2

  #Optional
  display_name   = "MT - Dockers Instances"
  ip_address     = "10.21.2.51"
  hostname_label = "fs-docker-sin1q"
  nsg_ids        = [module.nsg-mt-docker-repo.nsg_id]
}

resource "oci_file_storage_mount_target" "sin1p_mount_target" {
  #Required
  availability_domain = var.availability_domain_sin
  compartment_id      = var.bu_april
  subnet_id           = var.sn-oci-oke-sin1p2

  #Optional
  display_name   = "MT - Dockers Instances - PD"
  ip_address     = "10.20.2.51"
  hostname_label = "fs-docker-sin1p"
  nsg_ids        = [module.nsg-mt-docker-repo-pd.nsg_id]
}
