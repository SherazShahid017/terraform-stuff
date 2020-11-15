output "ec2subnet" {
    value = aws_subnet.pub-sub.id
}

output "securityID" {
    value = aws_security_group.instance1-sg.id
}

output "privsub-id" {
    value = aws_subnet.priv-sub.id
}

output "privsub-id2" {
    value = aws_subnet.priv-sub2.id
}