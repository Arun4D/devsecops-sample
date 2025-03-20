resource "azurerm_resource_group" "kpiVisualization" {
  name     = local.config_final.resource_group.app1
  location = local.config_final.location
}

resource "azurerm_virtual_network" "kpiVisualization" {
  name                = local.config_final.vnet.vnet_name
  address_space       = local.config_final.vnet.address_space
  location            = azurerm_resource_group.kpiVisualization.location
  resource_group_name = azurerm_resource_group.kpiVisualization.name
}

resource "azurerm_subnet" "kpiVisualization" {
  name                 = local.config_final.vnet.subnet.subnet_name
  resource_group_name  = azurerm_resource_group.kpiVisualization.name
  virtual_network_name = azurerm_virtual_network.kpiVisualization.name
  address_prefixes     = local.config_final.vnet.subnet.address_prefix
}

resource "azurerm_network_interface" "kpiVisualization" {
  name                = "kpiVisualization-nic"
  location            = azurerm_resource_group.kpiVisualization.location
  resource_group_name = azurerm_resource_group.kpiVisualization.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.kpiVisualization.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "kpiVisualization" {
  name                = "kpiVisualization-nsg"
  location            = azurerm_resource_group.kpiVisualization.location
  resource_group_name = azurerm_resource_group.kpiVisualization.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "103.102.96.237" # Replace with your authorized IP range
    destination_address_prefix = "${azurerm_subnet.kpiVisualization.address_prefixes[0]}"
  }
}

resource "azurerm_linux_virtual_machine" "kpiVisualization" {
  name                = "kpiVisualization-machine"
  resource_group_name = azurerm_resource_group.kpiVisualization.name
  location            = azurerm_resource_group.kpiVisualization.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.kpiVisualization.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key =  var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  disable_password_authentication = true
  allow_extension_operations=false
}