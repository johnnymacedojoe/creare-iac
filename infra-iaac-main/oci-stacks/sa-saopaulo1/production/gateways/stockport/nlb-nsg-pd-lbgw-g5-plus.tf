module "nlb-pd-lbgw-cs-g5-plus" {
  source                     = "../../../modules/new-nlb-v2"
  compartment_id             = var.production
  display_name               = "pd-lbgw-cs-g5-plus"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-pd-lbgw-cs-g5-plus.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-pd-lbgw-cs-g5-plus.public_ip //Can be omitted
  defined_tags               = var.defined_tags_set
  backend_sets = [
    {
      name   = "backendset_jimi-gw-jc400-21100"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 21100
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stockport.instance_id, ip_address = "10.1.1.71", port = 21100 }
      ]
    },
    {
      name   = "backendset_jimi-gw-upload-23010"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 23010
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stockport.instance_id, ip_address = "10.1.1.71", port = 23010 }
      ]
    },
    {
      name   = "backendset_jimi-services-media-1936"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 1936
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stockport.instance_id, ip_address = "10.1.1.71", port = 1936 }
      ]
    },
    {
      name   = "backendset_jimi-services-media-1935"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 1935
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stockport.instance_id, ip_address = "10.1.1.71", port = 1935 }
      ]
    },
    {
      name   = "backendset_jimi-services-media-8881"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 8881
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stockport.instance_id, ip_address = "10.1.1.71", port = 8881 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener_jimi-services-media-1936"
      backend_set_name = "backendset_jimi-services-media-1936"
      port             = 1936
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-services-media-1935"
      backend_set_name = "backendset_jimi-services-media-1935"
      port             = 1935
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-gw-jc400-21100"
      backend_set_name = "backendset_jimi-gw-jc400-21100"
      port             = 21100
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-gw-upload-23010"
      backend_set_name = "backendset_jimi-gw-upload-23010"
      port             = 23010
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-services-media-8881"
      backend_set_name = "backendset_jimi-services-media-8881"
      port             = 8881
      protocol         = "TCP"
    }
  ]
}


module "public-ip-pd-lbgw-cs-g5-plus" {
  source = "../../../modules/new-public-ip"

  compartment_id = var.production
  display_name   = "pd-lbgw-cs-g5-plus"
  defined_tags   = var.defined_tags_set
}

module "nsg-pd-lbgw-cs-g5-plus" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.production
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-pd-lbgw-cs-g5-plus"
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
      min_port    = 21100
      max_port    = 21100
      description = "pd-jimi-g5-v6-plus-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "pd-jimi-g5-v6-plus-services-upload-23010"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 1935
      max_port    = 1936
      description = "pd-jimi-g5-v6-plus-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "pd-jimi-g5-v6-plus-services-media-8881"
    }
  ]
}

output "nsg-pd-lbgw-cs-g5-plus-id" {
  value = module.nsg-pd-lbgw-cs-g5-plus.nsg_id
}
