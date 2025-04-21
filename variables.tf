variable "location" {
    type        = string
    default     = "EastUS"
    description = "Specifies the location for the resource group and all the resources"
}

variable "resource_group_name" {
    type        = string
    default     = "DemoRG"
    description = "Specifies the resource group name"
}

variable "tags" {
    description = "(Optional) Specifies tags for all the resources"
    default     = {
        createdWith = "Terraform"
    }
}

##Log Analytics Workspace
variable "log_analytics_workspace_name" {
    type        = string
    default     = "DemoAksWorkspace"
    description = "Specifies the name of the log analytics workspace"
}

variable "log_analytics_retention_days" {
    type        = number
    default     = 30
    description = "Specifies the number of days of the retention policy"
}


variable "solution_plan_map" {
    type        =  map(any)
    default = {
        ContainerInsights = {
        product = "OMSGallery/ContainerInsights"
        publisher = "Microsoft"
      }
    }
    description = "Specifies solutions to deploy to log analytics workspace"
}



##For HUB VNET Network Configuration
variable "hub_vnet_name" {
    type = string
    default = "HubVnet"
    description = "Specifies the name of the hub virtual virtual network"
}

variable "hub_address_space" {
    type        = list(string)
    default     = [ "10.1.0.0/16" ]
    description = "Specifies the address space of the hub virtual virtual network"
}

variable "hub_firewall_subnet_address_prefix" {
    type        = list(string)
    default     = [ "10.1.0.0/24" ]
    description = "Specifies the address prefix of the firewall subnet"
}

variable "hub_bastion_subnet_prefix" {
    type        = list(string)
    default     = [ "10.1.1.0/24" ]
    description = "Specifies the address prefix of the bastionall subnet"
}


##AKS VNET Variables
variable "aks_vnet_name" {
    type        = string
    default     = "AKSVnet"
    description = "Specifies the name of the AKS subnet"
}

variable "aks_vnet_address_space" {
    type        = list(string)
    default     = ["10.0.0.0/16"]
    description = "Specifies the address prefix of the AKS subnet"
}

variable "vm_subnet_name" {
    type        = string
    default     = "VmSubnet"
    description = "Specifies the name of the jumpbox subnet"
}

variable "vm_subnet_address_prefix" {
    type        = list(string)
    default     = ["10.0.48.0/20"]
    description = "Specifies the address prefix of the jumbox subnet"
}

##AKS NODE POOL SUBNETS
variable "pod_subnet_name" {
    type = string
    default = "PodSubnet"
    description = "Specifies the name of the pod subnet."
}

variable "pod_subnet_address_prefix" {
    type = list(string)
    default = [ "10.0.32.0/20" ]
    description = "Specifies the address prefix of the pod subnet"
}


variable "default_node_pool_name" {
    type = string
    default = "system"
    description = "Specifies the name of the default node pool"
}

variable "default_node_pool_subnet_name" {
  default     =  "SystemSubnet"
  type        = string
  description = "Specifies the name of the subnet that hosts the default node pool"
}


variable "default_node_pool_subnet_address_prefix" {
    type = list(string)
    default = [ "10.0.0.0/20" ]
    description = "Specifies the address prefix of the subnet that hosts the default node pool"
}


variable "default_node_pool_enable_auto_scaling" {
    type = bool
    default = true
    description = "(Optional) Whether to enable auto-scaler. Defaults to true."
}


variable "default_node_pool_enable_host_encryption" {
    type = bool
    default = false
    description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
}


variable "default_node_pool_enable_node_public_ip" {
    type = bool
    default = false
    description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
}


variable "default_node_pool_max_pods" {
  type          = number
  default       = 5
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
}


variable "system_node_pool_node_labels" {
  type          = map(any)
  default       = {}
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
}


variable "system_node_pool_node_taints" {
  type          = list(string)
  default       = ["CriticalAddonsOnly=true:NoSchedule"]
  description   = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
} 



variable "default_node_pool_os_disk_type" {
  type          = string
  default       = "Ephemeral"
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
}

variable "default_node_pool_max_count" {
  type          = number
  default       = 10
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
}


variable "default_node_pool_min_count" {
  type          = number
  default       = 3
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
}


variable "default_node_pool_node_count" {
  type          = number
  default       = 3
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
}


##User node pool in which apps will be deployed
variable "additional_node_pool_subnet_name" {
  default     = "UserSubnet"
  type        = string
  description = "Specifies the name of the subnet that hosts the default node pool"
}

variable "additional_node_pool_subnet_address_prefix" {
  type        = list(string)
  default     = ["10.0.16.0/20"]
  description = "Specifies the address prefix of the subnet that hosts the additional node pool"
}


variable "additional_node_pool_name" {
  type        = string
  default     = "user"
  description = "(Required) Specifies the name of the node pool."
}


variable "additional_node_pool_vm_size" {
  type        = string
  default     = "Standard_D2as_v4"
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
}


variable "additional_node_pool_availability_zones" {
  type        = list(string)
  default = ["1"]  ## Can be extended to  ["1", "2", "3"]
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
}


variable "additional_node_pool_enable_auto_scaling" {
  type          = bool
  default       = true
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
}


variable "additional_node_pool_enable_host_encryption" {
  type          = bool
  default       = false
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
}


variable "additional_node_pool_enable_node_public_ip" {
  type          = bool
  default       = false
  description = "(Optional) Should each node have a Public IP Address? Defaults to false. Changing this forces a new resource to be created."
}


variable "additional_node_pool_max_pods" {
  type          = number
  default       = 10
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
}


## By default mode is System
variable "additional_node_pool_mode" {
  type          = string
  default       = "User"
  description = "(Optional) Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User."
}


variable "additional_node_pool_node_labels" {
  type          = map(any)
  default       = {}
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
}


variable "additional_node_pool_node_taints" {
  type          = list(string)
  default       = []
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
}


variable "additional_node_pool_os_disk_type" {
  type          = string
  default       = "Ephemeral"
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
} 


variable "additional_node_pool_os_type" {
  type          = string
  default       = "Linux"
  description = "(Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
}


variable "additional_node_pool_priority" {
  type          = string
  default       = "Regular" ## For test env might be used Spot
  description = "(Optional) The Priority for Virtual Machines within the Virtual Machine Scale Set that powers this Node Pool. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
}


variable "additional_node_pool_max_count" {
  type          = number
  default       = 10
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
}


variable "additional_node_pool_min_count" {
  type          = number
  default       = 3
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
}


variable "additional_node_pool_node_count" {
  type          = number
  default       = 3
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
}