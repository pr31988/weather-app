terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

 backend "azurerm" {
    resource_group_name  = "weather-rg"
    storage_account_name = "weathertfstate1988"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
provider "azurerm"{
   features {}
}

resource "azurerm_resource_group" "rg" {
    name = "weather-rg"
    location = "central india"
}

resource "azurerm_container_registry" "acr" {
    name = "weatheracr123"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku = "Basic"
    admin_enabled = true
}

resource "azurerm_service_plan" "plan" {
    name = "weather-plan"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    os_type = "Linux"
    sku_name = "B1"
}

resource "azurerm_linux_web_app" "app" {
     name = "weather-app"
     resource_group_name = azurerm_resource_group.rg.name
     location = azurerm_resource_group.rg.location
     service_plan_id = azurerm_service_plan.plan.id

     site_config {
       container_registry_use_managed_identity = true
     }

     identity {
      type = "SystemAssigned"
     } 
  }

  resource "azurerm_role_assignment" "acr_pull" {
      principal_id = azurerm_linux_web_app.app.identity[0].principal_id
      role_definition_name = "AcrPull"
      scope = azurerm_container_registry.acr.id
  }
