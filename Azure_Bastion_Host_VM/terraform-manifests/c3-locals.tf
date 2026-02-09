#Define Local Values in Terraform
locals {
  owners = var.business_division
  environment = var.environment
  resource_name_prefix = "${var.business_division}-${var.environment}"
  common_tags = {
    owner = local.owners,
    enironment = local.environment
  }
}