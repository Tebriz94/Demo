terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.26.0"
    }
  }
}

provider "azurerm" {
  features {}
}


data "azurerm_client_config" "current" {}


resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
    tags = var.tags
}


module "log_analytics_workspace" {

        source = "./modules/log_analytics"
        name = var.log_analytics_workspace_name
        location = var.location
        resource_group_name = azurerm_resource_group.rg.name
        solution_plan_map = var.solution_plan_map
}




module "hub_network" {
    source = "./modules/virtual_network"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    vnet_name = var.hub_vnet_name
    address_space = var.hub_address_space
    log_analytics_workspace_id = module.log_analytics_workspace.id
    subnets = [

                 {
                  name: "AzureFirewallSubnet"
                  address_prefixes: var.hub_firewall_subnet_address_prefix
                  private_endpoint_network_policies_enabled: true
                  private_link_service_network_policies_enabled: false
                },

                { 
                  name: "AzureBastionSubnet"
                  address_prefixes: var.hub_bastion_subnet_prefix
                  private_endpoint_network_policies_enabled: true
                  private_link_service_network_policies_enabled: false
                }

    ]
}


module "aks_network" {

    source = "./modules/virtual_network"
    resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    vnet_name = var.aks_vnet_name
    address_space = var.aks_vnet_address_space
    log_analytics_workspace_id = module.log_analytics_workspace.id

    subnets = [


        {
                name: var.default_node_pool_subnet_name
                address_prefixes: var.additional_node_pool_subnet_address_prefix
                private_endpoint_network_policies_enabled: true
                private_link_service_network_policies_enabled: false
            },

            {
                name: var.additional_node_pool_name
                address_prefixes: var.additional_node_pool_subnet_address_prefix
                private_endpoint_network_policies_enabled: true
                private_link_service_network_policies_enabled: false
            },

            {
                name: var.pod_subnet_name
                address_prefixes: var.pod_subnet_address_prefix
                private_endpoint_network_policies_enabled: true
                private_link_service_network_policies_enabled: false
            },

            {
                name: var.vm_subnet_name
                address_prefixes: var.vm_subnet_address_prefix
                private_endpoint_network_policies_enabled: true
                private_link_service_network_policies_enabled: false
            }



    ]
}

##NETWORK PEERING AMONG VNETS

module "vnet_peering" {

    source = "./modules/virtual_network_peering"
    vnet_1_name = var.hub_vnet_name
    vnet_1_id = module.hub_network.vnet_id
    vnet_1_rg = azurerm_resource_group.rg.name
    vnet_2_name = var.aks_vnet_name
    vnet_2_id = module.aks_network.vnet_id
    vnet_2_rg = azurerm_resource_group.rg.name

    peering_name_1_to_2 = "${var.hub_vnet_name}To${var.aks_vnet_name}"
    peering_name_2_to_1 = "${var.aks_vnet_name}To${var.hub_vnet_name}"
}