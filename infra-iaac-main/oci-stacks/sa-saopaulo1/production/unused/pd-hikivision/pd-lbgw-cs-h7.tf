module "nlb-pd-lbgw-cs-h7" {
  source                     = "./modules/new-nlb"
  compartment_id             = var.BU-Safety-compartment_ocid
  display_name               = "pd-lbgw-cs-h7"
  is_private                 = false
  is_preserve_source         = true
  subnet_id                  = var.sn-oci-spo1p0
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [module.nsg-pd-lbgw-cs-h7.nsg_id]        //[module.oci_nsg.nsg_id]
  public_ip                  = module.public-ip-pd-lbgw-cs-h7.public_ip //Can be omitted
  backend_sets = [
    {
      name   = "backendset_hikvision_9980_55023"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55023
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55023 }
      ]
    },
    {
      name   = "backendset_hikvision_8877_55010"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55010
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55010 }
      ]
    },
    {
      name   = "backendset_hikvision_8686_55006"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55006
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55006 }
      ]
    },
    {
      name   = "backendset_hikvision_8555_55007"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55007
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55007 }
      ]
    },
    {
      name   = "backendset_hikvision_83_55018"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55018
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55018 }
      ]
    },
    {
      name   = "backendset_hikvision_7664_55013"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55013
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55013 }
      ]
    },
    {
      name   = "backendset_hikvision_7662_55012"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55012
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55012 }
      ]
    },
    {
      name   = "backendset_hikvision_7661_55009"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55009
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55009 }
      ]
    },
    {
      name   = "backendset_hikvision_7660_55001"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55001
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55001 }
      ]
    },
    {
      name   = "backendset_hikvision_7334_55003"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55003
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55003 }
      ]
    },
    {
      name   = "backendset_hikvision_7332_55002"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55002
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55002 }
      ]
    },
    {
      name   = "backendset_hikvision_6678_55016"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55016
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55016 }
      ]
    },
    {
      name   = "backendset_hikvision_6471_55014"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55014
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55014 }
      ]
    },
    {
      name   = "backendset_hikvision_6470_55024"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55024
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55024 }
      ]
    },
    {
      name   = "backendset_hikvision_6203_55005"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55005
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55005 }
      ]
    },
    {
      name   = "backendset_hikvision_6123_55004"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55004
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55004 }
      ]
    },
    {
      name   = "backendset_hikvision_559_55017"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55017
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55017 }
      ]
    },
    {
      name   = "backendset_hikvision_554_55015"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55015
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55015 }
      ]
    },
    {
      name   = "backendset_hikvision_1935_55019"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55019
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55019 }
      ]
    },
    {
      name   = "backendset_hikvision_16003_55027"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55027
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55027 }
      ]
    },
    {
      name   = "backendset_hikvision_16001_55026"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55026
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55026 }
      ]
    },
    {
      name   = "backendset_hikvision_16000_55025"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55025
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55025 }
      ]
    },
    {
      name   = "backendset_hikvision_15443_55022"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55022
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55022 }
      ]
    },
    {
      name   = "backendset_hikvision_15310_55021"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55021
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55021 }
      ]
    },
    {
      name   = "backendset_hikvision_15300_55008"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55008
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55008 }
      ]
    },
    {
      name   = "backendset_hikvision_14200_55020"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55020
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55020 }
      ]
    },
    {
      name   = "backendset_hikvision_10015_55011"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 55011
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { target_id = module.oci_core_instance_hereford.instance_id, ip_address = "10.1.2.15", port = 55011 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener_hikvision_83_55018"
      backend_set_name = "backendset_hikvision_83_55018"
      port             = 55018
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_10015_55011"
      backend_set_name = "backendset_hikvision_10015_55011"
      port             = 55011
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_14200_55020"
      backend_set_name = "backendset_hikvision_14200_55020"
      port             = 55020
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_15300_55008"
      backend_set_name = "backendset_hikvision_15300_55008"
      port             = 55008
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_15310_55021"
      backend_set_name = "backendset_hikvision_15310_55021"
      port             = 55021
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_15443_55022"
      backend_set_name = "backendset_hikvision_15443_55022"
      port             = 55022
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_16000_55025"
      backend_set_name = "backendset_hikvision_16000_55025"
      port             = 55025
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_16001_55026"
      backend_set_name = "backendset_hikvision_16001_55026"
      port             = 55026
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_16003_55027"
      backend_set_name = "backendset_hikvision_16003_55027"
      port             = 55027
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_1935_55019"
      backend_set_name = "backendset_hikvision_1935_55019"
      port             = 55019
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_554_55015"
      backend_set_name = "backendset_hikvision_554_55015"
      port             = 55015
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_559_55017"
      backend_set_name = "backendset_hikvision_559_55017"
      port             = 55017
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6123_55004"
      backend_set_name = "backendset_hikvision_6123_55004"
      port             = 55004
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6203_55005"
      backend_set_name = "backendset_hikvision_6203_55005"
      port             = 55005
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6470_55024"
      backend_set_name = "backendset_hikvision_6470_55024"
      port             = 55024
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6471_55014"
      backend_set_name = "backendset_hikvision_6471_55014"
      port             = 55014
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_6678_55016"
      backend_set_name = "backendset_hikvision_6678_55016"
      port             = 55016
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7332_55002"
      backend_set_name = "backendset_hikvision_7332_55002"
      port             = 55002
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7334_55003"
      backend_set_name = "backendset_hikvision_7334_55003"
      port             = 55003
      protocol         = "UDP"
    },
    {
      name             = "listener_hikvision_7660_55001"
      backend_set_name = "backendset_hikvision_7660_55001"
      port             = 55001
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7661_55009"
      backend_set_name = "backendset_hikvision_7661_55009"
      port             = 55009
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_7662_55012"
      backend_set_name = "backendset_hikvision_7662_55012"
      port             = 55012
      protocol         = "UDP"
    },
    {
      name             = "listener_hikvision_7664_55013"
      backend_set_name = "backendset_hikvision_7664_55013"
      port             = 55013
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_8555_55007"
      backend_set_name = "backendset_hikvision_8555_55007"
      port             = 55007
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_8686_55006"
      backend_set_name = "backendset_hikvision_8686_55006"
      port             = 55006
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_8877_55010"
      backend_set_name = "backendset_hikvision_8877_55010"
      port             = 55010
      protocol         = "TCP"
    },
    {
      name             = "listener_hikvision_9980_55023"
      backend_set_name = "backendset_hikvision_9980_55023"
      port             = 55023
      protocol         = "TCP"
    }

  ]
}

module "public-ip-pd-lbgw-cs-h7" {
  source = "./modules/new-public-ip"

  compartment_id = var.cs-compartment_ocid
  display_name   = "pd-lbgw-cs-h7"
}



