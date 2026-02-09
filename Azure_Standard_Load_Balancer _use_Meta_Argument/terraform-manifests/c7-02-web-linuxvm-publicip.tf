/*
# Resource-1 : Create a Public IP Address
resource "azurerm_public_ip" "web_linuxvm_public_ip" {
  name                = "${local.resource_name_prefix}-web-linuxvm-publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku = "Standard"
  tags = local.common_tags
  domain_name_label = "app1-vm-${random_string.myrandom.id}"
}
*/

