module "drg-oci-spo1" {
  source = "./modules/new-drg"

  compartment_id   = var.bryancloud-compartment_ocid
  drg_display_name = "drg-oci-spo1"

  drg_att = [
    {
      display_name      = "att-vcn-oci-spo1p"
      network_entity_id = module.vcn-oci-spo1p.vcn_id
      type              = "VCN" //IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN, VIRTUAL_CIRCUIT
      //route_table_id     = "routeTableId1"
      //vcn_route_type     = "vcnRouteType1"
      //drg_route_table_id = "drgRouteTableId1"
    },
    {
      display_name      = "att-vcn-oci-spo1i"
      network_entity_id = module.vcn-oci-spo1i.vcn_id
      type              = "VCN" //IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN, VIRTUAL_CIRCUIT
      //route_table_id     = "routeTableId1"
      //vcn_route_type     = "vcnRouteType1"
      //drg_route_table_id = "drgRouteTableId1"
    }
  ]
}

output "drg-oci-spo1-id" {
  value = module.drg-oci-spo1.drg_id
}