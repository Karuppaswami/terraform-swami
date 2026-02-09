#Generic inpurt variable 
#Business Division 
variable "business_division" {
    description = "Business Division in the large organization this Infrastructure"
    type = string
    default = "sap"
}
#Environbment Variable
variable "environment" {
    description = "Environment Variable used as a prefix"
    default = "dev"
}
#Azure Resource Group Name
variable "resource_group_name" {
  description = "Resource Group Name"
  default = "rg-default"
}
#Azure Resource Location
variable "resource_group_location"{
    description = "Region in which resources to be created"
    default = "eastus2"
}