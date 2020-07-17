

resource "aws_ebs_volume" "myebss" {
  availability_zone = aws_instance.mywebb.availability_zone
  size              = 1
  tags = {
    Name = "lwebs"
  }
}




resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.myebss.id}"
  instance_id = "${aws_instance.mywebb.id}"
  force_detach = true
}




output "myos_ip" {
  value = aws_instance.mywebb.public_ip
}
