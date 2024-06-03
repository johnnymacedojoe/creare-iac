variable "are_all_plugins_disabled" {
  description = "Controls whether all plugins are disabled."
  type        = bool
  default     = false
}

variable "is_management_disabled" {
  description = "Controls whether management is disabled."
  type        = bool
  default     = false
}

variable "is_monitoring_disabled" {
  description = "Controls whether monitoring is disabled."
  type        = bool
  default     = false
}

variable "plugins_config" {
  description = "Configuration for plugins."
  type        = list(object({ desired_state = string, name = string }))
  default     = []
}

variable "is_live_migration_preferred" {
  description = "Controls whether live migration is preferred."
  type        = bool
  default     = true
}

variable "enable_in_transit_encryption" {
  description = "Whether to enable in-transit encryption for the data volume's paravirtualized attachment. The default value is false. Use this field only during create. "
  type        = bool
  default     = true
}


variable "recovery_action" {
  description = "Controls the recovery action."
  type        = string
  default     = "RESTORE_INSTANCE"
}

variable "availability_domain" {
  description = "The availability domain where the instance will be created."
  type        = string
}

variable "instance_userdata" {
  description = "Path to the file containing the user data script"
  type        = string
  default     = ""
}

variable "source_details" {
  description = "Details about the instance source"
  type = object({
    source_type             = string
    source_id               = string
    boot_volume_size_in_gbs = number
    boot_volume_vpus_per_gb = number
    kms_key_id              = string
  })
  default = {
    source_type             = "image"
    source_id               = "ocid1.image.oc1..example"
    boot_volume_size_in_gbs = 50
    boot_volume_vpus_per_gb = 10
    kms_key_id              = "ocid1.key.oc1..example"
  }
}

variable "compartment_id" {
  description = "The OCID of the compartment where the instance will be created."
  type        = string
}

variable "preserve_boot_vol" {
  description = "Presaerve the boot volume when instance is terminating ."
  type        = bool
  default     = false
}


variable "assign_public_ip" {
  description = "Controls whether a public IP address is assigned to the instance."
  type        = bool
  default     = false
}

variable "instance_name" {
  description = "The name of the instance."
  type        = string
}

variable "nsg_ids" {
  description = "The OCIDs of the Network Security Groups to associate with the instance."
  type        = list(string)
  default     = []
}

variable "private_ip" {
  description = "The private IP to assign to the instance."
  type        = string
  default     = ""
}

variable "skip_source_dest_check" {
  description = "Controls whether source/destination check is disabled on the instance."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "The OCID of the subnet where the instance will be created."
  type        = string
}

variable "defined_tags" {
  description = "Metadata to assign to the instance."
  type        = map(string)
  default     = {}
}

variable "fault_domain" {
  description = "The fault domain where the instance will be created."
  type        = string
}

variable "are_legacy_imds_endpoints_disabled" {
  description = "Controls whether legacy Instance Metadata Service endpoints are disabled."
  type        = bool
  default     = false
}

variable "launch_options" {
  description = "Launch options for the instance."
  type        = map(any)
  default     = {}
}

variable "shape_config" {
  description = "Configuration for the shape of the instance."
  type        = map(any)
  default     = {}
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key to assign to the instance."
  type        = string
}

variable "shape" {
  description = "The shape of the instance."
  type        = string
}

variable "volumes" {
  description = "List of volumes"
  type = list(object({
    display_name = string
    size_in_gbs  = number
    device       = optional(string) // This is a map where you can define 'device_path'
  }))
  default = []
}

variable "create_attachment" {
  description = "Controls whether to create volume attachments or not"
  type        = bool
  default     = true
}
