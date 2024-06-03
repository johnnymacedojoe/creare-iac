module "vcn-oci-spo1p" {
  source = "./modules/new-vcn"

  compartment_id = var.bryancloud-compartment_ocid
  cidr_blocks    = ["10.1.0.0/16"]
  display_name   = "vcn-oci-spo1p"
  dns_label      = "spo1prd"

  internet_gateway_display_name = "ig-oci-spo1p"
  internet_gateway_enabled      = true
  nat_gateway_display_name      = "ng-oci-spo1p"
  //nat_gateway_ip_id = ""
  service_gateway_display_name = "sg-oci-spo1p"

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
      cidr_block     = "10.1.0.0/24"
      display_name   = "sn-oci-spo1p0"
      dns_label      = "snocispo1p0"
      route_table_id = module.vcn-oci-spo1p.route_table_ids["rt-sn-oci-spo1p0"] //example
    },
    {
      cidr_block                 = "10.1.1.0/24"
      display_name               = "sn-oci-spo1p1"
      dns_label                  = "snocispo1p1"
      route_table_id             = module.vcn-oci-spo1p.route_table_ids["rt-sn-oci-spo1p1"]
      prohibit_public_ip_on_vnic = true
    },
    {
      cidr_block                 = "10.1.2.0/24"
      display_name               = "sn-oci-spo1p2"
      dns_label                  = "snocispo1p2"
      route_table_id             = module.vcn-oci-spo1p.route_table_ids["rt-sn-oci-spo1p2"]
      prohibit_public_ip_on_vnic = true
    }
  ]

  route_rules = {
    "rt-sn-oci-spo1p0" = [
      {
        network_entity_id = module.vcn-oci-spo1p.internet_gateway_id
        description       = "Default Rule for IGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-spo1.drg_id
        description       = "Example rule with dest VCN I to DRG"
        destination       = "10.2.0.0/16"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-spo1p1" = [
      {
        network_entity_id = module.vcn-oci-spo1p.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-spo1p.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-iad-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-spo1.drg_id
        description       = "Example rule with dest VCN I to DRG"
        destination       = "10.2.0.0/16"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-spo1p2" = [
      {
        network_entity_id = module.drg-oci-spo1.drg_id
        description       = "Example rule with dest VCN I to DRG"
        destination       = "10.2.0.0/16"
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

output "vcn-oci-spo1p-id" {
  value = module.vcn-oci-spo1p.vcn_id
}

