resource "oci_streaming_stream_pool" "pd_stream_pool" {
  #Required
  compartment_id = var.bu_april
  name           = "PD-APrilPool"

  freeform_tags = { "Enterprise" = "April", "Env" = "PD" }

  kafka_settings {

    auto_create_topics_enable = false
  }

  private_endpoint_settings {

    nsg_ids             = [module.nsg-pd-streams.nsg_id]
    private_endpoint_ip = "10.20.2.100"
    subnet_id           = module.vcn-oci-oke-sin1p.subnet_ids["sn-oci-oke-sin1p2"]
  }
}


resource "oci_streaming_stream" "pd_stream" {
  #Required
  name       = "positions.april.raw"
  partitions = 1

  #Optional
  //compartment_id     = var.bu-agro
  freeform_tags      = { "Enterprise" = "April", "Env" = "pd" }
  retention_in_hours = 168
  stream_pool_id     = oci_streaming_stream_pool.pd_stream_pool.id
}

resource "oci_streaming_stream" "pd_stream_dead_letter" {
  #Required
  name       = "positions.april.deadletter"
  partitions = 1

  #Optional
  //compartment_id     = var.bu-agro
  freeform_tags      = { "Enterprise" = "April", "Env" = "pd" }
  retention_in_hours = 168
  stream_pool_id     = oci_streaming_stream_pool.pd_stream_pool.id
}


module "nsg-pd-streams" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.bu_april
  vnc_id         = module.vcn-oci-oke-sin1p.vcn_id
  nsg_name       = "nsg-pd-streams"
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
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "10.1.1.121/32"
      min_port    = null
      max_port    = null
      description = "VPN acess"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP" // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods-pd.nsg_id
      min_port    = null
      max_port    = null
      description = "All Ports from pods to the Streams Service"
    }
  ]
}