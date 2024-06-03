module "vcn-oci-spo1i" {
  source = "./modules/new-vcn"

  compartment_id = var.bryancloud-compartment_ocid
  cidr_blocks    = ["10.2.0.0/16"]
  display_name   = "vcn-oci-spo1i"
  dns_label      = "spo1int"

  internet_gateway_display_name = "ig-oci-spo1i"
  internet_gateway_enabled      = true
  nat_gateway_display_name      = "ng-oci-spo1i"
  //nat_gateway_ip_id = ""
  service_gateway_display_name = "sg-oci-spo1i"

  df_sl_ingress_rules = [
    {
      protocol    = "6"          // TCP ("6")
      source      = "1.0.0.0/32" //"0.0.0.0/0"
      description = "Allow all tcp"
      tcp_options = {
        min = 1
        max = 2
      }
    } /*,
    {
      protocol    = "1" // ICMP ("1")
      source      = "0.0.0.0/0"
      description = "Allow all icmp"
    },
    {
      protocol    = "17" // UDP ("17")
      source      = "0.0.0.0/0"
      description = "Allow all udp"
      udp_options = {
        min = 1
        max = 65535
        source_port_range = {
                    min = 10
                    max = 20
                }
      }
    }*/
  ]

  df_sl_egress_rule = {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  subnets = [
    {
      cidr_block     = "10.2.0.0/24"
      display_name   = "sn-oci-spo1i0"
      dns_label      = "snocispo1i0"
      route_table_id = module.vcn-oci-spo1i.route_table_ids["rt-sn-oci-spo1i0"] //example
    },
    {
      cidr_block                 = "10.2.1.0/24"
      display_name               = "sn-oci-spo1i1"
      dns_label                  = "snocispo1i1"
      route_table_id             = module.vcn-oci-spo1i.route_table_ids["rt-sn-oci-spo1i1"]
      prohibit_public_ip_on_vnic = true
    },
    {
      cidr_block                 = "10.2.2.0/24"
      display_name               = "sn-oci-spo1i2"
      dns_label                  = "snocispo1i2"
      route_table_id             = module.vcn-oci-spo1i.route_table_ids["rt-sn-oci-spo1i2"]
      prohibit_public_ip_on_vnic = true
    }
  ]

  route_rules = {
    "rt-sn-oci-spo1i0" = [
      {
        network_entity_id = module.vcn-oci-spo1i.internet_gateway_id
        description       = "Default Rule for IGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-spo1.drg_id
        description       = "Example rule with dest VCN P to DRG"
        destination       = "10.1.0.0/16"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-spo1i1" = [
      {
        network_entity_id = module.vcn-oci-spo1i.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-iad-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-spo1.drg_id
        description       = "Example rule with dest VCN P to DRG"
        destination       = "10.1.0.0/16"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-spo1i2" = [
      {
        network_entity_id = module.vcn-oci-spo1i.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-iad-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-spo1.drg_id
        description       = "Example rule with dest VCN P to DRG"
        destination       = "10.1.0.0/16"
        destination_type  = "CIDR_BLOCK"
      }
    ]
  }
  /*dhcp_options   = [
        {
        display_name = "dhcp_option1"
        search_domain_names = ["test.com"]
        }
    ]*/
}


output "vcn-oci-spo1i-id" {
  value = module.vcn-oci-spo1i.vcn_id
}

