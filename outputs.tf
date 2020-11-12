output "ec2-ip" {
  value = aws_instance.instance1.public_ip
}