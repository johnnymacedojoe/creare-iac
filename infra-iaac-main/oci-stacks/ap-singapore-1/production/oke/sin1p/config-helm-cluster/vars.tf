provider "helm" {
  kubernetes {
    config_path = "~/.kube/config-sin1p" # Path to your kubeconfig file
  }
}