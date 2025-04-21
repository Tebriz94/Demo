terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}



# module_tag = { "module" = basename(abspath(path.module)) }
# This is defining a local map (dictionary) with a key "module" and 
# a value that is the name of the current module directory.
# path.module: Returns the file path to the current module.
# abspath(...): Converts it to an absolute path.
# basename(...): Extracts just the name of the directory.
# 🔍 Example: If your module is in /home/user/terraform/modules/vpc
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}


resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
        name                =  var.name
        location            =  var.location
        resource_group_name =  var.resource_group_name
        sku                 =  var.sku
        tags                =  local.tags        
        retention_in_days   =  var.retention_in_days != "" ? var.retention_in_days : null

        lifecycle {
          ignore_changes = [ 
               tags
           ]
        }
}



resource "azurerm_log_analytics_solution" "la_solution" {
        for_each                =  var.solution_plan_map

        solution_name           =  each.key    
        location                =  var.location
        resource_group_name     =  var.resource_group_name
        workspace_resource_id   =  azurerm_log_analytics_workspace.log_analytics_workspace.id
        workspace_name          =  azurerm_log_analytics_workspace.log_analytics_workspace.name

        plan {
          product   = each.value.product
          publisher = each.value.publisher
        }

        lifecycle {
          ignore_changes = [ 
            tags
           ]
        }
}