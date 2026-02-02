# Resource-1 : Create WebTier Subnet
resource "azurerm_subnet" "bastionsubnet" {
  name = "${azurerm.virtual.network-vnet.name}-${var.bastion_subnet_name_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.bastion_subnet_address_subnet_address
}
# Resource-2 : Create Network Security Group (NSG)
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name = azurerm_subnet.bastionsubnet.name
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Resource-3 : Associate NSG and Subnet 
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_assoicate" {
  depends_on = [ azurerm_network_security_rule.bastion_nsg_rule_inbound]   
  subnet_id = azurerm_subnet.bastionsubnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}
# Resource-4 : Create NSG Rules
## Local Block for Security Rules
locals {
  bastion_inbound_ports_maps = {
    "100" : "22"
    "110" : "3389"
  }
}
## NSG Inbound Rule for WebTier Subnets 
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each = local.bastion_inbound_ports_maps
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}