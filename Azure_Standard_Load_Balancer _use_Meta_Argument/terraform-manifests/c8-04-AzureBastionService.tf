# Azure Bastion Service - Resource 
## Resource - 1: Azure Bastion Subnet
resource "azurerm_subnet" "bastion_subnet" {
  name = var.bastion_service_subnet_name
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.bastion_service_address_prefix
}

# Resource -2 : Azure Bastion Public IP 
resource "azurerm_public_ip" "bastion_Service_publicip" {
  name = "${local.resource_name_prefix}-bastion_Service_publicip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}
# Resource -3 : Azure Bastion Service Host
resource "azurerm_bastion_host" "bastion_host" {
  name = "${local.resource_name_prefix}-bastion-service"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  ip_configuration {
    name = "Bastion-service-host"
    subnet_id = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_Service_publicip.id
  }
}