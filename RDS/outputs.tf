output "rds_endpoint_test" {
    value = aws_db_instance.test-db.endpoint
}

output "rds_endpoint_prod" {
    value = aws_db_instance.prod-db.endpoint
}