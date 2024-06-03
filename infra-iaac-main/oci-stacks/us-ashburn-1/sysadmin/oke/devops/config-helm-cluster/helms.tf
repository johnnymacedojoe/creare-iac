resource "helm_release" "argocd-oke" {
  name             = "argocd-oke"
  namespace        = "argocd-oke"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.51.6" # Replace with the desired version
  create_namespace = "true"

  values = [file("values-argocd-oke2.yaml")]
}

resource "helm_release" "grafana-prometheus" {
  name             = "grafana-prometheus"
  namespace        = "grafana-prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = "56.0.0" # Replace with the desired version
  create_namespace = "true"

  values = [file("values-grafana-prometheus.yaml")]

}