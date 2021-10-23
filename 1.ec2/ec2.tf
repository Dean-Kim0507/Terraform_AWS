provider "aws" {
  region = "ca-central-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0a70476e631caa6d3"
  instance_type = "t2.micro"

#   tags = {
#     Name = "HelloWorld"
#   }
}