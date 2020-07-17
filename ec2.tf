
resource "aws_instance" "mywebb" {
depends_on = [
    aws_cloudfront_distribution.webdistributionn
  ]
 
  ami           = "ami-0447a12f28fddb066"
  instance_type = "t2.micro"
  key_name = "poojaa"
  security_groups = [ "mysec" ]


  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/POOJA YELAKONDA/tera/mytestu/poojaa.pem")
    host     = aws_instance.mywebb.public_ip
  }

 provisioner "local-exec" {
    command = "echo \"<img src='https://${aws_s3_bucket.poojaabucket.bucket_regional_domain_name}/${aws_s3_bucket_object.webobjectss.key}'>\" >> index.html"
    interpreter = ["PowerShell","-command"]
}
    provisioner "file" {
    connection {
      agent       = false
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:/Users/POOJA YELAKONDA/tera/mytestu/poojaa.pem")
      host        = "${aws_instance.mywebb.public_ip}"
    }


    source      = "index.html"
    destination = "/home/ec2-user/index.html" 
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd  php git -y",
      "sudo systemctl restart httpd",
      "sudo systemctl enable httpd",
    ]
  }


  tags = {
    Name = "lwos1"
  }
}



