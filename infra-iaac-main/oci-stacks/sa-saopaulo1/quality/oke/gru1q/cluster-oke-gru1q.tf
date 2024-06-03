module "cluster-oke-gru1q" {
  source = "../../../modules/new-oke"

  compartment_id     = var.BU-corp
  kubernetes_version = "v1.29.1"
  name               = "cluster-oke-gru1q"
  vcn_id             = module.vcn-oci-oke-gru1q.vcn_id
  type               = "BASIC_CLUSTER"

  cluster_pod_network_options = {
    cni_type = "OCI_VCN_IP_NATIVE" //OCI_VCN_IP_NATIVE FLANNEL_OVERLAY
  }

  endpoint_config = {
    is_public_ip_enabled = false
    nsg_ids              = [module.nsg-oke-api.nsg_id]
    subnet_id            = module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q1"]
  }

  options = {
    is_kubernetes_dashboard_enabled = false
    is_tiller_enabled               = false
    is_pod_security_policy_enabled  = false
    pods_cidr                       = null //"10.244.0.0/16"//null
    services_cidr                   = "10.140.0.0/16"
    service_lb_subnet_ids           = [module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q0"]]
  }

  node_pools = [
    {
      name                                      = "bt-oke-node-pool-1-29--1"
      node_shape                                = "VM.Standard.E5.Flex"
      node_pool_node_shape_config_memory_in_gbs = 24
      node_pool_node_shape_config_ocpus         = 2
      kubernetes_version                        = "v1.29.1"
      placement_configs_availability_domain     = "CdKG:SA-SAOPAULO-1-AD-1"
      placement_configs_subnet_id               = module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q8"]
      size                                      = 2
      cni_type                                  = "OCI_VCN_IP_NATIVE" //FLANNEL_OVERLAY
      pod_subnet_ids                            = [module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q8"]]
      node_pool_image_id                        = var.img_oke_amd_1_29
      node_pool_node_source_details_source_type = "IMAGE"
      nsg_ids                                   = [module.nsg-oke-worker.nsg_id]
      pod_nsg_ids                               = [module.nsg-oke-pods.nsg_id]
    },
    {
      name                                      = "bt-oke-node-pool-1-29--2"
      node_shape                                = "VM.Standard.E5.Flex"
      node_pool_node_shape_config_memory_in_gbs = 24
      node_pool_node_shape_config_ocpus         = 2
      kubernetes_version                        = "v1.29.1"
      placement_configs_availability_domain     = "CdKG:SA-SAOPAULO-1-AD-1"
      placement_configs_subnet_id               = module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q8"]
      size                                      = 2
      cni_type                                  = "OCI_VCN_IP_NATIVE" //FLANNEL_OVERLAY
      pod_subnet_ids                            = [module.vcn-oci-oke-gru1q.subnet_ids["sn-oci-oke-gru1q8"]]
      node_pool_image_id                        = var.img_oke_amd_1_29
      node_pool_node_source_details_source_type = "IMAGE"
      nsg_ids                                   = [module.nsg-oke-worker.nsg_id]
      pod_nsg_ids                               = [module.nsg-oke-pods.nsg_id]
    }
    /* name                                      = string
      node_shape                                = string
      defined_tags                              = optional(map(string))
      freeform_tags                             = optional(map(string))
      initial_node_labels_key                   = optional(string)
      initial_node_labels_value                 = optional(string)
      kubernetes_version                        = optional(string)
      placement_configs_availability_domain     = optional(string)
      placement_configs_subnet_id               = optional(string)
      placement_configs_capacity_reservation_id = optional(string)
      placement_configs_fault_domains           = optional(list(string))
      preemption_action_type                    = optional(string)
      preemption_action_is_preserve_boot_volume = optional(bool)
      size                                      = optional(number)
      is_pv_encryption_in_transit_enabled       = optional(bool)
      kms_key_id                                = optional(string)
      cni_type                                  = optional(string)
      max_pods_per_node                         = optional(number)
      pod_nsg_ids                               = optional(list(string))
      pod_subnet_ids                            = optional(list(string))
      nsg_ids                                   = optional(list(string))
      node_pool_node_shape_config_ocpus                     = optional(number)
      node_pool_node_shape_config_memory_in_gbs             = optional(number)
      node_pool_image_id                                    = string
      node_pool_node_source_details_source_type             = string
      node_pool_node_source_details_boot_volume_size_in_gbs = optional(number)*/
  ]
}


module "nsg-oke-api" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-corp
  vnc_id         = module.vcn-oci-oke-gru1q.vcn_id
  nsg_name       = "nsg-oke-api"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"     // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-worker.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6443
      max_port    = 6443
      description = "Kubernetes worker to Kubernetes API endpoint communication."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"     // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-worker.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 12250
      max_port    = 12250
      description = "Kubernetes worker to Kubernetes API endpoint communication."
    },
    {
      direction   = "INGRESS"
      protocol    = "1"                          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"     // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-worker.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Path Discovery."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"   // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6443
      max_port    = 6443
      description = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"   // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 12250
      max_port    = 12250
      description = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"            // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK"   // or "NETWORK_SECURITY_GROUP"
      source      = "10.10.8.0/21" //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6443
      max_port    = 6443
      description = "ArgoCD POD Network"
    } /*,
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //change after for subnets specify  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 6443
      max_port    = 6443
      description = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
    }*/
  ]
}

output "nsg_oke_id_api" {
  value = module.nsg-oke-api.nsg_id
}

module "nsg-oke-worker" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-corp
  vnc_id         = module.vcn-oci-oke-gru1q.vcn_id
  nsg_name       = "nsg-oke-worker"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"     // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-worker.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Allows communication from (or to) worker nodes."
    },
    {
      direction   = "INGRESS"
      protocol    = "all"                      // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"   // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-pods.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Allow pods on one worker node to communicate with pods on other worker nodes (when using VCN-native pod networking)."
    },
    {
      direction   = "INGRESS"
      protocol    = "1"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Path Discovery."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                       // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"  // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-api.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Pod to Kubernetes API endpoint communication (when using VCN-native pod networking)."
    },
    {
      direction   = "INGRESS"
      protocol    = "6"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      source      = "0.0.0.0/0"  //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = 10256
      max_port    = 10256
      description = "Health Check TCP 10256"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                             // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"        // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-nlb-qa-zabbix.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Zabbix NLB Communication."
    }
  ]
}

output "nsg_oke_id_worker" {
  value = module.nsg-oke-worker.nsg_id
}




module "nsg-oke-pods" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-corp
  vnc_id         = module.vcn-oci-oke-gru1q.vcn_id
  nsg_name       = "nsg-oke-pods"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "all"                     // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"  // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-api.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Kubernetes API endpoint to pod communication (when using VCN-native pod networking)."
    },
    {
      direction   = "INGRESS"
      protocol    = "all"                        // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "NETWORK_SECURITY_GROUP"     // or "NETWORK_SECURITY_GROUP"
      source      = module.nsg-oke-worker.nsg_id //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Allow pods on one worker node to communicate with pods on other worker nodes."
    },
    {
      direction   = "INGRESS"
      protocol    = "all"          // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK"   // or "NETWORK_SECURITY_GROUP"
      source      = "10.40.8.0/21" //module.nsg-qa-lbgw-cs-smartwatch.nsg_id
      min_port    = null
      max_port    = null
      description = "Allow pods to communicate with each other."
    }
  ]
}

module "nsg-nlb-qa-zabbix" {
  source         = "../../../modules/new-nsg"
  compartment_id = var.BU-corp
  vnc_id         = module.vcn-oci-oke-gru1q.vcn_id
  nsg_name       = "nsg-nlb-qa-zabbix"
  nsg_rules = [
    {
      direction        = "EGRESS"
      protocol         = "all"        // ICMP ("1"), TCP ("6"), UDP ("17") all
      destination_type = "CIDR_BLOCK" // or "NETWORK_SECURITY_GROUP"
      destination      = "0.0.0.0/0"
      min_port         = null // These are not actually used in the EGRESS rule but need to be provided.
      max_port         = null
      description      = "Default Egress"
    },
    {
      direction   = "INGRESS"
      protocol    = "6"                  // ICMP ("1"), TCP ("6"), UDP ("17")
      source_type = "CIDR_BLOCK"         // or "NETWORK_SECURITY_GROUP"
      source      = "168.138.139.173/32" //module.nsg-qa-lbgw-cs-smartwatch.nsg_id 
      min_port    = 10051
      max_port    = 10051
      description = "Allow NAT SPO to communicate with Zabbix Proxy for QA."
    }
  ]
}

output "nsg_oke_id_pods" {
  value = module.nsg-oke-pods.nsg_id
}

