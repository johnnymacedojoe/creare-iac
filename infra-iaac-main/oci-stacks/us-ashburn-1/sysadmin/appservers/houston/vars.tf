//Need provider for OCI Cloud Stacks
provider "oci" {
  region = var.region-creare-ashburn
  //config_file_profile = ""
}

//
variable "BU-corp" { default = "ocid1.compartment.oc1..aaaaaaaaizf5hwc3gardybg4y4o2ishzhqvht4osq5rhi6vtofrolqztz2eq" }
variable "region-creare-ashburn" { default = "us-ashburn-1" }

variable "drg-oci-spo1" { default = "ocid1.drg.oc1.sa-saopaulo-1.aaaaaaaarndrsf4dlf3lcaziom5aeqpdzjkkjgbuziuwrh3vngeobjmtuujq" }



//creare module vars
//variable "preserve_boot_volume" { default = false }
variable "availability_domain_sp" { default = "CdKG:SA-SAOPAULO-1-AD-1" }
variable "availability_domain_iad_1" { default = "CdKG:US-ASHBURN-AD-1" }


//variable "img-docker-host-1-3" { default = "ocid1.image.oc1.iad.aaaaaaaadzag2fcmdsxmknzctd64ovbmawwju2s2v3nhn3j4dht7r5ujgh3q" }
variable "img_oke_arm_1_28" { default = "ocid1.image.oc1.iad.aaaaaaaao2zpwcb2osmbtliiuzlphc3y2fqaqmcpp5ttlcf573sidkabml7a" }
variable "img-oke-latest-arm" { default = "ocid1.image.oc1.iad.aaaaaaaaovv47lrev6bcghnux2zyvgek6q4knpyhilf5ch2vmxyqtmtwfmqa" }
variable "img_oke_amd_1_28" { default = "ocid1.image.oc1.iad.aaaaaaaanwsto6tqklfuawgqrve5ugjpbff3l5qtb7bs35dp72ewcnsuwoka" }
variable "kali_linux_image" { default = "ocid1.image.oc1..aaaaaaaaqcxm3wmmo5uul52s5bfegyi4irmt67ue3kd432ayza6lqgrwuddq" }


variable "vcn_iad1p" { default = "ocid1.vcn.oc1.iad.amaaaaaa5olgpziafb4i2mvtgli5iuh7aylmoilfp5yl3ywurraoqcjy3u4a" }
variable "subnet_iad1p2" { default = "ocid1.subnet.oc1.iad.aaaaaaaanp3my27vschz3yvqmlauivo7p5lfamxd3x5uedhfdzfpklbhv6xq" }

variable "vault-block-volume-key" { default = "ocid1.key.oc1.iad.ejswcxy4aaaum.abuwcljr6zjz4yn6mtxvbmtczmb3c45zh5bchbqm2kzgxocq7dmdadvjswfa" }
