variable "name" {
  default = "flask_server"
  description = "Name of instance on deploy"
}

resource "aws_instance" "flask_server" {
  ami           = "ami-0d563aeddd4be7fff"
  instance_type = "t2.micro"
  key_name = "ssh-key-pair"
  tags = {
    Name = var.name
  }
}