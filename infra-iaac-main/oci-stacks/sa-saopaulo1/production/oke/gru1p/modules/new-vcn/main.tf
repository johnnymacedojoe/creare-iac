terraform { //For vars optional works on stack oci
  experiments = [module_variable_optional_attrs]
}

data "oci_core_services" "all_services" {}

locals {
  full_display_name_default_rt = "dhcp-df-${var.display_name}"
  full_display_name_default_sl = "sl-df-${var.display_name}"
  full_search_domain           = "${var.dns_label}.oraclevcn.com"
}

resource "oci_core_vcn" "cs_core_vcn" {

  compartment_id = var.compartment_id
  cidr_blocks    = var.cidr_blocks
  defined_tags   = var.defined_tags
  display_name   = var.display_name
  dns_label      = var.dns_label

  lifecycle {
    ignore_changes = [
      defined_tags
    ]
  }

}

resource "oci_core_security_list" "custom_security_list" {
  for_each = { for sl in var.custom_security_lists : sl.display_name => sl }

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.cs_core_vcn.id
  display_name   = each.value.display_name

  dynamic "ingress_security_rules" {
    for_each = each.value.ingress_rules
    content {
      protocol    = ingress_security_rules.value.protocol
      source      = ingress_security_rules.value.source
      description = ingress_security_rules.value.description

      dynamic "tcp_options" {
        for_each = ingress_security_rules.value.protocol == "6" && ingress_security_rules.value.tcp_options != null ? [ingress_security_rules.value.tcp_options] : []
        content {
          min = tcp_options.value.min
          max = tcp_options.value.max
        }
      }

      dynamic "udp_options" {
        for_each = ingress_security_rules.value.protocol == "17" && ingress_security_rules.value.udp_options != null ? [ingress_security_rules.value.udp_options] : []
        content {
          min = udp_options.value.min
          max = udp_options.value.max
        }
      }
    }
  }

  dynamic "egress_security_rules" {
    for_each = each.value.egress_rules
    content {
      destination = egress_security_rules.value.destination
      protocol    = egress_security_rules.value.protocol
    }
  }
}




resource "oci_core_default_security_list" "default_security_list" {
  manage_default_resource_id = oci_core_vcn.cs_core_vcn.default_security_list_id
  display_name               = local.full_display_name_default_sl

  dynamic "ingress_security_rules" {
    for_each = var.df_sl_ingress_rules
    content {
      protocol    = ingress_security_rules.value.protocol
      source      = ingress_security_rules.value.source
      description = ingress_security_rules.value.description

      dynamic "tcp_options" {
        for_each = ingress_security_rules.value.protocol == "6" && ingress_security_rules.value.tcp_options != null ? [ingress_security_rules.value.tcp_options] : []
        content {
          min = tcp_options.value.min
          max = tcp_options.value.max

          dynamic "source_port_range" {
            for_each = tcp_options.value.source_port_range != null ? [tcp_options.value.source_port_range] : []
            content {
              min = source_port_range.value.min
              max = source_port_range.value.max
            }
          }
        }
      }

      dynamic "udp_options" {
        for_each = ingress_security_rules.value.protocol == "17" && ingress_security_rules.value.udp_options != null ? [ingress_security_rules.value.udp_options] : []
        content {
          min = udp_options.value.min
          max = udp_options.value.max

          dynamic "source_port_range" {
            for_each = udp_options.value.source_port_range != null ? [udp_options.value.source_port_range] : []
            content {
              min = source_port_range.value.min
              max = source_port_range.value.max
            }
          }
        }
      }
    }
  }

  egress_security_rules {
    destination = var.df_sl_egress_rule.destination
    protocol    = var.df_sl_egress_rule.protocol
  }
}

resource "oci_core_service_gateway" "cs_service_gateway" {
  count = var.service_gateway_display_name != null ? 1 : 0

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.cs_core_vcn.id
  display_name   = var.service_gateway_display_name

  dynamic "services" {
    for_each = [for service in data.oci_core_services.all_services.services : service if service.name != "OCI GRU Object Storage"]
    content {
      service_id = services.value.id
    }
  }
}


resource "oci_core_route_table" "cs_route_table" {
  for_each = var.route_rules

  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.cs_core_vcn.id
  display_name   = each.key

  dynamic "route_rules" {
    for_each = each.value
    content {
      network_entity_id = route_rules.value.network_entity_id
      cidr_block        = lookup(route_rules.value, "cidr_block", null)
      description       = lookup(route_rules.value, "description", null)
      destination       = lookup(route_rules.value, "destination", null)
      destination_type  = lookup(route_rules.value, "destination_type", null)
    }
  }
}

resource "oci_core_nat_gateway" "cs_nat_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.cs_core_vcn.id
  display_name   = var.nat_gateway_display_name
  public_ip_id   = var.nat_gateway_ip_id
}


resource "oci_core_subnet" "cs_subnet" {
  for_each = { for subnet in var.subnets : subnet.display_name => subnet }

  vcn_id         = oci_core_vcn.cs_core_vcn.id
  compartment_id = var.compartment_id

  cidr_block   = each.value.cidr_block
  display_name = each.value.display_name
  dns_label    = each.value.dns_label

  availability_domain = lookup(each.value, "availability_domain", null)
  route_table_id      = lookup(each.value, "route_table_id", null)
  security_list_ids   = lookup(each.value, "security_list_ids", null)
  //security_list_ids = [for name in each.value.security_list_names : oci_core_security_list.custom_security_list[name].id]
  prohibit_public_ip_on_vnic = lookup(each.value, "prohibit_public_ip_on_vnic", false)

}

resource "oci_core_internet_gateway" "cs_internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.cs_core_vcn.id

  display_name  = var.internet_gateway_display_name
  enabled       = var.internet_gateway_enabled
  defined_tags  = var.internet_gateway_defined_tags
  freeform_tags = var.internet_gateway_freeform_tags

  // If you are attaching the IGW to a route table use the below line
  route_table_id = var.internet_gateway_route_table_id
  lifecycle {
    ignore_changes = [
      defined_tags
    ]
  }
}

resource "oci_core_default_dhcp_options" "default-dhcp-options" {
  manage_default_resource_id = oci_core_vcn.cs_core_vcn.default_dhcp_options_id
  display_name               = local.full_display_name_default_rt

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = [local.full_search_domain]
  }
}

resource "oci_core_dhcp_options" "cs_core_dhcp" {
  for_each       = var.dhcp_options != null ? { for dhcp in var.dhcp_options : dhcp.display_name => dhcp } : {}
  vcn_id         = oci_core_vcn.cs_core_vcn.id
  compartment_id = var.compartment_id
  display_name   = each.value.display_name
  options {
    type                = "SearchDomain"
    search_domain_names = each.value.search_domain_names
  }
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
}