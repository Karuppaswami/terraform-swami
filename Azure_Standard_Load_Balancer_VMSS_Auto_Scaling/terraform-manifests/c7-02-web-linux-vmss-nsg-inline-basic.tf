# Resource-1 : Create Networl security group
resource "azurerm_network_security_group" "web_vmnic_nsg" {
 name = "${local.resource_name_prefix}-web_vmss_nsg"
 resource_group_name = azurerm_resource_group.rg.name
 location = azurerm_resource_group.rg.location
# Dynamic block - security rule 
dynamic "security_rule" {
  for_each = var.web_vmss_nsg_inbound_ports
  content {
    name = "inbound-rule-${security_rule.key}"
    description = "Inbound rule ${security_rule.key}"
    priority = sum([100, security_rule.key])
    direction= "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = security_rule.value
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

}