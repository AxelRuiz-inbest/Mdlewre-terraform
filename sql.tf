resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "cosmosdb-nadro-lot-prod-001" # debe ser único a nivel global
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  automatic_failover_enabled = true

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = data.azurerm_resource_group.rg.location
    failover_priority = 0
  }

  backup {
    type                = "Periodic"
    interval_in_minutes = 240         # Cada 4 horas
    retention_in_hours  = 8           # Retiene backups por 8 horas
    storage_redundancy  = "Geo"       # Puedes usar "Geo", "Zone", o "Local"
  }

  public_network_access_enabled = false
  is_virtual_network_filter_enabled = true
}


resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "nosqldb-nadro-lot-prod-001"
  resource_group_name = data.azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  throughput          = null
}

resource "azurerm_cosmosdb_sql_container" "container" {
  name                  = "maincontainer"
  resource_group_name   = data.azurerm_resource_group.rg.name
  account_name          = azurerm_cosmosdb_account.cosmosdb.name
  database_name         = azurerm_cosmosdb_sql_database.db.name
  partition_key_paths    = ["/definition/id"]
  partition_key_version = 1
  throughput            = 400

  indexing_policy {
    indexing_mode = "consistent"
    
    included_path {
      path = "/*"
    }

    excluded_path {
      path = "/\"_etag\"/?"
    }
  }
  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}

resource "azurerm_mssql_virtual_network_rule" "sql_subnet_access" {
  name                = "sql-subnet-access"
  server_id           = azurerm_mssql_server.sql-server-cluster.id
  subnet_id           = data.azurerm_subnet.subnetdb.id
  ignore_missing_vnet_service_endpoint = false
}

resource "azurerm_mssql_firewall_rule" "local_ip" {
  name             = "axel-office"
  server_id        = azurerm_mssql_server.sql-server-cluster.id
  start_ip_address = "177.248.19.209"
  end_ip_address   = "177.248.19.209"
}

resource "azurerm_mssql_server" "sql-server-cluster" {
  name                         = "sqlserver-nadro-lot-prod-001"
  resource_group_name          = data.azurerm_resource_group.rg.name
  location                     = data.azurerm_resource_group.rg.location
  public_network_access_enabled = true
  version                      = "12.0"
  administrator_login          = "Administrador"
  administrator_login_password = "f23s0Tm@z#F6"
}

resource "azurerm_mssql_database" "sqlserver-db" {
  name         = "lot-db"
  server_id    = azurerm_mssql_server.sql-server-cluster.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 250
  sku_name     = "S1"
  enclave_type = "VBS"

  tags = {
    foo = "bar"
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
