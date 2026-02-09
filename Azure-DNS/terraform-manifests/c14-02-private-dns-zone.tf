# Resource - 1: Create Azure Private DNS Zone
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = "swami.com"  # Duplicate or Dumy Domian which i have created
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource - 2: Associate Private DNS Zone to Virtual Network 
resource "azurerm_priavte_dns_zone_virtual_network_link" "private_dns_zone_vnet-associate" {
  name = "${local.resource_name_prefix}-private-dns-zone-vnet-associate"
  resource_group_name = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id = azurerm_virtual_network.vnet.id
}

# Resource - 3: Internal Loda balancer DNS A record
resource "azurerm_private_dns_a_record" "app_lb_dns_record" {
  depends_on = [ azurerm_lb.app_lb ]
  name = "applb"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name = azurerm_private_dns_zone.private_dns_zone.name
  records = [ "${azurerm_lb.app_lb.frontend_ip_configuration[0].private_ip_address}" ]
  ttl = 300
}