resource "aws_db_subnet_group" "subgroup" {
  name       = "subgroup"
  subnet_ids = [var.priv-sub-id, var.priv-sub-id2]

  tags = {
    Name = "My DB subnet group"
  }
}

#resource "aws_db_security_group" "mydb-sg" {
#  name = "rds_sg"

#  ingress {
#    security_group_id = var.priv-sub-id
#  }
#}

resource "aws_db_instance" "test-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "testdb"
  username             = "admin"
  password             = "root1234"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.subgroup.name
  skip_final_snapshot = true
}

resource "aws_db_instance" "prod-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "proddb"
  username             = "admin"
  password             = "root1234"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.subgroup.name
  skip_final_snapshot = true
}