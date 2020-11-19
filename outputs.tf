output "ec2-ip" {
  value = module.EC2.ec2-ip
}

output "test-endpoint" {
  value = module.RDS.rds_endpoint_test
}

output "prod-endpoint" {
  value = module.RDS.rds_endpoint_prod
}