terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "portfolio" {
  name     = "portfolio-resources"
  location = "uksouth"
}

# Create an Azure Static Web App
resource "azurerm_static_site" "portfolio" {
  name                = "ismael-portfolio"
  resource_group_name = azurerm_resource_group.portfolio.name
  location            = "westeurope"  
  sku_tier = "Free"
  sku_size = "Free"

  tags = {
    environment = "production"
    purpose     = "portfolio"
  }
}

# Output the deployment URL
output "static_web_app_url" {
  value = azurerm_static_site.portfolio.default_host_name
}

# Output the API key for GitHub Actions integration
output "static_web_app_api_key" {
  value     = azurerm_static_site.portfolio.api_key
  sensitive = true
} 
