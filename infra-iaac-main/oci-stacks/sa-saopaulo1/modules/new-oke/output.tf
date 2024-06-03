output "cluster_id" {
  value = oci_containerengine_cluster.cs_oke.id
}

output "cluster_state" {
  value = oci_containerengine_cluster.cs_oke.state
}

output "cluster_kubernetes_version" {
  value = oci_containerengine_cluster.cs_oke.kubernetes_version
}
