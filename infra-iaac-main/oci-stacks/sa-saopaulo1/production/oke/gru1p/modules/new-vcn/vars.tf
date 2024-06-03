variable "compartment_id" {
  description = "The OCID of the compartment to contain the VCN"
  type        = string
}

variable "cidr_blocks" {
  description = "The list of one or more IPv4 CIDR blocks for the VCN"
  type        = list(string)
  default     = []
}


variable "display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable."
  type        = string
  default     = ""
}

variable "dns_label" {
  description = "A dns name for FQDN."
  type        = string
  default     = ""
}

variable "defined_tags" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable."
  type        = map(string)
  default     = {}
}

variable "dhcp_options" {
  description = "The DHCP options to be associated with the VCN"
  type = list(object({
    display_name        = string
    search_domain_names = list(string)
  }))
  default = []
}

variable "custom_security_lists" {
  description = "List of custom security lists"
  type = list(object({
    display_name = string
    ingress_rules = list(object({
      protocol    = string
      source      = string
      description = optional(string)
      tcp_options = optional(object({
        min = number
        max = number
      }))
      udp_options = optional(object({
        min = number
        max = number
      }))
    }))
    egress_rules = list(object({
      destination = string
      protocol    = optional(string)
    }))
  }))
  default = []
}


variable "df_sl_ingress_rules" {
  description = "List of ingress rules for the default security list"
  type = list(object({
    protocol    = string
    source      = string
    description = optional(string)
    tcp_options = optional(object({
      min = number
      max = number
      source_port_range = optional(object({
        min = number
        max = number
      }))
    }))
    udp_options = optional(object({
      min = number
      max = number
      source_port_range = optional(object({
        min = number
        max = number
      }))
    }))
  }))
  default = []
}

variable "df_sl_egress_rule" {
  description = "Egress rule"
  type = object({
    destination = string
    protocol    = string
  })
  default = null
}

variable "service_gateway_display_name" {
  description = "Display name for the Service Gateway"
  type        = string
  default     = null
}

variable "nat_gateway_ip_id" {
  description = "Display name for the Service Gateway ip if needed"
  type        = string
  default     = null
}

variable "route_rules" {
  description = "Map of route rules for each route table"
  type = map(list(object({
    network_entity_id = string
    cidr_block        = optional(string)
    description       = optional(string)
    destination       = optional(string)
    destination_type  = optional(string)
  })))
  default = {}
}


variable "route_table_display_name" {
  description = "The display name for the route table."
  type        = string
  default     = "default_route_table_name"
}


variable "subnets" {
  description = "List of subnets to be created in the VCN"
  type = list(object({
    cidr_block                 = string
    display_name               = string
    dns_label                  = string
    availability_domain        = optional(string)
    route_table_id             = optional(string)
    security_list_ids          = optional(list(string))
    prohibit_public_ip_on_vnic = optional(bool)
    // ... any other optional fields you need
  }))
  default = []
}

variable "nat_gateway_display_name" {
  description = "Display name for the NAT Gateway"
  type        = string
  default     = "MyNATGateway"
}

variable "internet_gateway_display_name" {
  description = "Display name for the Internet Gateway"
  default     = "example-igw"
  type        = string
}

variable "internet_gateway_enabled" {
  description = "Boolean flag indicating whether the IGW is enabled or not"
  default     = true
  type        = bool
}

variable "internet_gateway_defined_tags" {
  description = "Defined tags for the Internet Gateway"
  default     = {}
  type        = map(string)
}

variable "internet_gateway_freeform_tags" {
  description = "Freeform tags for the Internet Gateway"
  default     = {}
  type        = map(string)
}

// If you're planning to attach the IGW to a specific route table, also define this variable. 
// Otherwise, you can skip it.
variable "internet_gateway_route_table_id" {
  description = "The OCID of the route table to which the IGW should be attached"
  default     = null
  type        = string
}

