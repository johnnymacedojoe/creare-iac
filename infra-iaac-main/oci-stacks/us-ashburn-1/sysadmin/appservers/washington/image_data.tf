data "oci_core_images" "oraclelinux_arm_images" {
  compartment_id   = var.SysAdmin
  operating_system = "Oracle Linux"
  shape            = "VM.Standard.A1.Flex"

  sort_by    = "DISPLAYNAME" //TIMECREATED
  sort_order = "DESC"        //ASC # This will ensure the latest image is first in the list
}

locals {
  latest_ol_arm_image_id = data.oci_core_images.oraclelinux_arm_images.images[0].id
  latest_ol_arm_image    = data.oci_core_images.oraclelinux_arm_images.images[0].display_name
}

output "latest_ol_arm_image" {
  value = local.latest_ol_arm_image
}

data "oci_core_images" "oraclelinux_amd_images" {
  compartment_id   = var.SysAdmin
  operating_system = "Oracle Linux"
  shape            = "VM.Standard.E5.Flex"

  sort_by    = "DISPLAYNAME" //TIMECREATED
  sort_order = "DESC"        //ASC # This will ensure the latest image is first in the list
}

locals {
  latest_ol_amd_image_id = data.oci_core_images.oraclelinux_amd_images.images[0].id
  latest_ol_amd_image    = data.oci_core_images.oraclelinux_amd_images.images[0].display_name
}

output "latest_ol_amd_image" {
  value = local.latest_ol_amd_image
}