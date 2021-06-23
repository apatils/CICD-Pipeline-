variable "name_jenkins" {
  default = "jenkins-server"
  description = "Name the instance on deploy"
}

resource "aws_instance" "jenkins-server" {
    ami = "ami-0d563aeddd4be7fff"
    instance_type = "t2.micro"
    key_name = "ssh-key-pair"

    tags = {
      Name = var.name_jenkins
    }
  
}