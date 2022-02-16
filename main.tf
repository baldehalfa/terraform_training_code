# Creating Ubuntu server and run docker 

# <BLOCK TYPE> "<BLOCK NAME>" "<BLOCK LABEL>" {
#   # Block body
#   <IDENTIFIER> = <EXPRESSION> # Argument
# }


provider "aws" {
  region = "us-east-1"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = lookup(var.awsprops, "keyname")

  tags = {
    Name = lookup(var.awsprops, "user")
  }
}


output "ec2instance" {
  value = aws_instance.web.public_ip
}
