# Create Network Security Group
resource "azurerm_network_interface" "web_linuxvm_nic" {
  count = var.web_linuxvm_instnace_count
  name = "${local.resource_name_prefix}-web-linuxvm-nic-$P{count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location

  ip_configuration {
    name = "web-linuxvm-ip-1"
    subnet_id = azurerm_subnet_websubnet.id
    private_ip_address_allocation = "Dynamic"
   # public_ip_address_id = azurerm_public_ip.web_linuxvm_publicip.id
     # primary = true
  }
}