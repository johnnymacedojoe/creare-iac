//Need provider for OCI Cloud Stacks
provider "oci" {
  region = var.region-creare-singapore
  //config_file_profile = ""
}

//
variable "BU-corp" { default = "ocid1.compartment.oc1..aaaaaaaaizf5hwc3gardybg4y4o2ishzhqvht4osq5rhi6vtofrolqztz2eq" }
variable "bu-agro" { default = "ocid1.compartment.oc1..aaaaaaaa6gtkc4yyho3bzdqsyf26v5f5evq6uf4pujbhld6oetlepix2zqea" }
variable "bu_april" { default = "ocid1.compartment.oc1..aaaaaaaafug4dvlb5262u7oishvnx7s4a7xqke6z2h5hwnvv2uc7g3esx4iq" }
variable "region-creare-singapore" { default = "ap-singapore-1" }

variable "drg-oci-spo1" { default = "ocid1.drg.oc1.sa-saopaulo-1.aaaaaaaarndrsf4dlf3lcaziom5aeqpdzjkkjgbuziuwrh3vngeobjmtuujq" }
//variable "drg-oci-sin1" { default = "ocid1.drg.oc1.ap-singapore-1.aaaaaaaakybdzyoywld2d7bg2umhed6h5qihq3kfybcshy6wxqy43mvmsuuq" }



//creare module vars
//variable "preserve_boot_volume" { default = false }
variable "availability_domain_sp" { default = "CdKG:SA-SAOPAULO-1-AD-1" }
variable "availability_domain_iad_1" { default = "GdKG:US-ASHBURN-AD-1" }
variable "availability_domain_sin" { default = "CdKG:AP-SINGAPORE-1-AD-1" }


//variable "img-docker-host-1-3" { default = "ocid1.image.oc1.iad.aaaaaaaadzag2fcmdsxmknzctd64ovbmawwju2s2v3nhn3j4dht7r5ujgh3q" }

variable "img-oke-latest-arm" { default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaarcaup7eqcu75svjvo7zrhokzdpdlk4xqt4xlw5kwuilkdirdewja" }
variable "img-oke-latest-amd" { default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaabukalsme6rb66t6vy7ofj55awoakr74iafuakezj6334wytypvgq" }





variable "vault-block-volume-key" { default = "ocid1.key.oc1.ap-singapore-1.gzsuxuupaaabi.abzwsljrfoyrdj5h3xmrgyntwqpxeekjyfbeh5zqcoeoj2gk42kkstw4fbuq" }

variable "sn-oci-oke-sin1q2" { default = "ocid1.subnet.oc1.ap-singapore-1.aaaaaaaac2aszztpiwuejhzpejek6oygq4dbmyx4zhxfnxap2xv2mqspc6ua" }
variable "sn-oci-oke-sin1p2" { default = "ocid1.subnet.oc1.ap-singapore-1.aaaaaaaaihlzqgguzjaydaivrevyjstybmz2zlixeit6qhsazn4zol72n7pq" }


variable "vcn-oci-oke-sin1q" { default = "ocid1.vcn.oc1.ap-singapore-1.amaaaaaa5olgpziaksihdiuofgbvrv4etruhdwqv7dpqyfwzpf7ckgpovk4a" }
variable "vcn-oci-oke-sin1p" { default = "ocid1.vcn.oc1.ap-singapore-1.amaaaaaa5olgpziaudln4bgz3h5wke3y55n4tlyemgzsohii6ruiqoqvhnrq" }