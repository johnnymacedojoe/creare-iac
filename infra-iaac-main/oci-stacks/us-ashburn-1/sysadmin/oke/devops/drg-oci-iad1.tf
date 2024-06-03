module "drg-oci-iad1" {
  source = "../../../modules/new-drg"

  compartment_id   = var.SysAdmin
  drg_display_name = "drg-oci-iad1"

  drg_att = [
    {
      display_name      = "att-vcn-oci-okedo-iad1p"
      network_entity_id = module.vcn-oci-oke-devops-iad1p.vcn_id
      type              = "VCN" //IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN, VIRTUAL_CIRCUIT
      //route_table_id     = "routeTableId1"
      //vcn_route_type     = "vcnRouteType1"
      //drg_route_table_id = "drgRouteTableId1"
    } /*,
    {
      display_name       = "att-vcn-oci-okedo-spo1p"
      network_entity_id  = var.drg-oci-spo1
      type               = "REMOTE_PEERING_CONNECTION" //IPSEC_TUNNEL, REMOTE_PEERING_CONNECTION, VCN, VIRTUAL_CIRCUIT
      //route_table_id     = "routeTableId1"
      //vcn_route_type     = "vcnRouteType1"
      //drg_route_table_id = "drgRouteTableId1"
    }*/
  ]
}

output "drg-oci-iad1-id" {
  value = module.drg-oci-iad1.drg_id
}