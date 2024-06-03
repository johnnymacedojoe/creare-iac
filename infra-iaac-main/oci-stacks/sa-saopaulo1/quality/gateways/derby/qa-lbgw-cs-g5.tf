module "nlb-qa-lbgw-cs-g5" {
  source                     = "../../../modules/new-nlb"
  compartment_id             = var.BU-Safety-compartment_ocid
  display_name               = "qa-lbgw-cs-g5"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-qa-lbgw-cs-g5.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-qa-lbgw-cs-g5.public_ip //Can be omitted
  backend_sets = [
    {
      name   = "backendset_jimi-gw-jc400-21100"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 21100
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_derby.instance_id, ip_address = "10.1.2.80", port = 21100 }
      ]
    },
    {
      name   = "backendset_jimi-api-9080"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9080
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_derby.instance_id, ip_address = "10.1.2.80", port = 9080 }
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
        { target_id = module.oci_core_instance_derby.instance_id, ip_address = "10.1.2.80", port = 23010 }
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
        { target_id = module.oci_core_instance_derby.instance_id, ip_address = "10.1.2.80", port = 1936 }
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
        { target_id = module.oci_core_instance_derby.instance_id, ip_address = "10.1.2.80", port = 8881 }
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
      name             = "listener_jimi-gw-jc400-21100"
      backend_set_name = "backendset_jimi-gw-jc400-21100"
      port             = 21100
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-api-9080"
      backend_set_name = "backendset_jimi-api-9080"
      port             = 9080
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


module "public-ip-qa-lbgw-cs-g5" {
  source = "../../../modules/new-public-ip"

  compartment_id = var.BU-Safety-compartment_ocid
  display_name   = "qa-lbgw-cs-g5"
}



