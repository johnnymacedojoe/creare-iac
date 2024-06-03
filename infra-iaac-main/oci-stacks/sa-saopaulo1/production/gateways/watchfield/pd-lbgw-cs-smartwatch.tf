module "pd-lbgw-cs-smartwatch" {
  source = "../../../modules/new-alb"

  compartment_id             = var.production
  display_name               = "pd-lbgw-cs-smartwatch"
  is_private                 = false
  subnet_ids                 = [var.sn-oci-spo1p0]
  network_security_group_ids = [module.nsg-pd-lbgw-cs-smartwatch.nsg_id] //[module.oci_nsg.nsg_id]
  public_ip                  = module.pd-lbgw-cs-smartwatch-public_ip.public_ip
  minimum_bandwidth          = 10
  maximum_bandwidth          = 100
  //freeform_tags  = { tag1 = "value1", tag2 = "value2" }
  defined_tags = var.defined_tags_set

  backend_sets = [
    {
      name   = "bs_443"
      policy = "IP_HASH" //ROUND_ROBIN - LEAST_CONNECTIONS
      health_checker = {
        port     = 30112
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { ip_address = "10.1.1.131", port = 40172 },
        { ip_address = "10.1.1.132", port = 40172 }
      ]
    },
    {
      name   = "bs_80"
      policy = "IP_HASH" //ROUND_ROBIN - LEAST_CONNECTIONS
      health_checker = {
        port     = 30112
        protocol = "TCP"
        url_path = "/"
      }
      backends = [
        { ip_address = "10.1.1.131", port = 40171 },
        { ip_address = "10.1.1.132", port = 40171 }
      ]
    }
  ]

  listeners = [
    {
      name             = "listener_443"
      backend_set_name = "bs_443"
      protocol         = "TCP"
      port             = 443
    },
    {
      name             = "listener_80"
      backend_set_name = "bs_80"
      protocol         = "TCP"
      port             = 80
    }
  ]
}

module "pd-lbgw-cs-smartwatch-public_ip" {
  source = "../../../modules/new-public-ip"

  compartment_id = var.cs-compartment_ocid
  display_name   = "pd-lbgw-cs-smartwatch"
}