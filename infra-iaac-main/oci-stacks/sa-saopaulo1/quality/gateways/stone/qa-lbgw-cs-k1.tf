module "nlb-qa-lbgw-cs-k1" {
  source                     = "../../../modules/new-nlb"
  compartment_id             = var.BU-Safety-compartment_ocid
  display_name               = "qa-lbgw-cs-k1"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-qa-lbgw-cs-k1.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-qa-lbgw-cs-k1.public_ip //Can be omitted
  backend_sets = [
    {
      name   = "backendset_stonkam_9090_19090"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9090
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9090 }
      ]
    },
    {
      name   = "backendset_stonkam_9091_19091"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9091
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9091 }
      ]
    },
    {
      name   = "backendset_stonkam_9092_19092"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9092
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9092 }
      ]
    },
    {
      name   = "backendset_stonkam_9093_19093"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9093
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9093 }
      ]
    },
    {
      name   = "backendset_stonkam_9094_19094"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9094
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9094 }
      ]
    },
    {
      name   = "backendset_stonkam_9095_19095"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9095
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9095 }
      ]
    },
    {
      name   = "backendset_stonkam_9096_19096"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9096
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9096 }
      ]
    },
    {
      name   = "backendset_stonkam_9097_19097"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9097
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9097 }
      ]
    },
    {
      name   = "backendset_stonkam_9098_19098"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9098
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9098 }
      ]
    },
    {
      name   = "backendset_stonkam_9099_19099"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9099
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_stone.instance_id, ip_address = "10.1.2.90", port = 9099 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener_stonkam_9090_19090"
      backend_set_name = "backendset_stonkam_9090_19090"
      port             = 9090
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9091_19091"
      backend_set_name = "backendset_stonkam_9091_19091"
      port             = 9091
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9092_19092"
      backend_set_name = "backendset_stonkam_9092_19092"
      port             = 9092
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9093_19093"
      backend_set_name = "backendset_stonkam_9093_19093"
      port             = 9093
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9094_19094"
      backend_set_name = "backendset_stonkam_9094_19094"
      port             = 9094
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9095_19095"
      backend_set_name = "backendset_stonkam_9095_19095"
      port             = 9095
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9096_19096"
      backend_set_name = "backendset_stonkam_9096_19096"
      port             = 9096
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9097_19097"
      backend_set_name = "backendset_stonkam_9097_19097"
      port             = 9097
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9098_19098"
      backend_set_name = "backendset_stonkam_9098_19098"
      port             = 9098
      protocol         = "TCP"
    },
    {
      name             = "listener_stonkam_9099_19099"
      backend_set_name = "backendset_stonkam_9099_19099"
      port             = 9099
      protocol         = "TCP"
    }
  ]
}

module "public-ip-qa-lbgw-cs-k1" {
  source = "../../../modules/new-public-ip"

  compartment_id = var.BU-Safety-compartment_ocid
  display_name   = "qa-lbgw-cs-k1"
}



