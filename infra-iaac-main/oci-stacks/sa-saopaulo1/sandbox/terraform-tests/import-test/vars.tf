//Need provider for OCI Cloud Stacks
provider "oci" {
  region = var.region
  //config_file_profile = "BRYANCLOUD"
}


//global
variable "cs-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaan6pesto6qpypbokggla62h3vmsb3peuvjwsjwya5pdl5uxznjuvq" }
variable "region" { default = "sa-saopaulo-1" }


//creare module vars
//variable "preserve_boot_volume" { default = false }
variable "availability_domain_sp" { default = "CdKG:SA-SAOPAULO-1-AD-1" }
variable "vcn-oci-spo1p" { default = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaa5olgpziaxgf4itsatntngsbqm52nhivwvmhutme2rnldirqwchca" }
variable "vcn-oci-spo1s" { default = "ocid1.vcn.oc1.sa-saopaulo-1.amaaaaaa5olgpzianszo2l2zxarsdiawsg5hglexjguvkuyr2utxqbvy4f6q" }
variable "sn-oci-spo1p0" { default = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaatoife6lio4ne4bhmka6iomvuyzm5c5wkumpofdrarfcs5xhbsh2a" } // 10.1.0.0/24
variable "sn-oci-spo1p1" { default = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaamu5gkqervgx6e4cofwpdiumunyz3gkcsr3prw2nppbcykvcoyuzq" } // 10.1.1.0/24
variable "sn-oci-spo1p2" { default = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaazdo5lzro2qs55obecd2ty5tfrqx6wal4ieksfcsvui7wubxfxxha" } // 10.1.2.0/24
variable "sn-oci-spo1s0" { default = "ocid1.subnet.oc1.sa-saopaulo-1.aaaaaaaaqq6jeoanfnhzhbayw6yg23hb2m52nqjqerdehiyla3zea4kpwk3a" } // 10.5.0.0/24
variable "img-docker-host-1-3" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa54iuu4jsloigmq5pxirk4qql2p5igouk6uip7h2pvpfhdqjawjkq" }
variable "img-docker-host-1-4" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaahercqbfqxi7qfaanto5py42qnpmbsmjn4eyp6apurvicoffwstsq" }
variable "vault-block-volume-key" { default = "ocid1.key.oc1.sa-saopaulo-1.cvqwod3raagre.abtxeljrb6plq43v5x5tqfqzcmtp6lg7jqu4vog6yqkzy4atwxuth3fqdura" }
variable "nsg-spo1p-linux-server" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7zuio7jjvjyawjbv3laez6llf7binizyn7ftysrki5elsh2diapa" }
