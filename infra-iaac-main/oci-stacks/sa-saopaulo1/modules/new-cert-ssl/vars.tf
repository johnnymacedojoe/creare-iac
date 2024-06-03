variable "ca_certificate_path" {
  description = "Path to the CA certificate"
  type        = string
}

variable "certificate_name" {
  description = "Name of the certificate"
  type        = string
}

variable "load_balancer_id" {
  description = "The OCID of the load balancer"
  type        = string
}

variable "passphrase" {
  description = "Passphrase for the certificate's private key"
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Path to the private key of the certificate"
  type        = string
}

variable "public_certificate_path" {
  description = "Path to the public certificate"
  type        = string
}
