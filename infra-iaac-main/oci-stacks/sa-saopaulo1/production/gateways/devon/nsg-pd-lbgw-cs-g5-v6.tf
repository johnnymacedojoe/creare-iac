
module "nsg-pd-lbgw-cs-g5-v6" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Safety-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-pd-lbgw-cs-g5-v6"
  defined_tags   = var.defined_tags_set
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
      source      = "177.101.242.106/32" //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = null                 // These are not actually used in the EGRESS rule but need to be provided.
      max_port    = null
      description = "ICMP a partir dos links da Creare - SEDE"
    },
    {
      direction   = "INGRESS"
      protocol    = "1"                 // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK"        // or "NETWORK_SECURITY_GROUP"
      source      = "45.178.155.102/32" //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = null                // These are not actually used in the EGRESS rule but need to be provided.
      max_port    = null
      description = "ICMP a partir dos links da Creare - SEDE"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "pd-jimi-g5-v6-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 9080
      max_port    = 9080
      description = "pd-jimi-g5-v6-services-api-9080"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "pd-jimi-g5-v6-services-upload-23010"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 1936
      max_port    = 1936
      description = "pd-jimi-g5-v6-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "pd-jimi-g5-v6-services-media-8881"
    }
  ]
}

output "nsg-pd-lbgw-cs-g5-v6-id" {
  value = module.nsg-pd-lbgw-cs-g5-v6.nsg_id
}
