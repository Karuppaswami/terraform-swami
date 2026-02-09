# LB Publuc IP 
output "web_lbpublicip" {
  description = "web load Balancer public IP"
  value = azurerm_public_ip.web_lbpublicip.ip_address
}
# LB IP 
output "web_lb_id" {
  description = "web load Balancer ID"
  value = azurerm_lb.web_lb.id
}
# LB frontend IP Configuration Block
output "web_lb_frontend_ip_configuration" {
  description = "web lb frontend ip configuration"
  value = [azurerm_lb.web_lb.frontend_ip_configuration]
}

