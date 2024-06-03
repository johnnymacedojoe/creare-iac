/*



module "nlb-load_balancer1" {
  source                     = "./modules/new-nlb"
  compartment_id             = var.cs-compartment_ocid
  display_name               = "my-teste-nlb-terraform"
  is_private                 = false
  is_preserve_source         = false
  subnet_id                  = var.sn-oci-spo1p2
  nlb_ip_version             = "IPV4"
  network_security_group_ids = [var.nsg-spo1p-linux-server] //[module.oci_nsg.nsg_id]
  public_ip = module.public_ip2.public_ip //Can be omitted
  backend_sets = [
    {
      name   = "backendset1"
      policy = "THREE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 80
        protocol = "HTTP"
        url_path = "/"
      }
      backends = [
        { ip_address = "192.168.100.89", port = 80 },
        { ip_address = "192.168.100.78", port = 8080 }
      ]
    },
    {
      name   = "backendset2"
      policy = "FIVE_TUPLE" //FIVE_TUPLE
      health_checker = {
        port     = 80
        protocol = "HTTP"
        url_path = "/"
      }
      backends = [
        { ip_address = "192.168.100.101", port = 80 },
        { ip_address = "192.168.100.102", port = 8080 }
      ]
    }
  ]
  listeners = [
    {
      name             = "listener1"
      backend_set_name = "backendset1"
      port             = 80
      protocol         = "TCP"
    },
    {
      name             = "listener2"
      backend_set_name = "backendset2"
      port             = 81
      protocol         = "TCP"
    }
  ]
}

module "public_ip2" {
  source = "./modules/new-public-ip"

  compartment_id = var.cs-compartment_ocid
  display_name   = "TesteIp2"
}



*/