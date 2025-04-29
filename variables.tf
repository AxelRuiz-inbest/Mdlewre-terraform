variable "subscription_id" {
  description = "Proyecto Automatización loT"
  type        = string
}

variable "resource_group_name" {
  description = "Ambiente Productivo NADRO_Ingenium - Automatización IoT"
  type        = string
}

/*Vnets Productivo*/
variable "vnetprod" {
  description = "Vnet productiva"
  type        = string
}

variable "subnetdb" {
  description = "subnet db productiva"
  type        = string
}
variable "subnetenp" {
  description = "subnet enp productiva"
  type        = string
}
variable "subnetfunc" {
  description = "subnet functions productiva"
  type        = string
}
variable "subnetapp" {
  description = "subnet functions productiva"
  type        = string
}
variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "East US"
}

variable "tag_Proyecto" {
  description = "tag_Proyecto"
  type        = string
}
variable "tag_Ambiente" {
  description = "tag_Proyecto"
  type        = string
}
variable "tag_Ambiente_dev" {
  description = "tag_Proyecto"
  type        = string
}
variable "tag_Owner-iNBest" {
  description = "tag_Proyecto"
  type        = string
}
variable "tag_Cliente" {
  description = "tag_Proyecto"
  type        = string
}
variable "tag_Contacto" {
  description = "tag_Proyecto"
  type        = string
}
variable "tag_ID-Proyecto" {
  description = "tag_Proyecto"
  type        = string
}