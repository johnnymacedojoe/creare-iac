//I am having difficulty with this module due to the certificate generation process.

/*


module "ssl_certificate" {
  source = "./modules/new-cert-ssl"

  ca_certificate_path = "./ca_cert.pem"
  certificate_name    = "my_certificate"
  load_balancer_id    = module.alb-load_balancer1.load_balancer_id
  //passphrase              = "my_passphrase"//default=null
  private_key_path        = "./ca_key.pem"
  public_certificate_path = "./public_cert.pem"
}




*/


