variable "vpc_name" {
  description = "The ID of the VPC where the subnets will be created."
  type        = string
  }
  variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  }
  variable "availability_zones" {
  description = "A list of availability zones where the subnets will be created."
  type        = list(string)
  }
  
variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}
  variable "private_subnet_cidr_blocks_backend" {
  description = "A list of CIDR blocks for the private subnets to be created."  
  type        = list    (string)
  }
variable "private_subnet_cidr_blocks_database" {
  description = "A list of CIDR blocks for the private subnets to be created."  
  type        = list    (string)
  }
  variable "tags" {
  description = "A map of tags to assign to the resources."
    type        = map(string)
  }
