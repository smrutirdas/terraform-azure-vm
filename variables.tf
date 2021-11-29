variable "RGName" {
  type        = string
  description = "(Required) The name of the resource group. Must be unique on your Azure subscription"
}

variable "location" {
  type        = string
  description = "(Required) The location where the resource group should be created. For a list of all Azure locations, please consult this link or run az account list-locations --output table."
}

variable "clientID" {
  type        = string
  description = "(Optional) Adds a tag with the application name this resource group belogs to."
  default     = ""
}

variable "clientSecret" {
  type        = string
  description = "(Optional) Environment name. If not specified, this module will use workspace as default value"
  default     = "default"
}

variable "tenantID" {
  type        = string
  description = "(Optional) Adds a tag indicating the creator of this resource"
  default     = "cloudcommons"
}
variable "subscriptionID" {
  type        = string
  description = "(Optional) Adds a tag indicating the creator of this resource"
  default     = "cloudcommons"
}
