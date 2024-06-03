terraform { //For vars optional works on stack oci
  experiments = [module_variable_optional_attrs]
}
resource "oci_containerengine_cluster" "cs_oke" {
  # Required Fields
  compartment_id     = var.compartment_id
  kubernetes_version = var.kubernetes_version
  name               = var.name
  vcn_id             = var.vcn_id
  type               = var.type

  # Optional Fields for Network Options
  dynamic "cluster_pod_network_options" {
    for_each = var.cluster_pod_network_options != {} ? [var.cluster_pod_network_options] : []
    content {
      cni_type = lookup(cluster_pod_network_options.value, "cni_type", null)
    }
  }

  # Optional Fields for Endpoint Configuration
  dynamic "endpoint_config" {
    for_each = var.endpoint_config != null ? [var.endpoint_config] : []
    content {
      is_public_ip_enabled = endpoint_config.value.is_public_ip_enabled
      nsg_ids              = endpoint_config.value.nsg_ids
      subnet_id            = endpoint_config.value.subnet_id
    }
  }


  # Optional Fields for Image Policy
  dynamic "image_policy_config" {
    for_each = [for x in [var.image_policy_config] : x if x != {}]
    content {
      is_policy_enabled = lookup(image_policy_config.value, "is_policy_enabled", false)
      dynamic "key_details" {
        for_each = lookup(image_policy_config.value, "is_policy_enabled", false) ? list(lookup(image_policy_config.value, "key_details", {})) : []
        content {
          kms_key_id = key_details.value["kms_key_id"]
        }
      }
    }
  }

  # Optional Fields for Kubernetes Options
  dynamic "options" {
    for_each = var.options != {} ? [var.options] : []
    content {
      add_ons {
        is_kubernetes_dashboard_enabled = lookup(options.value, "is_kubernetes_dashboard_enabled", null)
        is_tiller_enabled               = lookup(options.value, "is_tiller_enabled", null)
      }
      admission_controller_options {
        is_pod_security_policy_enabled = lookup(options.value, "is_pod_security_policy_enabled", null)
      }
      kubernetes_network_config {
        pods_cidr     = lookup(options.value, "pods_cidr", null)
        services_cidr = lookup(options.value, "services_cidr", null)
      }
      service_lb_subnet_ids = lookup(options.value, "service_lb_subnet_ids", null)
    }
  }

  lifecycle {
    ignore_changes = [
      defined_tags
    ]
  }

  # Tags
  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}


resource "oci_containerengine_node_pool" "cs_oke_node_pool" {
  for_each = { for np in var.node_pools : np.name => np }

  # Required
  cluster_id     = oci_containerengine_cluster.cs_oke.id
  compartment_id = var.compartment_id
  name           = each.value.name
  node_shape     = each.value.node_shape

  # Optional
  defined_tags  = each.value.defined_tags
  freeform_tags = each.value.freeform_tags

  initial_node_labels {
    key   = each.value.initial_node_labels_key
    value = each.value.initial_node_labels_value
  }

  kubernetes_version = each.value.kubernetes_version
  lifecycle {
    ignore_changes = [
      initial_node_labels
    ]
  }

  node_config_details {
    placement_configs {
      availability_domain = each.value.placement_configs_availability_domain
      subnet_id           = each.value.placement_configs_subnet_id

      # Optional
      capacity_reservation_id = each.value.placement_configs_capacity_reservation_id
      fault_domains           = each.value.placement_configs_fault_domains

      # Conditional block for preemptible_node_config
      dynamic "preemptible_node_config" {
        for_each = each.value.preemption_action_type != null ? [1] : []
        content {
          preemption_action {
            type                    = each.value.preemption_action_type
            is_preserve_boot_volume = each.value.preemption_action_is_preserve_boot_volume
          }
        }
      }
    }


    size = each.value.size

    # Optional fields
    is_pv_encryption_in_transit_enabled = each.value.is_pv_encryption_in_transit_enabled
    kms_key_id                          = each.value.kms_key_id

    node_pool_pod_network_option_details {
      cni_type          = each.value.cni_type
      max_pods_per_node = each.value.max_pods_per_node
      pod_nsg_ids       = each.value.pod_nsg_ids
      pod_subnet_ids    = each.value.pod_subnet_ids
    }


    defined_tags  = each.value.defined_tags
    freeform_tags = each.value.freeform_tags
    nsg_ids       = each.value.nsg_ids
  }
  node_shape_config {

    #Optional
    memory_in_gbs = each.value.node_pool_node_shape_config_memory_in_gbs
    ocpus         = each.value.node_pool_node_shape_config_ocpus
  }

  node_source_details {
    #Required
    image_id    = each.value.node_pool_image_id
    source_type = each.value.node_pool_node_source_details_source_type

    #Optional
    boot_volume_size_in_gbs = each.value.node_pool_node_source_details_boot_volume_size_in_gbs
  }
}

