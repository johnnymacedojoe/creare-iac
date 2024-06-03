
module "nsg-qa-lbgw-cs-g5" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Corp-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-qa-lbgw-cs-g5"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "1"                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK"         // or "NETWORK_SECURITY_GROUP"
      source      = "177.101.242.106/32" //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null                 // These are not actually used in the EGRESS rule but need to be provided.
      max_port    = null
      description = "ICMP a partir dos links da Creare - SEDE"
    },
    {
      direction   = "INGRESS"
      protocol    = "1"                 // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK"        // or "NETWORK_SECURITY_GROUP"
      source      = "45.178.155.102/32" //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null                // These are not actually used in the EGRESS rule but need to be provided.
      max_port    = null
      description = "ICMP a partir dos links da Creare - SEDE"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "qa-jimi-ga-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 9080
      max_port    = 9080
      description = "qa-jimi-ga-services-api-9080"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "qa-jimi-ga-services-upload-23010"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 1936
      max_port    = 1936
      description = "qa-jimi-ga-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "qa-jimi-ga-services-media-8881"
    }
  ]
}

output "nsg-qa-lbgw-cs-g5-id" {
  value = module.nsg-qa-lbgw-cs-g5.nsg_id
}
