variable "resource_group_name" {
  type                  = string
  description           = "(Required) Specifies the resource group name"
}

variable "location" {
  type                  = string
  description           = "(Required) Specifies the location of the log analytics workspace"
}

variable "name" {
  type                  = string
  description           = "(Required) Specifies the name of the log analytics workspace"
}


variable "sku" {
  type                  = string
  default               = "PerGB2018"
  description           = "(Optional) Specifies the sku of the log analytics workspace"

  validation {
    condition           = contains(["Free", "Standalone", "PerNode", "PerGB2018"], var.sku)
    error_message       = "The Log Analytics sku is incorrect."
  }
}


variable "solution_plan_map" {
    type                = map(any)
    default             = {}
    description         = "(Optional) Specifies the map structure containing the list of solutions to be enabled."
}

variable "tags" {
    type                = map(any)
    default             = {}
    description         = "(Optional) Specifies the tags of the log analytics workspace"
}

variable "retention_in_days" {
    type                = number
    default             = 30
    description         = "(Optional) Specifies the workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
}