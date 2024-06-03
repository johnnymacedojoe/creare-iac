variable "compartment_id" {
  description = "The OCID of the compartment"
  type        = string
}

variable "display_name" {
  description = "A user-friendly name"
  type        = string
}

variable "defined_tags" {
  description = "Metadata to assign to the instance."
  type        = map(string)
  default     = {}
}