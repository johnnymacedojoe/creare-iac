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
variable "goawake-compartment_ocid" { default = "ocid1.compartment.oc1..aaaaaaaae3xom54lgzm6h23dlhmi5sup5ecr5rtsi4axemmagojnwacf4b3a" }
variable "production" { default = "ocid1.compartment.oc1..aaaaaaaambsllglkxmaxooq45tke4awlmreuxs3lpm335rk7a7rjlqh3nkqa" }
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


variable "img-oci-linux-9-arm" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaakshaz32eorxs7hefji6hlw6ouddrd6xvr7qzn45jmodsc6o3r7da" }
variable "img-docker-host-1-3" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa54iuu4jsloigmq5pxirk4qql2p5igouk6uip7h2pvpfhdqjawjkq" }
variable "img-docker-host-1-4" { default = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaahercqbfqxi7qfaanto5py42qnpmbsmjn4eyp6apurvicoffwstsq" }
variable "vault-block-volume-key" { default = "ocid1.key.oc1.sa-saopaulo-1.cvqwod3raagre.abtxeljrb6plq43v5x5tqfqzcmtp6lg7jqu4vog6yqkzy4atwxuth3fqdura" }
variable "nsg-spo1p-linux-server" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7zuio7jjvjyawjbv3laez6llf7binizyn7ftysrki5elsh2diapa" }
variable "nsg-pd-lbcore-pub" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaabxhyvekljh7bkskh5vubpkhfk6nb24rekpr6l6znk5j56sa243oa" }
variable "nsg-qa-lbcore-pub" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaab76mi3cxflokri5es4kuqjhkiqin4v3g76mzsvjaczo5ddcscvya" }

variable "nsg-cannes" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7xcwcdfpoxhtppoaoh6r5yiohjxlw7lpjpmrh6j2oi6hxukt2zkq" }
variable "nsg-versalhes" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaalvxnzmaghli6pzmreg7bruy6gsimporgkdxscnz6jvrcq76uoadq" }
variable "ssl-goawakecloud" { default = "ocid1.certificate.oc1.sa-saopaulo-1.amaaaaaa5olgpziaxicibi3r2cs2dkkxnntnlm2ihmggeknt27y2u6zl5voq" }
variable "nsg-toledo" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaakw7pnn24aeso3zqxdeajayi3bx5qepmcoorzcqrqhh4c3ggaxsma" }
variable "nsg-spo1p-docker-host" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaa53zwnojapsxvlmy72olsx3k3mskkl54he5vlnckboorxe6oe5ca" }
variable "nsg-gateshead" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaaf2ulnkkjpgxk4q5w6lxkkkvfjgxhv7l342433vloccb4nogfadwa" }


variable "nsg-qa-lbgw-cs-smartwatch" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaappshqwst5qfpwi75zvhtn4blz56a6mmasfsgisav3m27tqulttza" }
variable "nsg-pd-lbgw-cs-smartwatch" { default = "ocid1.networksecuritygroup.oc1.sa-saopaulo-1.aaaaaaaa7gcasbr25wi5r3e6iabjpstm3yprgu5fftksrzldtdguuoa3q2na" }