module "nsg-derby" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-derby"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "default egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 40089
      max_port    = 40089
      description = "Rabbit MQ admin port"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 40089
      max_port    = 40089
      description = "Rabbit MQ admin port"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 15453
      max_port    = 15453
      description = "PGSQL G5-V1"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 19100
      max_port    = 19100
      description = "Teste: Prometheus"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "qa-jimi-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 9080
      max_port    = 9080
      description = "qa-jimi-services-api-9080"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 1936
      max_port    = 1936
      description = "qa-jimi-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "qa-jimi-services-media-8881"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g5.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "qa-jimi-services-upload-23010"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 19100
      max_port    = 19100
      description = "Marselha Prometheus"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.20/32"
      min_port    = 22
      max_port    = 22
      description = "Marselha AWX"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-esparta
      min_port    = null
      max_port    = null
      description = "For Tasks purpose after change "
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.2/32"
      min_port    = 9001
      max_port    = 9002
      description = "Portainer"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-derby.nsg_id
}
