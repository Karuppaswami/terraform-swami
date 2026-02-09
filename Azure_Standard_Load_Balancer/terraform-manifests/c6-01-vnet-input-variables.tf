# Virtual Network, Subnets and Subnet NSG's

# Virtual Network vnet_name
variable "vnet_name" {
  description = "Virtual Network Name"
  type = string
  default = "vnet-default"
}
# Virtual Network Address space vnet_address_space
variable "vnet_address_space" {
  description = "Virtual Network Address Space"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

# Web Subnet Name web_subnet_name
variable "web_subnet_name" {
  description = "Virtual Network Web Subnet Name "
  type = string
  default = "websubnet"
}
# Web Subnet Address Space web_subnet_address
variable "web_subnet_address" {
  description = "Virtual Network Web Subnet Address Space"
  type = list(string)
  default = ["10.0.1.0/24"]
}

# Web Subnet Name app_subnet_name
variable "app_subnet_name" {
  description = "Virtual Network app Subnet name"
  type = string
  default = "appsubnet"
}
# Web Subnet Address Space app_subnet_address
variable "app_subnet_address" {
  description = "Virtual Network app subnet address space"
  type = list(string)
  default = [ "10.0.2.0/24" ]
}

# Web Subnet Name db_subnet_name
variable "db_subnet_name" {
  description = "Virtual Network db subnet name"
  type = string
  default = "dbsubnet"
}
# Web Subnet Address Space db_subnet_address
variable "db_subnet_address" {
    description = "Virtual Network db subnet address space"
    type = list(string)
    default = [ "10.0.3.0/24" ]
}
# Web Subnet Name bastion_subnet_name
variable "bastion_subnet_name_subnet_name" {
  description = "Virtual Network bastion subnet name"
  type = string
  default = "bastionsubnet"
}
# Web Subnet Address Space bastion_subnet_address
variable "bastion_subnet_address_subnet_address" {
    description = "Virtual Network bastion subnet address space"
    type = list(string)
    default = [ "10.0.4.0/24" ]
}


