# Resource-1 : Create WebTier Subnet
resource "azurerm_subnet" "websubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.web_subnet_address
}
# Resource-2 : Create Network Security Group (NSG)
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name = azurerm_subnet.websubnet.name
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}
# Resource-3 : Associate NSG and Subnet 
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  depends_on = [ azurerm_network_security_rule.web_nsg_rule_inbond ]  # To come over from the provide bugs we need required depends_on
  subnet_id = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}
# Resource-4 : Create NSG Rules
## Local Block for Security Rules
locals {
  web_inbound_ports_map ={
    "100" : "80",     # While using for each : left side value is each.key, right side value is each.value
    "110" : "443",
    "120" : "22"
  }
}
## NSG Inbound Rule for WebTier Subnets 
resource "azurerm_network_security_rule" "web_nsg_rule_inbond" {
  for_each = web_inbound_ports_map
name = "Rule-Port-${each.value}"
priority = each.key
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = each.value
source_address_prefix = "*"
destination_address_prefix = "*"
network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
resource_group_name = azurerm_resource_group.rg.name
}