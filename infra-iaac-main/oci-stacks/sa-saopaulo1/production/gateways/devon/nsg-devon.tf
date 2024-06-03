module "nsg-devon" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-Safety-compartment_ocid
  vnc_id         = var.vcn-oci-spo1p
  nsg_name       = "nsg-devon"
  defined_tags   = var.defined_tags_set
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
      min_port    = 15470
      max_port    = 15470
      description = "PGSQL admin VPN port "
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
      protocol    = "6"                                // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"           // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-v6.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 21100
      max_port    = 21100
      description = "pd-jimi-g5-v6-services-gateway-400"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"           // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-v6.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 9080
      max_port    = 9080
      description = "pd-jimi-g5-v6-services-api-9080"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"           // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-v6.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 1936
      max_port    = 1936
      description = "pd-jimi-g5-v6-services-media-1936"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"           // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-v6.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 8881
      max_port    = 8881
      description = "pd-jimi-g5-v6-services-media-8881"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                                // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"           // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-pd-lbgw-cs-g5-v6.nsg_id //module.nsg-pd-lbgw-cs-smartwatch.nsg_id
      min_port    = 23010
      max_port    = 23010
      description = "pd-jimi-g5-v6-services-upload-23010"
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
      source      = var.nsg-cannes
      min_port    = 9080
      max_port    = 9080
      description = "Request API internal VPN"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-cannes
      min_port    = 15470
      max_port    = 15470
      description = "PGSQL for normal VPN"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-malaga
      min_port    = 15470
      max_port    = 15470
      description = "PGSQL for Kafka"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.4.1.2/32"
      min_port    = 9001
      max_port    = 9002
      description = "Portainer"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-sevilha
      min_port    = 9080
      max_port    = 9080
      description = "Acess tasks"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-london
      min_port    = 8881
      max_port    = 10000
      description = "Access Streamer London"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = var.nsg-gateshead
      min_port    = 40106
      max_port    = 40106
      description = "Access FileList Jimi"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.0.12/32"
      min_port    = 1935
      max_port    = 1935
      description = "Access HaProxy Inversion Jimi"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.0.12/32"
      min_port    = 21100
      max_port    = 21100
      description = "Access HaProxy Inversion Jimi"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.0.12/32"
      min_port    = 23010
      max_port    = 23010
      description = "Access HaProxy Inversion Jimi"
    }
  ]
}

output "nsg_id" {
  value = module.nsg-devon.nsg_id
}
