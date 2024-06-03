terraform { //For vars optional works on stack oci
  experiments = [module_variable_optional_attrs]
}

resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  is_private     = var.is_private
  subnet_ids     = var.subnet_ids
  shape          = "flexible"
  dynamic "reserved_ips" {
    for_each = var.public_ip != null ? [var.public_ip] : []
    content {
      id = reserved_ips.value
    }
  }
  network_security_group_ids = var.network_security_group_ids
  //freeform_tags  = var.freeform_tags

  shape_details {
    minimum_bandwidth_in_mbps = var.minimum_bandwidth
    maximum_bandwidth_in_mbps = var.maximum_bandwidth
  }
  defined_tags = var.defined_tags
}

resource "oci_load_balancer_backend_set" "backend_set" {
  for_each = { for bs in var.backend_sets : bs.name => bs }

  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  name             = each.value.name
  policy           = each.value.policy

  health_checker {
    port     = each.value.health_checker.port
    protocol = each.value.health_checker.protocol
    url_path = each.value.health_checker.url_path
  }

  dynamic "ssl_configuration" {
    for_each = each.value.ssl_configuration != null ? [each.value.ssl_configuration] : []
    content {
      certificate_ids = [ssl_configuration.value.certificate_ids]
      //certificate_name        = ssl_configuration.value.certificate_name
      verify_depth            = lookup(ssl_configuration.value, "verify_depth", null)
      verify_peer_certificate = lookup(ssl_configuration.value, "verify_peer_certificate", null)
    }
  }
}

resource "oci_load_balancer_backend" "backend" {
  for_each = { for b in flatten([for i, bs in var.backend_sets : [for j, be in bs.backends : merge(be, { backend_set_name = bs.name, backend_set_index = i, backend_index = j })]]) : "${b.backend_set_index}-${b.backend_index}" => b }

  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  backendset_name  = each.value.backend_set_name
  ip_address       = each.value.ip_address
  port             = each.value.port

  depends_on = [oci_load_balancer_backend_set.backend_set]
}


resource "oci_load_balancer_listener" "listener" {
  for_each = { for ls in var.listeners : ls.name => ls }

  load_balancer_id         = oci_load_balancer_load_balancer.lb.id
  name                     = each.value.name
  default_backend_set_name = oci_load_balancer_backend_set.backend_set[each.value.backend_set_name].name
  protocol                 = each.value.protocol
  port                     = each.value.port

  dynamic "ssl_configuration" {
    for_each = each.value.ssl_configuration != null ? [each.value.ssl_configuration] : []
    content {
      certificate_ids = [ssl_configuration.value.certificate_ids]
      //certificate_name        = ssl_configuration.value.certificate_name
      verify_depth            = lookup(ssl_configuration.value, "verify_depth", null)
      verify_peer_certificate = lookup(ssl_configuration.value, "verify_peer_certificate", null)
    }
  }
}
