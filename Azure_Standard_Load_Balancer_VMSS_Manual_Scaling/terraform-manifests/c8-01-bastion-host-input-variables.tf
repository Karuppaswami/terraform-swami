# Bastion Linux VM Input Variable Placeholder file.
variable "bastion_service_subnet_name" {
  description = "Bastion Service Subnet Name"
  default = "AzureBastionSubnet"
}


variable "bastion_service_address_prefix" {
  description = "Bastion Service address Prefix"
  default = ["10.0.101.0/27"]
}