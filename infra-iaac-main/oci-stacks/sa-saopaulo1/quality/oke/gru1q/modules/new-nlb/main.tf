terraform { //For vars optional works on stack oci
  experiments = [module_variable_optional_attrs]
}

resource "oci_network_load_balancer_network_load_balancer" "nbl" {
  compartment_id             = var.compartment_id
  display_name               = var.display_name
  is_private                 = var.is_private
  subnet_id                  = var.subnet_id
  nlb_ip_version             = var.nlb_ip_version
  network_security_group_ids = var.network_security_group_ids
  dynamic "reserved_ips" {
    for_each = var.public_ip != null ? [var.public_ip] : []
    content {
      id = reserved_ips.value
    }
  }
  is_preserve_source_destination = var.is_preserve_source
}

resource "oci_network_load_balancer_backend_set" "backend_set" {
  for_each = { for bs in var.backend_sets : bs.name => bs }

  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.nbl.id
  name                     = each.value.name
  policy                   = each.value.policy

  health_checker {
    port     = each.value.health_checker.port
    protocol = each.value.health_checker.protocol
    //url_path = each.value.health_checker.url_path
    url_path           = null
    interval_in_millis = 10000
    timeout_in_millis  = 3000
    retries            = 3
    //return_code = 200
  }
}

resource "oci_network_load_balancer_backend" "backend" {
  for_each = { for b in flatten([for i, bs in var.backend_sets : [for j, be in bs.backends : merge(be, { backend_set_name = bs.name, backend_set_index = i, backend_index = j })]]) : "${b.backend_set_index}-${b.backend_index}" => b }

  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.nbl.id
  backend_set_name         = each.value.backend_set_name
  ip_address               = each.value.ip_address
  port                     = each.value.port
  target_id                = each.value.target_id

  depends_on = [oci_network_load_balancer_backend_set.backend_set]
}

resource "oci_network_load_balancer_listener" "listener" {
  for_each = { for ls in var.listeners : ls.name => ls }

  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.nbl.id
  name                     = each.value.name
  default_backend_set_name = oci_network_load_balancer_backend_set.backend_set[each.value.backend_set_name].name
  protocol                 = each.value.protocol
  port                     = each.value.port

}