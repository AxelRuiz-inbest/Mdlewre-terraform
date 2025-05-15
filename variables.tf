variable "subscription_id" {
  description = "Proyecto Automatización loT"
  type        = string
}

variable "resource_group_name" {
  description = "Ambiente Productivo NADRO_Ingenium - Automatización IoT"
  type        = string
}

/*Vnets Productivo*/
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

variable "key_vult" {
  description = "default"
  type        = string
}
variable "name_app_funt_1" {
  description = "default"
  type        = string
}

variable "name_app_funt_2" {
  description = "default"
  type        = string
}
variable "name_app_funt_3" {
  description = "default"
  type        = string
}
variable "name_app_funt_4" {
  description = "default"
  type        = string
}
variable "name_app_insig_service_1" {
  description = "default"
  type        = string
}
variable "name_app_service_1" {
  description = "default"
  type        = string
}
variable "name_app_insig_fun_1" {
  description = "default"
  type        = string
}
variable "name_app_insig_fun_2" {
  description = "default"
  type        = string
}
variable "name_app_insig_fun_3" {
  description = "default"
  type        = string
}
variable "name_app_insig_fun_4" {
  description = "default"
  type        = string
}
variable "name_cosmo" {
  description = "default"
  type        = string
}
variable "name_storage_appfun" {
  description = "default"
  type        = string
}
variable "name_service_bus" {
  description = "default"
  type        = string
}
variable "name_plan_app_service" {
  description = "default"
  type        = string
}
variable "name_plan_app_fun_premium1" {
  description = "default"
  type        = string
}
variable "name_plan_app_fun_premium2" {
  description = "default"
  type        = string
}
variable "name_sql_server" {
  description = "default"
  type        = string
}
variable "name_sql_db" {
  description = "default"
  type        = string
}
variable "name_vnet_1" {
  description = "default"
  type        = string
}
variable "name_subnet_sql" {
  description = "default"
  type        = string
}
variable "name_subnet_funt" {
  description = "default"
  type        = string
}
variable "name_subnet_en" {
  description = "default"
  type        = string
}
variable "name_diag_function" {
  description = "default"
  type        = string
}
variable "name_webpubsub-hub" {
  description = "default"
  type        = string
}
variable "name_diag_webpubsub" {
  description = "default"
  type        = string
}
variable "name_diag_servicebus" {
  description = "default"
  type        = string
}
variable "name_logs_webpubsub" {
  description = "default"
  type        = string
}
variable "name_logs_func" {
  description = "default"
  type        = string
}
variable "App" {
  description = "default"
  type        = string
}
variable "contact_dl" {
  description = "default"
  type        = string
}
variable "cost_center" {
  description = "default"
  type        = string
}
variable "created_by" {
  description = "default"
  type        = string
}
variable "created_date" {
  description = "default"
  type        = string
}
variable "env" {
  description = "default"
  type        = string
}
variable "Owner_app" {
  description = "default"
  type        = string
}

variable "endpfun1" {
  description = "default"
  type        = string
}
variable "endpfun2" {
  description = "default"
  type        = string
}
variable "endpfun3" {
  description = "default"
  type        = string
}
variable "endpfun4" {
  description = "default"
  type        = string
}

variable "endpappservice" {
  description = "default"
  type        = string
}

variable "endpsql" {
  description = "default"
  type        = string
}
variable "endpcosmo" {
  description = "default"
  type        = string
}
variable "endppubsub" {
  description = "default"
  type        = string
}
variable "endpservicebus" {
  description = "default"
  type        = string
}

variable "ServiceBusConnectionString" {
  description = "default"
  type        = string
}
variable "WebPubSubConnectionString" {
  description = "default"
  type        = string
}
variable "CosmosDBConnectionString" {
  description = "default"
  type        = string
}
