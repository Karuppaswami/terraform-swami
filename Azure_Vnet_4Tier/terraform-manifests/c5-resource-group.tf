# resource-1 : Azure Resource Group
resource "azurerm_resource_group" "rg" {
  #name = "${local.resource_name_prefix}-${var.resource_group.name}" Used for production
  name = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"  #used for the partice sesison
  location = var.resource_group_location
  tags = local.common_tags
}
