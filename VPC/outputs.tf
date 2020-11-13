output "ec2subnet" {
    value = aws_subnet.pub-sub.id
}

output "securityID" {
    value = aws_security_group.instance1-sg.id
}