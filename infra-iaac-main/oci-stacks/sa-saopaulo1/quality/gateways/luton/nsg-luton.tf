module "nsg-luton" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-luton"
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
      description = "Rabbit MQ admin port "
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 15477
      max_port    = 15477
      description = "PGSQL admin VPN port "
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-versalhes
      min_port    = 15492
      max_port    = 15492
      description = "MongoDB admin VPN port "
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
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 40103
      max_port    = 40103
      description = "qa-jimi-ga-services-streamer-40103"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 21122
      max_port    = 21122
      description = "qa-jimi-ga-services-gateway-450"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "qa-jimi-ga-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 9080
      max_port    = 9080
      description = "qa-jimi-ga-services-api-9080"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 1936
      max_port    = 1936
      description = "qa-jimi-ga-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "qa-jimi-ga-services-media-8881"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 10002
      max_port    = 10003
      description = "qa-jimi-ga-services-media-10002-10003"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 10556
      max_port    = 10556
      description = "qa-jimi-ga-services-tracker-upload-process-10556"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "qa-jimi-ga-services-upload-23010"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-qa-lbgw-cs-g7.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 21188
      max_port    = 21188
      description = "qa-jimi-ga-services-tracker-gate-upload-21188"
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
      protocol    = "6"                                                                                                         // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"                                                                                    // or "NETWORK_SECURITY_GROUP"
      source      = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaan3dk47mjf5zm24xiwhpnczegeduuo45m67mkub5fndaw2bznnxyq" //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 15477
      max_port    = 15477
      description = "qa-jimi-ga-services-tracker-gate-upload-21188"
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
  value = module.nsg-luton.nsg_id
}
