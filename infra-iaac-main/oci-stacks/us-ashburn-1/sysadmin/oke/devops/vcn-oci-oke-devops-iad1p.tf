module "vcn-oci-oke-devops-iad1p" {
  source = "../../../modules/new-vcn"

  compartment_id = var.SysAdmin
  cidr_blocks    = ["10.10.0.0/16"]
  display_name   = "vcn-oci-oke-devops-iad1p"
  dns_label      = "okedevopsiad1p"

  internet_gateway_display_name = "ig-oci-oke-devops-iad1p"
  internet_gateway_enabled      = true
  nat_gateway_display_name      = "ng-oci-oke-devops-iad1p"
  //nat_gateway_ip_id = ""
  service_gateway_display_name = "sg-oci-oke-devops-iad1p"

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
      display_name = "sl-oci-oke-devops-iad1p0"
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
          description = "Allow HTTP NGINX"
          tcp_options = {
            min = 80
            max = 80
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow HTTPS NGINX"
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
      display_name = "sl-oci-oke-devops-iad1p1"
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
      display_name = "sl-oci-oke-devops-iad1p8"
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
          source      = "10.10.0.0/24"
          description = "Allow ALB public to kube-proxy"
          tcp_options = {
            min = 10256
            max = 10256
          }
        },
        {
          protocol    = "6"
          source      = "10.10.2.0/24"
          description = "Allow ALB private to kube-proxy"
          tcp_options = {
            min = 10256
            max = 10256
          }
        },
        {
          protocol    = "6"
          source      = "10.10.2.0/24"
          description = "Allow ALB private NGINX"
          tcp_options = {
            min = 30891
            max = 30891
          }
        },
        {
          protocol    = "6"
          source      = "10.10.2.0/24"
          description = "Allow ALB private NGINX"
          tcp_options = {
            min = 30279
            max = 30279
          }
        },
        {
          protocol    = "6"
          source      = "10.10.2.0/24"
          description = "Allow ALB 1514 TCP Wazuh port Traefik endpoind"
          tcp_options = {
            min = 30463
            max = 30463
          }
        },
        {
          protocol    = "6"
          source      = "10.10.2.0/24"
          description = "Allow ALB 1515 TCP Wazuh port Traefik endpoind"
          tcp_options = {
            min = 31149
            max = 31149
          }
        },
        {
          protocol    = "6"
          source      = "10.10.2.0/24"
          description = "Allow ALB 55000 API Wazuh port Traefik endpoind"
          tcp_options = {
            min = 32412
            max = 32412
          }
        } /*
        {
          protocol    = "6"
          source      = "10.1.1.0/24"
          description = "Allow Kubernetes API endpoint to communicate with worker nodes"
          tcp_options = {
            min = 1
            max = 65535
          }
        },
        {
          protocol    = "1"
          source      = "10.1.1.0/24"
          description = "Kubernetes API endpoint to worker node communication (when using VCN-native pod networking)."
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
      display_name = "sl-oci-oke-devops-iad1p2"
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
          source      = "10.1.1.122/32"
          description = "Allow all Traffic from VCN CANNES HTTPS iad2p"
          tcp_options = {
            min = 443
            max = 443
          }
        },
        {
          protocol    = "6"
          source      = "10.1.1.122/32"
          description = "Allow all Traffic from VCN CANNES HTTPS iad2p"
          tcp_options = {
            min = 80
            max = 80
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
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow  HTTP"
          tcp_options = {
            min = 80
            max = 80
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow  HTTPS"
          tcp_options = {
            min = 443
            max = 443
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
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow ALB 1514 TCP Wazuh port Traefik endpoind"
          tcp_options = {
            min = 1514
            max = 1514
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow ALB 1515 TCP Wazuh port Traefik endpoind"
          tcp_options = {
            min = 1515
            max = 1515
          }
        },
        {
          protocol    = "6"
          source      = "0.0.0.0/0"
          description = "Allow Wazuh API 55000"
          tcp_options = {
            min = 55000
            max = 55000
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
      cidr_block        = "10.10.0.0/24" //subnet oke cluster lb 
      display_name      = "sn-oci-oke-devops-iad1p0"
      dns_label         = "sndevopsiad1p0"
      route_table_id    = module.vcn-oci-oke-devops-iad1p.route_table_ids["rt-sn-oci-oke-devops-iad1p0"] //example
      security_list_ids = [module.vcn-oci-oke-devops-iad1p.custom_security_list_ids["sl-oci-oke-devops-iad1p0"]]
      //security_list_ids = [module.vcn-oci-oke-devops-iad1p.default_security_list_id]
    },
    {
      cidr_block                 = "10.10.1.0/24" //subnet master oke cluster
      display_name               = "sn-oci-oke-devops-iad1p1"
      dns_label                  = "sndevopsiad1p1"
      route_table_id             = module.vcn-oci-oke-devops-iad1p.route_table_ids["rt-sn-oci-oke-devops-iad1p1"]
      security_list_ids          = [module.vcn-oci-oke-devops-iad1p.custom_security_list_ids["sl-oci-oke-devops-iad1p1"]]
      prohibit_public_ip_on_vnic = true
    },
    {
      cidr_block                 = "10.10.8.0/21" //subnet node oke cluster
      display_name               = "sn-oci-oke-devops-iad1p8"
      dns_label                  = "sndevopsiad1p8"
      route_table_id             = module.vcn-oci-oke-devops-iad1p.route_table_ids["rt-sn-oci-oke-devops-iad1p8"]
      security_list_ids          = [module.vcn-oci-oke-devops-iad1p.custom_security_list_ids["sl-oci-oke-devops-iad1p8"]]
      prohibit_public_ip_on_vnic = true
    },
    {
      cidr_block                 = "10.10.2.0/24" //subnet intranet services and db
      display_name               = "sn-oci-oke-devops-iad1p2"
      dns_label                  = "sndevopsiad1p2"
      route_table_id             = module.vcn-oci-oke-devops-iad1p.route_table_ids["rt-sn-oci-oke-devops-iad1p2"]
      security_list_ids          = [module.vcn-oci-oke-devops-iad1p.custom_security_list_ids["sl-oci-oke-devops-iad1p2"]]
      prohibit_public_ip_on_vnic = true //uncomment when already configured
    }
  ]

  route_rules = {
    "rt-sn-oci-oke-devops-iad1p0" = [
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.internet_gateway_id
        description       = "Default Rule for IGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-oke-devops-iad1p1" = [
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-iad-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.121/32"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-oke-devops-iad1p8" = [
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-iad-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.121/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.20.1.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.21.1.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.40.1.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet spo1p2 SPO Route"
        destination       = "10.1.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet spo1p1 SPO Route"
        destination       = "10.1.1.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.50.1.0/24"
        destination_type  = "CIDR_BLOCK"
      }
    ],

    "rt-sn-oci-oke-devops-iad1p2" = [
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.nat_gateway_id
        description       = "Default Rule for NGW"
        destination       = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.vcn-oci-oke-devops-iad1p.service_gateway_id
        description       = "Default Rule for SGW"
        destination       = "all-iad-services-in-oracle-services-network"
        destination_type  = "SERVICE_CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Rule for VPN to DRG"
        destination       = "10.1.1.121/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Example rule with dest VCN 2P to DRG"
        destination       = "10.1.1.122/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Rule for LDAP to DRG"
        destination       = "10.1.1.69/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Rule for KC CR PD to DRG"
        destination       = "10.1.1.32/32"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet spo1p2 SPO Route"
        destination       = "10.1.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet sin1p2 SIN Route"
        destination       = "10.20.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet sin1q2 SIN Route"
        destination       = "10.21.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet gru1q2 IAD Route"
        destination       = "10.40.2.0/24"
        destination_type  = "CIDR_BLOCK"
      },
      {
        network_entity_id = module.drg-oci-iad1.drg_id
        description       = "Subnet spo1p1 SPO Route"
        destination       = "10.1.1.0/24"
        destination_type  = "CIDR_BLOCK"
      },
    ]
  }
  /*dhcp_options   = [
        {
        display_name = "dhcp_option1"
        search_domain_names = ["test.com"]
        }
    ]*/

}

output "vcn-oci-oke-devops-iad1p" {
  value = module.vcn-oci-oke-devops-iad1p.vcn_id
}