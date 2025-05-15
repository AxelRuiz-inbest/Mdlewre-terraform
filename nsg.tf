#subnet_sql
resource "azurerm_network_security_group" "nsg_sql" {
  name                = "nsg-${var.name_subnet_sql}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "in-allow-to-fun"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
  security_rule {
    name                       = "in-allow-to-en"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
security_rule {
    name                       = "out-allow-to-fun"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "out-allow-to-en"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "sql_assoc" {
  subnet_id                 = azurerm_subnet.subnet_sql.id
  network_security_group_id = azurerm_network_security_group.nsg_sql.id
}

#subnet_fun
resource "azurerm_network_security_group" "nsg_fun" {
  name                = "nsg-${var.name_subnet_funt}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "in-allow-to-sql"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "in-allow-to-en"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
  security_rule {
    name                       = "out-allow-to-sql"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "out-allow-to-en"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "fun_assoc" {
  subnet_id                 = azurerm_subnet.subnet_fun.id
  network_security_group_id = azurerm_network_security_group.nsg_fun.id
}

#subnet_en
resource "azurerm_network_security_group" "nsg_en" {
  name                = "nsg-${var.name_subnet_en}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "in-allow-to-sql"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "in-allow-to-fun"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
  security_rule {
    name                       = "out-allow-to-sql"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_sql.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }

  security_rule {
    name                       = "out-allow-to-fun"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = azurerm_subnet.subnet_en.address_prefixes[0]
    destination_address_prefix = azurerm_subnet.subnet_fun.address_prefixes[0]
    destination_port_range     = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "en_assoc" {
  subnet_id                 = azurerm_subnet.subnet_en.id
  network_security_group_id = azurerm_network_security_group.nsg_en.id
}
