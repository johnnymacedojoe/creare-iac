//Need provider for OCI Cloud Stacks
provider "oci" {
  region              = var.region-bryancloud
  config_file_profile = "BRYANCLOUD"
}
terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
    }
  }
}
//use if you need to change for your cloud without ~/.oci/config
/*provider "oci" {
  tenancy_ocid     = "ocid1.tenancy.oc1..xxxx"
  user_ocid        = "ocid1.user.oc1..xxxx"
  fingerprint      = "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
  private_key_path = "/path/to/your/private_key.pem"
  region           = "us-ashburn-1"
}*/

//bryancloud
variable "bryancloud-compartment_ocid" { default = "ocid1.tenancy.oc1..aaaaaaaarnqf3vhed7uvo2bgzhcvu3stm7azylxeacps653xpgk62jkkbvba" }
variable "region-bryancloud" { default = "us-ashburn-1" }

variable "availability_domain_iad_1" { default = "GtDF:US-ASHBURN-AD-1" }