resource "helm_release" "grafana-prometheus" {
  name             = "grafana-prometheus"
  namespace        = "grafana-prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "51.10.0" # Replace with the desired version
  create_namespace = "true"

  /*set {
    name  = "service.type"
    value = "LoadBalancer"
  }*/
  //access the cluster
  //kubectl -n traefik port-forward $(kubectl -n traefik get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000

  values = [file("values-grafana-prometheus.yaml")]

}