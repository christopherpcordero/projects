
/*
  Create SIEM VM

  This VM will be used for security information and event management (SIEM) tasks
    It will run Ubuntu 22.04 LTS and will be configured with SSH access



*/

# Create a Linux VM using the Ubuntu image
resource "azurerm_linux_virtual_machine" "vm-2" {
  name                = "siem-vm"
  resource_group_name = azurerm_resource_group.rg-1.name
  location            = azurerm_resource_group.rg-1.location
  size                = "Standard_D2s_v3"
  admin_username      = "labadmin"

  network_interface_ids = [
    azurerm_network_interface.nic-2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }


  admin_ssh_key {
    username   = "labadmin"
    public_key = file("${path.module}/lab_admin.pub")
  }

  tags = {
    environment = "lab"
  }
}

resource "azurerm_network_interface" "nic-2" {
  name                = "lab-nic-2"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-1.id
    private_ip_address_allocation = "Dynamic"
  }
}


# Create a public IP address for the Ubuntu VM
resource "azurerm_public_ip" "public_ip_ubuntu" {
  name                = "ubuntu-public-ip"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
  allocation_method   = "Static"

  tags = {
    environment = "lab"
  }
}

# Create a Network Security Group (NSG) for the Ubuntu VM
resource "azurerm_network_security_group" "nsg_ubuntu" {
  name                = "nsg-ubuntu"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  security_rule {
    name                   = "SSH"
    priority               = 1000
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "22"
    #only allow SSH from a specific IP address
    source_address_prefix      = "X.X.X.X"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "lab"
  }
}

# Associate the NSG with the NIC
resource "azurerm_network_interface_security_group_association" "nsg_association_ubuntu" {
  network_interface_id      = azurerm_network_interface.nic-2.id
  network_security_group_id = azurerm_network_security_group.nsg_ubuntu.id
}

<<<<<<< HEAD
output "siem_vm_public_ip" {
  value       = azurerm_public_ip.public_ip_ubuntu.ip_address
  description = "The public IP address of the SIEM VM"
}

output "siem_vm_private_ip" {
  value       = azurerm_network_interface.nic-2.ip_configuration[0].private_ip_address
  description = "The private IP address of the SIEM VM"
}
=======
# Associate the public IP with the NIC
# resource "azurerm_network_interface_public_ip_association" "public_ip_association_ubuntu" {
#   network_interface_id = azurerm_network_interface.nic-2.id
#   public_ip_address_id = azurerm_public_ip.public_ip_ubuntu.id
# }

>>>>>>> b5fb7f4a84446628326037715355cc16381778a4
