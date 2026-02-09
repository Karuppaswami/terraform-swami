business_division = "hr"
environment = "dev"

resource_group_name = "rg"
resource_group_location = "eastus"

vnet_name = "vnet"
vnet_address_space = ["10.1.0.0/16"]

web_subnet_name = "websubnet"
web_subnet_address = ["10.0.1.0/24"]

app_subnet_name = "appsubnet"
app_subnet_address = ["10.0.2.0/24"]

db_subnet_name = "dbsubnet"
db_subnet_address = ["10.0.3.0/24"]

bastion_subnet_name_subnet_name = "bastionsubnet"
bastion_subnet_address_subnet_address = ["10.0.4.0/24"]

bastion_service_subnet_name = "AzureBastionSubnet"
bastion_service_address_prefix = "10.0.101.0/27"

# web_linuxvm_instnace_count = 5
# lb_inbound_nat_ports = [ "1022", "2022","3022","4022","5022" ]
/*
web_linuxvm_instnace_count = {
    "vm1" = "1022",
    "vm2" = "2022"
}
*/
web_vmss_nsg_inbound_ports = [22, 80, 443]

