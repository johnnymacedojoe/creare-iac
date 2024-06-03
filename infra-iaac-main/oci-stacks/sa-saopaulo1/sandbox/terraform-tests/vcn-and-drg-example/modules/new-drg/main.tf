resource "oci_core_drg" "cs_drg" {
  compartment_id = var.compartment_id
  display_name   = var.drg_display_name
}

resource "oci_core_drg_attachment" "cs_drg_attachment" {
  for_each = { for att in var.drg_att : att.display_name => att }

  drg_id             = oci_core_drg.cs_drg.id
  display_name       = each.key
  drg_route_table_id = try(each.value.drg_route_table_id, null)

  dynamic "network_details" {
    for_each = [each.value]

    content {
      id             = network_details.value.network_entity_id
      type           = try(network_details.value.type, null)
      route_table_id = try(network_details.value.route_table_id, null)
      vcn_route_type = try(network_details.value.vcn_route_type, null)
    }
  }
}