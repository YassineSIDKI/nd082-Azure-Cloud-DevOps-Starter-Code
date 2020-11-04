provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-webserver-rg"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-webserver-vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "example" {
  count                = var.nb_instances
  name                 = "${var.prefix}-webserver-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}

resource "azurerm_network_interface" "example" {
  count               = var.nb_instances
  name                = "${var.prefix}-webserver-vInterface-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-webserver-publicip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
    name                       = "denyInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  count                     = var.nb_instances
  subnet_id                 = azurerm_subnet.example[count.index].id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_lb" "example" {
  name                = "${var.prefix}-webserver-lb"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.example.id
  name                = "${var.prefix}-webserver-backEndAddressPool"
}

data "azurerm_image" "ubuntuImage" {
  name                = "ubuntuImage"
  resource_group_name = var.packer_image_rg
}

output "image_id" {
  value = data.azurerm_image.ubuntuImage.id
}

resource "azurerm_availability_set" "example" {
  name                         = "${var.prefix}-availability_set"
  location                     = azurerm_resource_group.main.location
  resource_group_name          = azurerm_resource_group.main.name
  platform_fault_domain_count  = 1
  platform_update_domain_count = 1
  managed                      = true
}

resource "azurerm_managed_disk" "example" {
  count                = var.nb_instances
  name                 = "${var.prefix}-managed-disk-${count.index}"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.nb_instances
  name                = "${var.prefix}-webserver-vm-${count.index}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = var.vm_size
  availability_set_id = azurerm_availability_set.example.id

  network_interface_ids = [azurerm_network_interface.example[count.index].id]


  disable_password_authentication = false
  source_image_id                 = data.azurerm_image.ubuntuImage.id

  tags = {
    "project" = "webserver"
  }

  admin_username = var.vm_credentials.username
  admin_password = var.vm_credentials.password

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

