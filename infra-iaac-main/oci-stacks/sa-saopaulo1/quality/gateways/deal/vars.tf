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
variable "img-windows-standard-2016" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaiozkxdpyqp3sqspn4vf2tvw3b7p4olkcvbh5lg6ida4cgjoaoheq" }


variable "vault-block-volume-key" { default = "ocid1.key.oc1.sa-saopaulo-1.cvqwod3raagre.abtxeljrb6plq43v5x5tqfqzcmtp6lg7jqu4vog6yqkzy4atwxuth3fqdura" }
variable "nsg-spo1p-linux-server" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7zuio7jjvjyawjbv3laez6llf7binizyn7ftysrki5elsh2diapa" }
variable "nsg-salford" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaawvzsv7gww6xnq3lbwyzrrsezoeybfqzyrt5iqlluo7xikbuwdzlq" }
variable "nsg-cannes" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7xcwcdfpoxhtppoaoh6r5yiohjxlw7lpjpmrh6j2oi6hxukt2zkq" }
variable "nsg-versalhes" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaalvxnzmaghli6pzmreg7bruy6gsimporgkdxscnz6jvrcq76uoadq" }
variable "nsg-swinton" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaazzluq452htw5xvo4riuurraeig6pqom4lizfhhv5mwjutfmqzhwq" }
variable "nsg-qa-lbgw-cs-h7" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaadyozoqpchedgvsukh5t72byinq6cm3l7m6cy4f2gebiqhufwy6fq" }
variable "nsg-marselha" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaai2kx7figymjjipzuxcp3tf3u3s7a6azpdxo4q6uj6pidhpwnvcrq" }
variable "nsg-bradford" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaan3dk47mjf5zm24xiwhpnczegeduuo45m67mkub5fndaw2bznnxyq" }
variable "nsg-esparta" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaerdtqxu7j4sqhby2gtrtbnispm22hw4wlt5rlxlgl6jizwnsiqea" }
variable "nsg-atenas" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaawzxsigxtekac3cnfyrinsdwxxed5ia6vus33dhrjlflv6dv5jqrq" }
variable "nsg-gateshead" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaf2ulnkkjpgxk4q5w6lxkkkvfjgxhv7l342433vloccb4nogfadwa" }