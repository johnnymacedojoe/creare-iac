/*
module "alb-load_balancer1" {
  source = "./modules/new-alb"
  //experiments = [module_variable_optional_attrs] //For vars optional works on stack oci

  compartment_id             = var.cs-compartment_ocid
  display_name               = "my-load-balancer-terraform-teste"
  is_private                 = false
  subnet_ids                 = [var.sn-oci-spo1p0]
  network_security_group_ids = [var.nsg-spo1p-linux-server] //[module.oci_nsg.nsg_id]
  //public_ip = module.public_ip1.public_ip
  minimum_bandwidth = 10
  maximum_bandwidth = 100
  //freeform_tags  = { tag1 = "value1", tag2 = "value2" }

  backend_sets = [
    {
      name   = "backendset1"
      policy = "IP_HASH" //ROUND_ROBIN - LEAST_CONNECTIONS
      health_checker = {
        port     = 80
        protocol = "HTTP"
        url_path = "/"
      }
      backends = [
        { ip_address = "192.168.100.79", port = 80 },
        { ip_address = "192.168.100.78", port = 8080 }
      ]
    },
    {
      name   = "backendset2"
      policy = "IP_HASH" //ROUND_ROBIN - LEAST_CONNECTIONS
      health_checker = {
        port     = 443
        protocol = "HTTPS"
        url_path = "/"
      }
      backends = [
        { ip_address = "192.168.100.89", port = 443 },
        { ip_address = "192.168.100.88", port = 443 }
      ]
      //ssl_configuration = {
        //certificate_ids        = module.ssl_certificate.certificate_id //or OCID
        //verify_depth            = 3
        //verify_peer_certificate = false
      //}
    }
  ]

  listeners = [
    {
      name             = "listener1"
      backend_set_name = "backendset1"
      protocol         = "HTTP"
      port             = 80
    },
    {
      name             = "listener2"
      backend_set_name = "backendset2"
      protocol         = "HTTPS"
      port             = 443

      //ssl_configuration = {
        //certificate_ids        = module.ssl_certificate.certificate_id //or OCID
        //verify_depth            = 3
        //verify_peer_certificate = false
      //}
    }
  ]
}



module "public_ip1" {
  source = "./modules/new-public-ip"

  compartment_id = var.cs-compartment_ocid
  display_name   = "TesteIp"
}

*/