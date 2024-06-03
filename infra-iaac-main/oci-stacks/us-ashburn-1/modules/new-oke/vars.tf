variable "compartment_id" {
  description = "The OCID of the compartment."
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes."
  type        = string
}

variable "name" {
  description = "The name of the cluster."
  type        = string
}

variable "vcn_id" {
  description = "The OCID of the VCN."
  type        = string
}

variable "type" {
  description = "Type of cluster. Values can be BASIC_CLUSTER or ENHANCED_CLUSTER."
  type        = string
  default     = "BASIC_CLUSTER"
}

variable "cluster_pod_network_options" {
  description = "Network options for the cluster."
  type        = map(any)
  default     = {}
}

variable "endpoint_config" {
  description = "Endpoint configuration for the cluster."
  type = object({
    is_public_ip_enabled = bool
    nsg_ids              = optional(list(string))
    subnet_id            = string
  })
  default = null
}


variable "image_policy_config" {
  description = "Image policy configuration for the cluster."
  type        = map(any)
  default     = {}
}


variable "defined_tags" {
  description = "Defined tags for the resource."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags for the resource."
  type        = map(string)
  default     = {}
}


variable "options" {
  description = "Additional options for the cluster."
  type = object({
    is_kubernetes_dashboard_enabled = bool
    is_tiller_enabled               = bool
    is_pod_security_policy_enabled  = bool
    pods_cidr                       = string
    services_cidr                   = string
    service_lb_subnet_ids           = list(string)
  })
  default = {
    is_kubernetes_dashboard_enabled = false
    is_tiller_enabled               = false
    is_pod_security_policy_enabled  = false
    pods_cidr                       = ""
    services_cidr                   = ""
    service_lb_subnet_ids           = []
  }
}

variable "node_pools" {
  description = "List of node pools."
  type = list(object({
    name                                                  = string
    node_shape                                            = string
    defined_tags                                          = optional(map(string))
    freeform_tags                                         = optional(map(string))
    initial_node_labels_key                               = optional(string)
    initial_node_labels_value                             = optional(string)
    kubernetes_version                                    = optional(string)
    placement_configs_availability_domain                 = optional(string)
    placement_configs_subnet_id                           = optional(string)
    placement_configs_capacity_reservation_id             = optional(string)
    placement_configs_fault_domains                       = optional(list(string))
    preemption_action_type                                = optional(string)
    preemption_action_is_preserve_boot_volume             = optional(bool)
    size                                                  = optional(number)
    is_pv_encryption_in_transit_enabled                   = optional(bool)
    kms_key_id                                            = optional(string)
    cni_type                                              = optional(string)
    max_pods_per_node                                     = optional(number)
    pod_nsg_ids                                           = optional(list(string))
    pod_subnet_ids                                        = optional(list(string))
    nsg_ids                                               = optional(list(string))
    node_pool_node_shape_config_ocpus                     = optional(number)
    node_pool_node_shape_config_memory_in_gbs             = optional(number)
    node_pool_image_id                                    = string
    node_pool_node_source_details_source_type             = string
    node_pool_node_source_details_boot_volume_size_in_gbs = optional(number)
  }))
  default = []
}



