//Need provider for OCI Cloud Stacks
provider "oci" {
  region = "sa-saopaulo-1"
  //config_file_profile = ""
}

variable "sandbox" { default = "ocid1.compartment.oc1..aaaaaaaaw62jnc676zwrstacmbuyhivdffy4232thfnvoenatmzupru5ka2q" }

//avd
variable "availability_domain_sp" { default = "CdKG:SA-SAOPAULO-1-AD-1" }
variable "availability_domain_iad_1" { default = "GdKG:US-ASHBURN-AD-1" }
variable "availability_domain_sin" { default = "CdKG:AP-SINGAPORE-1-AD-1" }

//subnet and vcn for sandbox
variable "sandbox_subnet_instance" { default = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaaqq6jeoanfnhzhbayw6yg23hb2m52nqjqerdehiyla3zea4kpwk3a" }
variable "sandbox_vcn_nsg" { default = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaa5olgpzianszo2l2zxarsdiawsg5hglexjguvkuyr2utxqbvy4f6q" }

//vault boot volume
variable "vault_block_volume_key" { default = "ocid1.key.oc1.sa-saopaulo-1.cvqwod3raagre.abtxeljrb6plq43v5x5tqfqzcmtp6lg7jqu4vog6yqkzy4atwxuth3fqdura" }


//vars to define
variable "instance_name" { nullable = false }
variable "nsg_name" {
  default  = "nsg-"
  nullable = false
}

variable "ocpu_instance" {
  default  = "1"
  nullable = false
}

variable "memory_instance" {
  default  = "8"
  nullable = false
}



