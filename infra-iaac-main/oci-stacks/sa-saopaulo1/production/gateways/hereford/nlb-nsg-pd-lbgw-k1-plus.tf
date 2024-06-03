module "nlb-pd-lbgw-cs-k1-plus" {
  source                     = "../../../modules/new-nlb-v2"
  compartment_id             = var.production
  display_name               = "pd-lbgw-cs-k1-plus"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-pd-lbgw-cs-k1-plus.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-pd-lbgw-cs-k1-plus.public_ip //Can be omitted
  defined_tags               = var.defined_tags_set
  backend_sets = [
    {
      name   = "backendset_stonkam_9090"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9090
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9090 }
      ]
    },
    {
      name   = "backendset_stonkam_9091"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9091
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9091 }
      ]
    },
    {
      name   = "backendset_stonkam_9092"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9092
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9092 }
      ]
    },
    {
      name   = "backendset_stonkam_9093"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9093
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9093 }
      ]
    },
    {
      name   = "backendset_stonkam_9094"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9094
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9094 }
      ]
    },
    {
      name   = "backendset_stonkam_9095"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9095
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9095 }
      ]
    },
    {
      name   = "backendset_stonkam_9096"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9096
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9096 }
      ]
    },
    {
      name   = "backendset_stonkam_9097"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9097
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9097 }
      ]
    },
    {
      name   = "backendset_stonkam_9098"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9098
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9098 }
      ]
    },
    {
      name   = "backendset_stonkam_9099"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9099
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.1.92", port = 9099 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener_stonkam_9090"
      backend_set_name = "backendset_stonkam_9090"
      port             = 9090
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9091"
      backend_set_name = "backendset_stonkam_9091"
      port             = 9091
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9092"
      backend_set_name = "backendset_stonkam_9092"
      port             = 9092
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9093"
      backend_set_name = "backendset_stonkam_9093"
      port             = 9093
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9094"
      backend_set_name = "backendset_stonkam_9094"
      port             = 9094
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9095"
      backend_set_name = "backendset_stonkam_9095"
      port             = 9095
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9096"
      backend_set_name = "backendset_stonkam_9096"
      port             = 9096
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9097"
      backend_set_name = "backendset_stonkam_9097"
      port             = 9097
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9098"
      backend_set_name = "backendset_stonkam_9098"
      port             = 9098
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9099"
      backend_set_name = "backendset_stonkam_9099"
      port             = 9099
      protocol         = "TCP"
    }
  ]
}


module "public-ip-pd-lbgw-cs-k1-plus" {
  source = "../../../modules/new-public-ip"

  compartment_id = var.production
  display_name   = "pd-lbgw-cs-k1-plus"
  defined_tags   = var.defined_tags_set
}

module "nsg-pd-lbgw-cs-k1-plus" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.production
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-pd-lbgw-cs-k1-plus"
  defined_tags   = var.defined_tags_set
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 9090
      max_port    = 9099
      description = "listener_stonkam_9090_9099"
    }
  ]
}

output "nsg-pd-lbgw-cs-k1-plus-id" {
  value = module.nsg-pd-lbgw-cs-k1-plus.nsg_id
}
