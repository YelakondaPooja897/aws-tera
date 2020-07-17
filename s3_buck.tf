resource "aws_s3_bucket" "poojaabucket" {
  bucket = "poojaabucket"
  acl    = "public-read"
}


resource "aws_s3_bucket_object" "webobjectss" {
  bucket = "${aws_s3_bucket.poojaabucket.bucket}"
  key    = "poojaa.jpg"
  source = "C:/Users/POOJA YELAKONDA/Downloads/pooja.jpg"
  acl    = "public-read"
}
