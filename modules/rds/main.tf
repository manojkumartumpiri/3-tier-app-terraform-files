resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}
resource "aws_db_parameter_group" "this" {
  name   = "${var.project_name}-mysql-params"
  family = "mysql8.0"

  tags = var.tags
}
resource "aws_db_instance" "this" {
  identifier = "${var.project_name}-mysql"

  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = var.db_name
  username = var.db_username

  manage_master_user_password = true

  db_subnet_group_name = aws_db_subnet_group.this.name
  parameter_group_name = aws_db_parameter_group.this.name

  vpc_security_group_ids = [
    var.security_group_id
  ]

  multi_az            = true
  publicly_accessible = false
  storage_encrypted   = true

  backup_retention_period = 1

  deletion_protection = false
  skip_final_snapshot = false

  final_snapshot_identifier = "${var.project_name}-mysql-final"

  tags = var.tags
}
