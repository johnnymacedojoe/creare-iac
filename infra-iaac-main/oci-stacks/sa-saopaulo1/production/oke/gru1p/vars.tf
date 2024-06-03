//Need provider for OCI Cloud Stacks
provider "oci" {
  region = "sa-saopaulo-1"
  //config_file_profile = ""
}

//
variable "BU-corp" { default = "ocid1.compartment.oc1..aaaaaaaaizf5hwc3gardybg4y4o2ishzhqvht4osq5rhi6vtofrolqztz2eq" }
variable "BU-Corp-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaaizf5hwc3gardybg4y4o2ishzhqvht4osq5rhi6vtofrolqztz2eq" }
variable "bu-agro" { default = "ocid1.compartment.oc1..aaaaaaaa6gtkc4yyho3bzdqsyf26v5f5evq6uf4pujbhld6oetlepix2zqea" }
variable "production" { default = "ocid1.compartment.oc1..aaaaaaaambsllglkxmaxooq45tke4awlmreuxs3lpm335rk7a7rjlqh3nkqa" }
variable "region-creare-singapore" { default = "ap-singapore-1" }



variable "drg-oci-spo1" { default = "ocid1.drg.oc1.sa-saopaulo-1.aaaaaaaarndrsf4dlf3lcaziom5aeqpdzjkkjgbuziuwrh3vngeobjmtuujq" }
//variable "drg-oci-sin1" { default = "ocid1.drg.oc1.ap-singapore-1.aaaaaaaakybdzyoywld2d7bg2umhed6h5qihq3kfybcshy6wxqy43mvmsuuq" }



//creare module vars
//variable "preserve_boot_volume" { default = false }
variable "availability_domain_sp" { default = "CdKG:SA-SAOPAULO-1-AD-1" }
variable "availability_domain_iad_1" { default = "GdKG:US-ASHBURN-AD-1" }
variable "availability_domain_sin" { default = "CdKG:AP-SINGAPORE-1-AD-1" }


//variable "img-docker-host-1-3" { default = "ocid1.image.oc1.iad.aaaaaaaadzag2fcmdsxmknzctd64ovbmawwju2s2v3nhn3j4dht7r5ujgh3q" }



#variable "img_oke_arm_1_28" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa2pvm6gjl6f5mhoqzai6ddpb4qdfocieyeq6otvb2buqcvhkxcvna" }
#variable "img_oke_amd_1_28" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaatnkfshwvgzprux2qtfjevrgpxeagjvojfhtlsme7ie7qztcbdgaa" }

variable "img_oke_arm_1_28" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaapgzqgavyhfqp2424z6cuuvztfxgqncii3j6hzrpe2vlpb6vbalsq" }
variable "img_oke_amd_1_28" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaatmopjcmy2gp3725id6op5gdknjyykjnd7u7vdtq2tgtnn7xclioa" }
variable "img_oke_amd_1_29" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaywijh3sn3iz5w4binf4bfzign442btbgaffaskuwe2mpm3vlkceq" }
variable "img-oke-latest-amd" { default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaabukalsme6rb66t6vy7ofj55awoakr74iafuakezj6334wytypvgq" }

variable "drg_oci_gru1" { default = "ocid1.drg.oc1.sa-saopaulo-1.aaaaaaaarndrsf4dlf3lcaziom5aeqpdzjkkjgbuziuwrh3vngeobjmtuujq" }





variable "vault-block-volume-key" { default = "ocid1.key.oc1.sa-saopaulo-1.cvqwod3raagre.abtxeljrb6plq43v5x5tqfqzcmtp6lg7jqu4vog6yqkzy4atwxuth3fqdura" }
