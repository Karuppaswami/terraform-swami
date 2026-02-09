# Datasource : Get DNS Record

data "azurerm_dns_zone" "dns_zone" {
  name = "kubeoncloud.com"
  resource_group_name = "dns-zone"
} 

# Resource - 1 : Add Root Record set in DNS Zone
resource "azurerm_dns_a_record" "dns_record" {
  depends_on = [ azurerm_lb.web_lb ]
  name = "@"
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  zone_name = data.azurerm_dns_zone.dns_zone.name
  ttl = 300  # 5 min
  target_resource_id = azurerm_public_ip.web_lbpublicip.id
}
# Resource - 2: Add www Record Set In DNS Zone 
resource "azurerm_dns_a_record" "dns_record_www" {
  depends_on = [ azurerm_lb.web_lb ]
  name = "www"
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  zone_name = data.azurerm_dns_zone.dns_zone.name
  ttl = 300
  target_resource_id = azurerm_public_ip.web_lbpublicip.id
}

# Resource - 3: Add app1 Record Set In DNS Zone 
resource "azurerm_dns_a_record" "dns_record_app1" {
  depends_on = [ azurerm_lb.web_lb ]
  name = "app1"
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  zone_name = data.azurerm_dns_zone.dns_zone.name
  ttl = 300
  target_resource_id = azurerm_public_ip.web_lbpublicip.id
}