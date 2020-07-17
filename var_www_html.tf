resource "null_resource" "nulllocal22"  {
	provisioner "local-exec" {
	    command = "echo  ${aws_instance.mywebb.public_ip} > publicip.txt"


  	}
}





resource "null_resource" "nullremote33"  {


depends_on = [
    aws_volume_attachment.ebs_att,
  ]




  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/POOJA YELAKONDA/tera/mytestu/poojaa.pem")
    host     = aws_instance.mywebb.public_ip
  }


provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4  /dev/xvdh",
      "sudo mount  /dev/xvdh  /var/www/html",
      "sudo rm -rf /var/www/html/*",
      "sudo cp /home/ec2-user/index.html /var/www/html/"
    ]
  }
}

resource "null_resource" "nulllocal11"  {


depends_on = [
    null_resource.nullremote33,aws_cloudfront_distribution.webdistributionn
  ]


	provisioner "local-exec" {
	    command = "start chrome  ${aws_instance.mywebb.public_ip}"
  	}
}