resource "aws_instance" "instance1" {
  ami                    = "ami-0dc8d444ee2a42d8a"
  instance_type          = "t2.micro"
  key_name               = "instance1-key"
  #aws_key_pair.keypair.key_name
  vpc_security_group_ids = [var.secID]
  subnet_id              = var.ec2sub

  tags = {
    Name = "Terraform-built-ec2"
  }

  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"

    connection {
      host     = aws_instance.instance1.public_ip
      user     = "ubuntu"
      private_key = "${file("/home/ubuntu/.ssh/id_rsa")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
    "chmod +x /tmp/script.sh",
    "sudo /tmp/script.sh"
    ]
    connection {
      host     = aws_instance.instance1.public_ip
      user     = "ubuntu"
      private_key = "${file("/home/ubuntu/.ssh//id_rsa")}"
    }
  }
}

#resource "aws_key_pair" "keypair" {
#  key_name   = "instance1-key"
#  public_key = var.pub-key
#}