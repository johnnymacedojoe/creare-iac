provider "helm" {
  kubernetes {
    config_path = "~/.kube/configokedo" # Path to your kubeconfig file
  }
}