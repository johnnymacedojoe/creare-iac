variable "compartment_id" {
  description = "The OCID of the compartment."
  type        = string
}

variable "vnc_id" {
  description = "The OCID of the VCN where to create the network security group."
  type        = string
}

variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
}

variable "nsg_rules" {
  description = "The list of rules for the network security group."
  type = list(object({
    id               = optional(string)
    direction        = string
    protocol         = string
    source           = optional(string)
    description      = optional(string)
    destination      = optional(string)
    source_type      = optional(string)
    destination_type = optional(string)
    min_port         = number
    max_port         = number
  }))
  default = []
}

variable "defined_tags" {
  description = "Metadata to assign to the instance."
  type        = map(string)
  default     = {}
}