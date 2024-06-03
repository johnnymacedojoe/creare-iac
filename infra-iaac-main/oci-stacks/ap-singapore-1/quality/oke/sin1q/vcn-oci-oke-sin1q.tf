module "vcn-oci-oke-sin1q" {
  source = "../../../modules/new-vcn"

  compartment_id = var.BU-corp
  cidr_blocks    = ["10.21.0.0/16"]
  display_name   = "vcn-oci-oke-sin1q"
  dns_label      = "okesin1q"

  internet_gateway_display_name = "ig-oci-oke-sin1q"
  internet_gateway_enabled      = true
  nat_gateway_display_name      = "ng-oci-oke-sin1q"
  //nat_gateway_ip_id = ""
  service_gateway_display_name = "sg-oci-oke-sin1q"

  df_sl_ingress_rules = [
    {
      protocol    = "1" // ICMP ("1")
      source      = "45.178.155.102/32"
      description = "Allow ICMP from Creare"
    }
    /*{
      protocol    = "all"         // TCP ("6")
      source      = "0.0.0.0/0" //"0.0.0.0/0"
      description = "Allow all tcp"
    },
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

  custom_security_lists = [
    {
      display_name = "sl-oci-oke-sin1q0"
      ingress_rules = [
        {
          protocol    = "1"
          source      = "45.178.155.102/32"
          description = "Allow ICMP from Creare"
        },
        {
          protocol    = "all"
          source      = "10.1.1.121/32"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow all 80 port for TRAEFIK PUBLIC"
          tcp_options = {
            min = 80
            max = 80
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow all 80 port for TRAEFIK PUBLIC"
          tcp_options = {
            min = 443
            max = 443
          }
        } /*{
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow all TCP"
          tcp_options = {
            min = 22
            max = 22
          }
        },
        {
          protocol    = "17"
          source      = "0.0.0.0/0"
          description = "Allow all UDP"
          udp_options = {
            min = 53
            max = 53
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow HTTP"
          tcp_options = {
            min = 80
            max = 80
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow HTTPS"
          tcp_options = {
            min = 443
            max = 443
          }
        }*/
      ]
      egress_rules = [
        {
          destination = "0.0.0.0/0"
          protocol    = "all"
        }
      ]
    },
    {
      display_name = "sl-oci-oke-sin1q1"
      ingress_rules = [
        {
          protocol    = "1"
          source      = "45.178.155.102/32"
          description = "Allow ICMP from Creare"
        },
        {
          protocol    = "all"
          source      = "10.1.1.121/32"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        } /*
        {
          protocol    = "6"
          source      = "10.1.4.0/22"
          description = "Kubernetes worker to Kubernetes API endpoint communication"
          tcp_options = {
            min = 6443
            max = 6443
          }
        },
        {
          protocol    = "6"
          source      = "10.1.4.0/22"
          description = "Kubernetes worker to control plane communication"
          tcp_options = {
            min = 12250
            max = 12250
          }
        },
        {
          protocol    = "6"
          source      = "10.1.3.0/24"
          description = "Client access to Kubernetes API endpoint"
          tcp_options = {
            min = 6443
            max = 6443
          }
        },
        {
          protocol    = "1"
          source      = "10.1.4.0/22"
          description = "ICMP traffic for: 3, 4 Destination Unreachable: Fragmentation Needed and Don't Fragment was Set"
        },
        {
          protocol    = "all"
          source      = "20.1.0.0/16"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        }*/
      ]
      egress_rules = [
        {
          destination = "0.0.0.0/0"
          protocol    = "all"
        }
      ]
    },
    {
      display_name = "sl-oci-oke-sin1q8"
      ingress_rules = [
        {
          protocol    = "1"
          source      = "45.178.155.102/32"
          description = "Allow ICMP from Creare"
        },
        {
          protocol    = "all"
          source      = "10.1.1.121/32"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        },
        {
          protocol    = "6"
          source      = "10.21.2.0/24"
          description = "ALB Private HTTPS 443"
          tcp_options = {
            min = 31109
            max = 31109
          }
        },
        {
          protocol    = "6"
          source      = "10.21.2.0/24"
          description = "ALB Private HTTP 80"
          tcp_options = {
            min = 30488
            max = 30488
          }
        },
        {
          protocol    = "6"
          source      = "10.21.2.0/24"
          description = "ALB Private Healh Checks"
          tcp_options = {
            min = 10256
            max = 10256
          }
        },
        {
          protocol    = "6"
          source      = "10.21.0.0/24"
          description = "ALB Public HTTPS 443"
          tcp_options = {
            min = 32293
            max = 32293
          }
        },
        {
          protocol    = "6"
          source      = "10.21.0.0/24"
          description = "ALB Public HTTP 80"
          tcp_options = {
            min = 32709
            max = 32709
          }
        },
        {
          protocol    = "6"
          source      = "10.21.0.0/24"
          description = "ALB Public Healh Checks"
          tcp_options = {
            min = 10256
            max = 10256
          }
        },
        {
          protocol    = "6"
          source      = "10.21.0.0/24"
          description = "ALB Public Healh Checks"
          tcp_options = {
            min = 31214
            max = 31214
          }
        },
        {
          protocol    = "6"
          source      = "10.21.0.0/24"
          description = "ALB Public Healh Checks"
          tcp_options = {
            min = 32632
            max = 32632
          }
        }
      ]
      egress_rules = [
        {
          destination = "0.0.0.0/0"
          protocol    = "all"
        }
      ]
    },
    {
      display_name = "sl-oci-oke-sin1q2"
      ingress_rules = [
        {
          protocol    = "1"
          source      = "45.178.155.102/32"
          description = "Allow ICMP from Creare"
        },
        {
          protocol    = "all"
          source      = "10.1.1.121/32"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        },
        {
          protocol    = "all"
          source      = "10.1.1.122/32"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow all 80 port for NGINX Private"
          tcp_options = {
            min = 80
            max = 80
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow all 443 port for NGINX Private"
          tcp_options = {
            min = 443
            max = 443
          }
        },
        {
          protocol    = "6"
          source      = "10.1.1.69/32"
          description = "Allow LDAP HTTP"
          tcp_options = {
            min = 389
            max = 389
          }
        },
        {
          protocol    = "6"
          source      = "10.1.1.69/32"
          description = "Allow LDAP HTTPS"
          tcp_options = {
            min = 636
            max = 636
          }
        },
        {
          protocol    = "17"
          source      = "0.0.0.0/0"
          description = "Allow DNS Resolve"
          udp_options = {
            min = 53
            max = 53
          }
        } /*
        {
          protocol    = "all"
          source      = "0.0.0.0/0"
          description = "Allow all Test Purpose Exclude after"
          udp_options = {
            min = null
            max = null
          }
        },
        {
          protocol    = "all"
          source      = "20.1.0.0/16"
          description = "Allow all Traffic from VCN iad2p"
          udp_options = {
            min = null
            max = null
          }
        }*/
      ]
      egress_rules = [
        {
          destination = "0.0.0.0/0"
          protocol    = "all"
        }
      ]
    }
  ]

  subnets = [
    {
      cidr_block        = "10.21.0.0/24" //subnet oke cluster lb 
      display_name      = "sn-oci-oke-sin1q0"
      dns_label         = "snokesin1q0"
      route_table_id    = module.vcn-oci-oke-sin1q.route_table_ids["rt-sn-oci-oke-sin1q0"] //example
      security_list_ids = [module.vcn-oci-oke-sin1q.custom_security_list_ids["sl-oci-oke-sin1q0"]]
      //security_list_ids = [module.vcn-oci-oke-sin1q.default_security_list_id]
    },
    {
      cidr_block                 = "10.21.1.0/24" //subnet master oke cluster
      display_name               = "sn-oci-oke-sin1q1"
      dns_label                  = "snokesin1q1"
      route_table_id             = module.vcn-oci-oke-sin1q.route_table_ids["rt-sn-oci-oke-sin1q1"]
      security_list_ids          = [module.vcn-oci-oke-sin1q.custom_security_list_ids["sl-oci-oke-sin1q1"]]
      prohibit_public_ip_on_vnic = true
    },
    {
      cidr_block                 = "10.21.8.0/21" //subnet node oke cluster
      display_name               = "sn-oci-oke-sin1q8"
      dns_label                  = "snokesin1q8"
      route_table_id             = module.vcn-oci-oke-sin1q.route_table_ids["rt-sn-oci-oke-sin1q8"]
      security_list_ids          = [module.vcn-oci-oke-sin1q.custom_security_list_ids["sl-oci-oke-sin1q8"]]
      prohibit_public_ip_on_vnic = true
    },
    {
      cidr_block                 = "10.21.2.0/24" //subnet intranet services and db
      display_name               = "sn-oci-oke-sin1q2"
      dns_label                  = "snokesin1q2"
      route_table_id             = module.vcn-oci-oke-sin1q.route_table_ids["rt-sn-oci-oke-sin1q2"]
      security_list_ids          = [module.vcn-oci-oke-sin1q.custom_security_list_ids["sl-oci-oke-sin1q2"]]
      prohibit_public_ip_on_vnic = true //uncomment when already configured
    }
  ]

  route_rules = {
    "rt-sn-oci-oke-sin1q0" = [
      {
        network_entity_id = module.vcn-oci-oke-sin1q.internet_gateway_id
        description       = "Default Rule for IGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-oke-sin1q1" = [
      {
        network_entity_id = module.vcn-oci-oke-sin1q.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-oke-sin1q.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-sin-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Rule for VPN"
        destination       = "10.1.1.121/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Rule for ArgoCD"
        destination       = "10.10.8.0/21"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-oke-sin1q8" = [
      {
        network_entity_id = module.vcn-oci-oke-sin1q.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-oke-sin1q.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-sin-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.121/32"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-oke-sin1q2" = [
      {
        network_entity_id = module.vcn-oci-oke-sin1q.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-oke-sin1q.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-sin-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.121/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.122/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.69/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Subnet spo1p2 SPO Route"
        destination       = "10.1.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Subnet sin1q2 IAD Route"
        destination       = "10.10.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-sin1.drg_id
        description       = "Subnet gru1p2 IAD Route"
        destination       = "10.40.2.0/24"
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

output "vcn-oci-oke-sin1q" {
  value = module.vcn-oci-oke-sin1q.vcn_id
}