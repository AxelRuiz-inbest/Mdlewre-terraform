/*DNZ Zone*/
resource "azurerm_private_dns_zone" "websites" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = data.azurerm_resource_group.rg.name

    tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}
resource "azurerm_private_dns_zone" "webpubsub_dns" {
  name                = "privatelink.webpubsub.azure.com"
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}
resource "azurerm_private_dns_zone" "sb_dns" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = data.azurerm_resource_group.rg.name
  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}
resource "azurerm_private_dns_zone" "cosmosdb" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}
resource "azurerm_private_dns_zone" "sql_dns" {
  name                = "privatelink.database.windows.net"
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}
/*DNZ Zone links*/
resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "dnslink"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.websites.name
  virtual_network_id    = azurerm_virtual_network.vnet-functions.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "webpubsub_dns_link" {
  name                  = "webpubsub-dns-link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.webpubsub_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet-functions.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "sb_dns_link" {
  name                  = "sb-dns-${var.name_service_bus}"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.sb_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet-functions.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "cosmosdb_dns_link" {
  name                  = "cosmosdb-dns-link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.cosmosdb.name
  virtual_network_id    = azurerm_virtual_network.vnet-functions.id
}
resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "sql-dns-link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet-functions.id
}

/*appFun01*/
resource "azurerm_private_endpoint" "function1" {
  name                = var.endpfun1
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "${var.name_app_funt_1}-connection"
    private_connection_resource_id = azurerm_windows_function_app.net_function_1.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

    tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*appFun02*/
resource "azurerm_private_endpoint" "function2" {
  name                = var.endpfun2
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "${var.name_app_funt_2}-connection"
    private_connection_resource_id = azurerm_windows_function_app.net_function_2.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*appFun03*/
resource "azurerm_private_endpoint" "function3" {
  name                = var.endpfun3
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "${var.name_app_funt_3}-connection"
    private_connection_resource_id = azurerm_windows_function_app.net_function_3.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*appFun04*/
resource "azurerm_private_endpoint" "function4" {
  name                = var.endpfun4
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "${var.name_app_funt_4}-connection"
    private_connection_resource_id = azurerm_windows_function_app.net_function_4.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*DNS Funtions, service bus */
resource "azurerm_private_dns_a_record" "function1" {
  name                = "dns-${var.name_app_funt_1}"
  zone_name           = azurerm_private_dns_zone.websites.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.function1.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "function2" {
  name                = "dns-${var.name_app_funt_2}"
  zone_name           = azurerm_private_dns_zone.websites.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.function2.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "function3" {
  name                = "dns-${var.name_app_funt_3}"
  zone_name           = azurerm_private_dns_zone.websites.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.function3.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "sb_record" {
  name                = azurerm_servicebus_namespace.servicebus.name
  zone_name           = azurerm_private_dns_zone.sb_dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.servicebus_pe.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "webpubsub_dns_record" {
  name                = azurerm_web_pubsub.webpubsub-hub.name
  zone_name           = azurerm_private_dns_zone.webpubsub_dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.webpubsub_pe.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "cosmosdb_dns_record" {
  name                = "dns-${var.name_cosmo}"
  zone_name           = azurerm_private_dns_zone.cosmosdb.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.cosmosdb_pe.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "sql_dns_record" {
  name                = "dns-${var.name_sql_server}"
  zone_name           = azurerm_private_dns_zone.sql_dns.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.sql_pe.private_service_connection[0].private_ip_address]
}
resource "azurerm_private_dns_a_record" "appservice_dns" {
  name                = "dns-${var.name_app_service_1}"
  zone_name           = azurerm_private_dns_zone.websites.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [azurerm_private_endpoint.appservice_pe.private_service_connection[0].private_ip_address]
}

/*ServiceBus*/
resource "azurerm_private_endpoint" "servicebus_pe" {
  name                = var.endpservicebus
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "sb-connection"
    private_connection_resource_id = azurerm_servicebus_namespace.servicebus.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }
    tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*AzureWEBPubsub*/
resource "azurerm_private_endpoint" "webpubsub_pe" {
  name                = var.endppubsub
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "webpubsub-connection"
    private_connection_resource_id = azurerm_web_pubsub.webpubsub-hub.id
    subresource_names              = ["webpubsub"]
    is_manual_connection           = false
  }
}

/*Cosmo*/
resource "azurerm_private_endpoint" "cosmosdb_pe" {
  name                = var.endpcosmo
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "cosmosdb-connection"
    private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb.id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }
    tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*SQL*/
resource "azurerm_private_endpoint" "sql_pe" {
  name                = var.endpsql
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "sql-connection"
    private_connection_resource_id = azurerm_mssql_server.sql-server-cluster.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }
    tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}

/*Appservice*/
resource "azurerm_private_endpoint" "appservice_pe" {
  name                = var.endpappservice
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet_en.id

  private_service_connection {
    name                           = "${var.name_app_service_1}-connection"
    private_connection_resource_id = azurerm_linux_web_app.appnodered.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
    tags = {
    App = var.App
    contact_dl = var.contact_dl
    cost_center = var.cost_center
    created_by = var.created_by
    created_date = var.created_date
    env = var.env
    Owner_app = var.Owner_app
  }
}