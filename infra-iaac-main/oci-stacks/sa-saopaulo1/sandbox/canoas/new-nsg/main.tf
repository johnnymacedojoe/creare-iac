terraform { //For vars optional works on stack oci
  experiments = [module_variable_optional_attrs]
} /**/

resource "oci_core_network_security_group" "nsg" {
  compartment_id = var.compartment_id
  vcn_id         = var.vnc_id
  display_name   = var.nsg_name
}

resource "oci_core_network_security_group_security_rule" "nsg_rule" {
  for_each = { for index, rule in var.nsg_rules : format("rule-%d", index) => rule }

  network_security_group_id = oci_core_network_security_group.nsg.id

  direction   = each.value.direction
  protocol    = each.value.protocol
  description = each.value.description

  source_type = each.value.source_type
  source      = each.value.source
  stateless   = false

  destination_type = each.value.destination_type
  destination      = each.value.destination

  dynamic "tcp_options" {
    for_each = each.value.protocol == "6" && each.value.direction == "INGRESS" ? [1] : []
    content {
      dynamic "destination_port_range" {
        for_each = each.value.min_port != null && each.value.max_port != null ? [1] : []
        content {
          min = each.value.min_port
          max = each.value.max_port
        }
      }
    }
  }

  dynamic "udp_options" {
    for_each = each.value.protocol == "17" && each.value.direction == "INGRESS" ? [1] : []
    content {
      dynamic "destination_port_range" {
        for_each = each.value.min_port != null && each.value.max_port != null ? [1] : []
        content {
          min = each.value.min_port
          max = each.value.max_port
        }
      }
    }
  }
}