resource "oci_core_instance" "oci_instance" {
  availability_domain = var.availability_domain_iad_1
  compartment_id      = var.bryancloud-compartment_ocid
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaandufa7ov7hy6mlo2x4stwjdoqe2vyjcqikjhtqlnfklv4eyuuviq"
    display_name     = "oci-instance-primary-vnic"
    assign_public_ip = "true"
  }

  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaabsjwtwmwshxig7mfvopaidoupmuwlho7vab46zitunqiej33wh3a"
  }

  display_name         = "oci-instance"
  metadata             = { ssh_authorized_keys = file("./id_rsa.pub") }
  preserve_boot_volume = "false"
}

