module "nlb-qa-lbgw-cs-h7" {
  source                     = "./modules/new-nlb"
  compartment_id             = var.BU-Safety-compartment_ocid
  display_name               = "qa-lbgw-cs-h7"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-qa-lbgw-cs-h7.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-qa-lbgw-cs-h7.public_ip //Can be omitted
  backend_sets = [
    {
      name   = "backendset_hikvision_9980"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 9980
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 9980 }
      ]
    },
    {
      name   = "backendset_hikvision_8877"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 8877
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 8877 }
      ]
    },
    {
      name   = "backendset_hikvision_8686"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 8686
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 8686 }
      ]
    },
    {
      name   = "backendset_hikvision_8555"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 8555
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 8555 }
      ]
    },
    {
      name   = "backendset_hikvision_83"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 83
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 83 }
      ]
    },
    {
      name   = "backendset_hikvision_7664"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 7664
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 7664 }
      ]
    },
    {
      name   = "backendset_hikvision_7662"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 7662
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 7662 }
      ]
    },
    {
      name   = "backendset_hikvision_7661"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 7661
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 7661 }
      ]
    },
    {
      name   = "backendset_hikvision_7660"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 7660
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 7660 }
      ]
    },
    {
      name   = "backendset_hikvision_7334"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 7334
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 7334 }
      ]
    },
    {
      name   = "backendset_hikvision_7332"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 7332
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 7332 }
      ]
    },
    {
      name   = "backendset_hikvision_6678"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6678
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6678 }
      ]
    },
    {
      name   = "backendset_hikvision_6471"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6471
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6471 }
      ]
    },
    {
      name   = "backendset_hikvision_6470"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6470
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6470 }
      ]
    },
    {
      name   = "backendset_hikvision_559"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 559
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 559 }
      ]
    },
    {
      name   = "backendset_hikvision_554"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 554
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 554 }
      ]
    },
    {
      name   = "backendset_hikvision_1935"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 1935
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 1935 }
      ]
    },
    {
      name   = "backendset_hikvision_16003"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 16003
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 16003 }
      ]
    },
    {
      name   = "backendset_hikvision_16001"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 16001
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 16001 }
      ]
    },
    {
      name   = "backendset_hikvision_16000"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 16000
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 16000 }
      ]
    },
    {
      name   = "backendset_hikvision_15443"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 15443
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 15443 }
      ]
    },
    {
      name   = "backendset_hikvision_15310"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 15310
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 15310 }
      ]
    },
    {
      name   = "backendset_hikvision_15300"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 15300
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 15300 }
      ]
    },
    {
      name   = "backendset_hikvision_14200"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 14200
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 14200 }
      ]
    },
    {
      name   = "backendset_hikvision_10015"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 10015
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 10015 }
      ]
    },
    {
      name   = "backendset_hikvision_55029"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55029
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 55029 }
      ]
    },
    {
      name   = "backendset_hikvision_6011"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6011
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6011 }
      ]
    },
    {
      name   = "backendset_hikvision_6021"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6021
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6021 }
      ]
    },
    {
      name   = "backendset_hikvision_6022"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6022
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6022 }
      ]
    },
    {
      name   = "backendset_hikvision_6027"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6027
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6027 }
      ]
    },
    {
      name   = "backendset_hikvision_6036"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6036
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6036 }
      ]
    },
    {
      name   = "backendset_hikvision_6037"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6037
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6037 }
      ]
    },
    {
      name   = "backendset_hikvision_6038"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6038
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6038 }
      ]
    },
    {
      name   = "backendset_hikvision_6039"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6039
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6039 }
      ]
    },
    {
      name   = "backendset_hikvision_6040"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6040
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6040 }
      ]
    },
    {
      name   = "backendset_hikvision_6041"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6041
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6041 }
      ]
    },
    {
      name   = "backendset_hikvision_6042"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6042
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6042 }
      ]
    },
    {
      name   = "backendset_hikvision_6044"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6044
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6044 }
      ]
    },
    {
      name   = "backendset_hikvision_6045"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6045
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6045 }
      ]
    },
    {
      name   = "backendset_hikvision_6046"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6046
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6046 }
      ]
    },
    {
      name   = "backendset_hikvision_6060"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6060
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6060 }
      ]
    },
    {
      name   = "backendset_hikvision_6098"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6098
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6098 }
      ]
    },
    {
      name   = "backendset_hikvision_6111"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6111
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6111 }
      ]
    },
    {
      name   = "backendset_hikvision_6112"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6112
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6112 }
      ]
    },
    {
      name   = "backendset_hikvision_6113"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6113
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6113 }
      ]
    },
    {
      name   = "backendset_hikvision_6114"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6114
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6114 }
      ]
    },
    {
      name   = "backendset_hikvision_6120"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6120
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6120 }
      ]
    },
    {
      name   = "backendset_hikvision_6201"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 6201
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_salford.instance_id, ip_address = "10.1.2.15", port = 6201 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener_hikvision_83"
      backend_set_name = "backendset_hikvision_83"
      port             = 83
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_10015"
      backend_set_name = "backendset_hikvision_10015"
      port             = 10015
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_14200"
      backend_set_name = "backendset_hikvision_14200"
      port             = 14200
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_15300"
      backend_set_name = "backendset_hikvision_15300"
      port             = 15300
      protocol         = "TCP_AND_UDP"
    },
    {
      name             = "listener_hikvision_15310"
      backend_set_name = "backendset_hikvision_15310"
      port             = 15310
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_15443"
      backend_set_name = "backendset_hikvision_15443"
      port             = 15443
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_16000"
      backend_set_name = "backendset_hikvision_16000"
      port             = 16000
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_16001"
      backend_set_name = "backendset_hikvision_16001"
      port             = 16001
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_16003"
      backend_set_name = "backendset_hikvision_16003"
      port             = 16003
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_1935"
      backend_set_name = "backendset_hikvision_1935"
      port             = 1935
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_554"
      backend_set_name = "backendset_hikvision_554"
      port             = 554
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_559"
      backend_set_name = "backendset_hikvision_559"
      port             = 559
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6470"
      backend_set_name = "backendset_hikvision_6470"
      port             = 6470
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6471"
      backend_set_name = "backendset_hikvision_6471"
      port             = 6471
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6678"
      backend_set_name = "backendset_hikvision_6678"
      port             = 6678
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7332"
      backend_set_name = "backendset_hikvision_7332"
      port             = 7332
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7334"
      backend_set_name = "backendset_hikvision_7334"
      port             = 7334
      protocol         = "UDP"
    },
    {
      name             = "listener_hikvision_7660"
      backend_set_name = "backendset_hikvision_7660"
      port             = 7660
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7661"
      backend_set_name = "backendset_hikvision_7661"
      port             = 7661
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7662"
      backend_set_name = "backendset_hikvision_7662"
      port             = 7662
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7664"
      backend_set_name = "backendset_hikvision_7664"
      port             = 7664
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_8555"
      backend_set_name = "backendset_hikvision_8555"
      port             = 8555
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_8686"
      backend_set_name = "backendset_hikvision_8686"
      port             = 8686
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_8877"
      backend_set_name = "backendset_hikvision_8877"
      port             = 8877
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_9980"
      backend_set_name = "backendset_hikvision_9980"
      port             = 9980
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_55029"
      backend_set_name = "backendset_hikvision_55029"
      port             = 55029
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6011"
      backend_set_name = "backendset_hikvision_6011"
      port             = 6011
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6021"
      backend_set_name = "backendset_hikvision_6021"
      port             = 6021
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6022"
      backend_set_name = "backendset_hikvision_6022"
      port             = 6022
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6027"
      backend_set_name = "backendset_hikvision_6027"
      port             = 6027
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6036"
      backend_set_name = "backendset_hikvision_6036"
      port             = 6036
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6037"
      backend_set_name = "backendset_hikvision_6037"
      port             = 6037
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6038"
      backend_set_name = "backendset_hikvision_6038"
      port             = 6038
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6039"
      backend_set_name = "backendset_hikvision_6039"
      port             = 6039
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6040"
      backend_set_name = "backendset_hikvision_6040"
      port             = 6040
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6041"
      backend_set_name = "backendset_hikvision_6041"
      port             = 6041
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6042"
      backend_set_name = "backendset_hikvision_6042"
      port             = 6042
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6044"
      backend_set_name = "backendset_hikvision_6044"
      port             = 6044
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6045"
      backend_set_name = "backendset_hikvision_6045"
      port             = 6045
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6046"
      backend_set_name = "backendset_hikvision_6046"
      port             = 6046
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6060"
      backend_set_name = "backendset_hikvision_6060"
      port             = 6060
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6098"
      backend_set_name = "backendset_hikvision_6098"
      port             = 6098
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6111"
      backend_set_name = "backendset_hikvision_6111"
      port             = 6111
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6112"
      backend_set_name = "backendset_hikvision_6112"
      port             = 6112
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6113"
      backend_set_name = "backendset_hikvision_6113"
      port             = 6113
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6114"
      backend_set_name = "backendset_hikvision_6114"
      port             = 6114
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6120"
      backend_set_name = "backendset_hikvision_6120"
      port             = 6120
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6201"
      backend_set_name = "backendset_hikvision_6201"
      port             = 6201
      protocol         = "TCP"
    }
  ]
}

module "public-ip-qa-lbgw-cs-h7" {
  source = "./modules/new-public-ip"

  compartment_id = var.cs-compartment_ocid
  display_name   = "qa-lbgw-cs-h7"
}



