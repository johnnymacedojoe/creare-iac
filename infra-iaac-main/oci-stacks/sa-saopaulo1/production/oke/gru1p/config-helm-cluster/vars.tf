provider "helm" {
  kubernetes {
    config_path = "~/.kube/config-gru1p" # Path to your kubeconfig file
  }
}