variable "compartment_id" {
  description = "The OCID of the compartment to contain the DRG"
  type        = string
}

variable "drg_display_name" {
  description = "A user-friendly name. Does not have to be unique, and it's changeable."
  type        = string
  default     = "DefaultDrgName"
}

variable "drg_att" {
  description = "List of attachments for each drg attachment"
  type = list(object({
    display_name       = string
    network_entity_id  = string
    type               = string
    route_table_id     = optional(string)
    vcn_route_type     = optional(string)
    drg_route_table_id = optional(string)
  }))
  default = []
}

