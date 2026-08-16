output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}
output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "The IDs of the public subnets."
}
output "private_backend_subnet_ids" {
  value       = aws_subnet.private_backend[*].id
  description = "The IDs of the private backend subnets."
}
output "private_database_subnet_ids" {
  value       = aws_subnet.private_database[*].id
  description = "The IDs of the private database subnets."
}
output "nat_gateway_id" {
  value       = aws_nat_gateway.main.id
  description = "The ID of the NAT Gateway."
}
output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The ID of the public route table."
}
output "private_route_table_id" {
  value       = aws_route_table.private.id
  description = "The ID of the private route table."
}
output "internet_gateway_id" {
  value       = aws_internet_gateway.main.id
  description = "The ID of the Internet Gateway."
}
output "nat_eip_id" {
  value       = aws_eip.nat.id
  description = "The ID of the NAT Gateway Elastic IP."
}
output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "The CIDR block of the VPC."
}