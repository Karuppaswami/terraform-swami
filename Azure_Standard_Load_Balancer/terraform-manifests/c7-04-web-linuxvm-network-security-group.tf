# Resource-1 : Create Networl security group
resource "azurerm_network_security_group" "web_vmnic_nsg" {
 name = "${azurerm_network_interface.web_linuxvm_nic_name}-nsg"
 resource_group_name = azurerm_resource_group.rg.name
 location = azurerm_resource_group.rg.location
}

# Resource 2: Associate NSG and Linux VM NIC
resource "azurerm_network_security_group_association" "web_vmnic_nsg_association" {
  depends_on = [ azurerm_network_security_group_rule.web_vmnic_nsg_rule_inbound ]
  Network_interface_id = azurerm_network_interface.web_linuxvm_nic.id
  Network_Security_id = azurerm_network_security_group.web_vmnic_nsg.id
}

# Resource 3: Create NSG rule
## Locals Block for Security Rules 

locals {
  web_vmnic_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"
  }
}

## NSG Inbound Rules
resource "azurerm_network_security_group_rule" "web_linuxvm_nsg_rule" {
  for_each = local.web_vmnic_inbound_ports_map
name = "Rule-Port-${each.value}"
priority = each.key
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = each.value
source_address_prefix = "*"
destination_address_prefix = "*"
network_security_group_name = azurerm_network_security_group.web_vmnic_nsg.name
resource_group_name = azurerm_resource_group.rg.name
}