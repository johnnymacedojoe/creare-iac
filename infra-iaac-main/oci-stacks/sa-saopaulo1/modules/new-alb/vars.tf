variable "compartment_id" {
  description = "The OCID of the compartment in which to create the load balancer."
  type        = string
}

variable "display_name" {
  description = "A user-friendly name for the load balancer. Does not have to be unique."
  type        = string
}

variable "public_ip" {
  description = "public-ip-id reserved"
  type        = string
  default     = null
}

variable "is_private" {
  description = "Whether the load balancer has a VCN-local (private) IP address."
  type        = bool
}

variable "subnet_ids" {
  description = "An array of subnet OCIDs."
  type        = list(string)
}

variable "minimum_bandwidth" {
  description = "The minimum bandwidth for flexible load balancer shape in Mbps."
  type        = number
}

variable "maximum_bandwidth" {
  description = "The maximum bandwidth for flexible load balancer shape in Mbps."
  type        = number
}

variable "network_security_group_ids" {
  description = "The subnet ID where the load balancer will be created"
  type        = list(string)
  //default = [ "" ]
}

/*variable "freeform_tags" {
  description = "Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see Resource Tags."
  type        = map(string)
  default     = {}
}*/

variable "backend_sets" {
  description = "A list of backend sets"
  type = list(object({
    name   = string
    policy = string
    health_checker = object({
      port     = number
      protocol = string
      url_path = string
    })
    backends = list(object({
      //backend_set_name = string
      ip_address = string
      port       = number
    }))
    ssl_configuration = optional(object({
      certificate_ids = string
      //certificate_name        = string
      verify_depth            = optional(number)
      verify_peer_certificate = optional(bool)
    }))
  }))
}

variable "listeners" {
  description = "A list of listeners to be created. Each listener is defined by a map that includes properties for the listener."
  type = list(object({
    name             = string
    backend_set_name = string
    protocol         = string
    port             = number
    ssl_configuration = optional(object({
      certificate_ids = string
      //certificate_name        = string
      verify_depth            = optional(number)
      verify_peer_certificate = optional(bool)
    }))
  }))
}


variable "defined_tags" {
  description = "Metadata to assign to the instance."
  type        = map(string)
  default     = {}
}