//Need provider for OCI Cloud Stacks
provider "oci" {
  region = var.region-creare-singapore
  //config_file_profile = ""
}

//
variable "quality" { default = "ocid1.compartment.oc1..aaaaaaaaet2gg6mmzr56mohsbyvmttpxlcnnib4keevli6kvgq76mwtbngwq" }
variable "BU-corp" { default = "ocid1.compartment.oc1..aaaaaaaaizf5hwc3gardybg4y4o2ishzhqvht4osq5rhi6vtofrolqztz2eq" }
variable "bu-agro" { default = "ocid1.compartment.oc1..aaaaaaaa6gtkc4yyho3bzdqsyf26v5f5evq6uf4pujbhld6oetlepix2zqea" }
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
//variable "img-oke-amd-1-29-1" { default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaawurcumzg2ek2mx46dpqhygshnm7q23qjryk5uii3hiroyrccb6cq" }
variable "img-oke-amd-1-28-2" { default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaagwpofnh5q6q3it45dw2xwtzggmxdgawlqd4oi75vtofhjj7dvxja" }
variable "img-oke-amd-1-29-1" { default = "ocid1.image.oc1.ap-singapore-1.aaaaaaaawurcumzg2ek2mx46dpqhygshnm7q23qjryk5uii3hiroyrccb6cq" }



variable "vault-block-volume-key" { default = "ocid1.key.oc1.ap-singapore-1.gzsuxuupaaabi.abzwsljrfoyrdj5h3xmrgyntwqpxeekjyfbeh5zqcoeoj2gk42kkstw4fbuq" }
