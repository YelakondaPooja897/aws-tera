
resource "tls_private_key" "ssh_key" {

  algorithm = "RSA"
}

module "key_pair" {


  source = "terraform-aws-modules/key-pair/aws"
  key_name   = "poojaa"
  public_key = tls_private_key.ssh_key.public_key_openssh

}
output "poojaa"{
value = tls_private_key.ssh_key.private_key_pem
}