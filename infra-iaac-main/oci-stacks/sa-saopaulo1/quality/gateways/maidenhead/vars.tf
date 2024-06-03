//Need provider for OCI Cloud Stacks
provider "oci" {
  region = var.region
  //config_file_profile = "BRYANCLOUD"
}


//global
variable "cs-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaan6pesto6qpypbokggla62h3vmsb3peuvjwsjwya5pdl5uxznjuvq" }
variable "BU-Agro-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaa6gtkc4yyho3bzdqsyf26v5f5evq6uf4pujbhld6oetlepix2zqea" }
variable "BU-Corp-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaaizf5hwc3gardybg4y4o2ishzhqvht4osq5rhi6vtofrolqztz2eq" }
variable "BU-Safety-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaa5b6s2zgyhhqoiotjxpavgu675ihkgzvicquhqgymarxnzzypcrga" }
variable "BU-Safety-FoconaVia-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaawsjvb64t3screrbju5rzjgspnhku7f2xbd4j2k3py4bhpgat6qwq" }
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

variable "nsg-cannes" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7xcwcdfpoxhtppoaoh6r5yiohjxlw7lpjpmrh6j2oi6hxukt2zkq" }
variable "nsg-versalhes" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaalvxnzmaghli6pzmreg7bruy6gsimporgkdxscnz6jvrcq76uoadq" }
variable "ssl-goawakecloud" { default = "ocid1.certificate.oc1.sa-saopaulo-1.amaaaaaa5olgpziaxicibi3r2cs2dkkxnntnlm2ihmggeknt27y2u6zl5voq" }
variable "nsg-toledo" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaakw7pnn24aeso3zqxdeajayi3bx5qepmcoorzcqrqhh4c3ggaxsma" }
variable "nsg-spo1p-docker-host" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaa53zwnojapsxvlmy72olsx3k3mskkl54he5vlnckboorxe6oe5ca" }
variable "nsg-getafe" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaowodalqrhmm5y6f24na3hbn57d5oq7r6zmquaiiznubtdsn6fcha" }
variable "nsg-bradford" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaan3dk47mjf5zm24xiwhpnczegeduuo45m67mkub5fndaw2bznnxyq" }
