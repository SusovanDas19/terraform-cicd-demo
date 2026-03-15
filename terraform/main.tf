provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo_instance" {
  ami           = "ami-0f559c3642608c138"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-demo-instance"
  }
}
