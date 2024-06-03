terraform { //For vars optional works on stack oci
  experiments = [module_variable_optional_attrs]
}
resource "oci_core_instance" "instance" {
  agent_config {
    are_all_plugins_disabled = var.are_all_plugins_disabled
    is_management_disabled   = var.is_management_disabled
    is_monitoring_disabled   = var.is_monitoring_disabled

    dynamic "plugins_config" {
      for_each = var.plugins_config
      content {
        desired_state = plugins_config.value["desired_state"]
        name          = plugins_config.value["name"]
      }
    }
  }

  source_details {
    source_type             = var.source_details.source_type
    source_id               = var.source_details.source_id
    boot_volume_size_in_gbs = var.source_details.boot_volume_size_in_gbs
    boot_volume_vpus_per_gb = var.source_details.boot_volume_vpus_per_gb
    kms_key_id              = var.source_details.kms_key_id
  }

  is_pv_encryption_in_transit_enabled = var.enable_in_transit_encryption

  launch_options {
    boot_volume_type = "PARAVIRTUALIZED"
    firmware         = "UEFI_64"
    //is_pv_encryption_in_transit_enabled = "true"
    network_type            = "PARAVIRTUALIZED"
    remote_data_volume_type = "PARAVIRTUALIZED"
  }

  availability_config {
    is_live_migration_preferred = var.is_live_migration_preferred
    recovery_action             = var.recovery_action
  }

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id

  create_vnic_details {
    assign_public_ip       = var.assign_public_ip
    display_name           = var.instance_name
    hostname_label         = var.instance_name
    nsg_ids                = var.nsg_ids
    private_ip             = var.private_ip
    skip_source_dest_check = var.skip_source_dest_check
    subnet_id              = var.subnet_id
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to defined_tags and use_data
      #defined_tags,
      metadata["user_data"],
      source_details[0].source_id
    ]
  }

  defined_tags = var.defined_tags

  display_name = var.instance_name

  fault_domain = var.fault_domain

  metadata = {
    "ssh_authorized_keys" = var.ssh_public_key
    "user_data"           = var.instance_userdata != "" ? base64encode(var.instance_userdata) : null
  }

  shape = var.shape
  shape_config {
    baseline_ocpu_utilization = var.shape_config.baseline_ocpu_utilization
    memory_in_gbs             = var.shape_config.memory_in_gbs
    ocpus                     = var.shape_config.ocpus
  }

  preserve_boot_volume = var.preserve_boot_vol

}

resource "oci_core_volume" "volume" {
  count               = length(var.volumes)
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.volumes[count.index].display_name
  size_in_gbs         = var.volumes[count.index].size_in_gbs
  kms_key_id          = var.source_details.kms_key_id
  defined_tags        = var.defined_tags
}

resource "oci_core_volume_attachment" "volume_attachment" {
  count                               = var.create_attachment ? length(var.volumes) : 0
  attachment_type                     = "paravirtualized"
  instance_id                         = oci_core_instance.instance.id
  volume_id                           = oci_core_volume.volume[count.index].id
  is_pv_encryption_in_transit_enabled = true
  device                              = var.volumes[count.index].device
}


resource "oci_core_volume_group" "creare_volume_group" {
  count = length(oci_core_volume.volume) > 0 ? 1 : 0

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id

  source_details {
    type       = "volumeIds"
    volume_ids = concat(oci_core_volume.volume[*].id, [oci_core_instance.instance.boot_volume_id])
  }

  display_name = "vg-${var.instance_name}"
  defined_tags = var.defined_tags
}
