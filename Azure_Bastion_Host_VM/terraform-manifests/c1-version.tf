#Terraform Block

terraform {
  required_version = ">=1.0.0"  #PreProduction or Dev Environment
  #required_version = "~=1.14.0"  For Production Environment
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=4.0.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.0.0"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}

# Provider Block
provider "azurerm" {
    features {
      
    }
  
}

