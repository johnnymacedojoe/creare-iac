variable "compartment_id" {
  description = "The compartment ID to create the load balancer in"
  type        = string
}

variable "display_name" {
  description = "The display name for the load balancer"
  type        = string
}

variable "is_private" {
  description = "Determines if the load balancer is private"
  type        = bool
}

variable "public_ip" {
  description = "public-ip-id reserved"
  type        = string
  default     = null
}

variable "is_preserve_source" {
  description = "Whether the load balancer has a VCN-local (private) IP address."
  type        = bool
}

variable "subnet_id" {
  description = "The subnet ID where the load balancer will be created"
  type        = string
}

variable "nlb_ip_version" {
  description = "The subnet ID where the load balancer will be created"
  type        = string
}

variable "network_security_group_ids" {
  description = "The subnet ID where the load balancer will be created"
  type        = list(string)
  //default = [ "" ]
}

variable "backend_sets" {
  description = "Backend sets to create in the load balancer"
  type = list(object({
    name   = string
    policy = string
    health_checker = object({
      port     = number
      protocol = string
      url_path = optional(string)
    })
    backends = list(object({
      ip_address = string
      port       = number
      target_id  = optional(string)
    }))
  }))
}

variable "listeners" {
  description = "Listeners to create in the load balancer"
  type = list(object({
    name             = string
    port             = number
    protocol         = string
    backend_set_name = string
  }))
}
