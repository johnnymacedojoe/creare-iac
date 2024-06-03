module "nlb-qa-lbgw-cs-g7" {
  source                     = "../../../modules/new-nlb"
  compartment_id             = var.BU-Safety-compartment_ocid
  display_name               = "qa-lbgw-cs-g7"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-qa-lbgw-cs-g7.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-qa-lbgw-cs-g7.public_ip //Can be omitted
  backend_sets = [
    {
      name   = "backendset_jimi-ga-gw-jc400-21100"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 21100
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 21100 }
      ]
    },
    {
      name   = "backendset_jimi-ga-gw-jc450-21122"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 21122
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 21122 }
      ]
    },
    {
      name   = "backendset_jimi-ga-api-9080"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9080
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 9080 }
      ]
    },
    {
      name   = "backendset_jimi-ga-gw-upload-23010"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 23010
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 23010 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-media-10002"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 10002
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 10002 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-media-10003"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 10003
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 10003 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-media-1936"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 1936
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 1936 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-media-8881"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 8881
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 8881 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-streamer-40103"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 40103
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 40103 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-tracker-gate-upload-21188"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 21188
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 21188 }
      ]
    },
    {
      name   = "backendset_jimi-ga-services-tracker-upload-process-10556"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 10556
        protocol = "TCP"
      }
      backends = [
        { target_id = module.oci_core_instance_luton.instance_id, ip_address = "10.1.2.55", port = 10556 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener_jimi-ga-services-media-1936"
      backend_set_name = "backendset_jimi-ga-services-media-1936"
      port             = 1936
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-gw-jc400-21100"
      backend_set_name = "backendset_jimi-ga-gw-jc400-21100"
      port             = 21100
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-gw-jc450-21122"
      backend_set_name = "backendset_jimi-ga-gw-jc450-21122"
      port             = 21122
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-api-9080"
      backend_set_name = "backendset_jimi-ga-api-9080"
      port             = 9080
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-gw-upload-23010"
      backend_set_name = "backendset_jimi-ga-gw-upload-23010"
      port             = 23010
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-services-media-10002"
      backend_set_name = "backendset_jimi-ga-services-media-10002"
      port             = 10002
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-services-media-10003"
      backend_set_name = "backendset_jimi-ga-services-media-10003"
      port             = 10003
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-services-media-8881"
      backend_set_name = "backendset_jimi-ga-services-media-8881"
      port             = 8881
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-services-streamer-40103"
      backend_set_name = "backendset_jimi-ga-services-streamer-40103"
      port             = 40103
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-services-tracker-gate-upload-21188"
      backend_set_name = "backendset_jimi-ga-services-tracker-gate-upload-21188"
      port             = 21188
      protocol         = "TCP"
    },
    {
      name             = "listener_jimi-ga-services-tracker-upload-process-10556"
      backend_set_name = "backendset_jimi-ga-services-tracker-upload-process-10556"
      port             = 10556
      protocol         = "TCP"
    }
  ]
}


module "public-ip-qa-lbgw-cs-g7" {
  source = "../../../modules/new-public-ip"

  compartment_id = var.cs-compartment_ocid
  display_name   = "qa-lbgw-cs-g7"
}



