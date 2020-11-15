output "ec2-ip" {
  value = module.EC2.ec2-ip
}

output "db-endpoint" {
  value = module.RDS.rds_endpoint
}