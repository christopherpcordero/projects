/*
#REF: https://mikerossiter.gitlab.io/posts/linux-vm-azure-terraform/
# Create a Linux VM using the Kali Linux image
# This VM will be used for penetration testing and security research



*/
resource "azurerm_linux_virtual_machine" "vm-1" {
  name                = "kali"
  resource_group_name = azurerm_resource_group.rg-1.name
  location            = azurerm_resource_group.rg-1.location
  size                = "Standard_D2s_v3"
  admin_username      = "toor"

  # Use the network interface created 
  # This is the network interface that will be attached to the VM
  network_interface_ids = [
    azurerm_network_interface.nic-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "kali-linux"
    offer     = "kali"
    sku       = "kali-2024-4"
    version   = "latest"
  }
  plan {
    name      = "kali-2024-4"
    publisher = "kali-linux"
    product   = "kali"
  }
  admin_ssh_key {
    username   = "toor"
    public_key = file("${path.module}/kali_toor.pub")
  }

  tags = {
    environment = "lab"
  }
}

# Create a public IP address for the Kali VM
resource "azurerm_public_ip" "public_ip_kali" {
  name                = "kali-public-ip"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
  allocation_method   = "Static"

  tags = {
    environment = "lab"
  }
}

#NIC for kali VM
resource "azurerm_network_interface" "nic-1" {
  name                = "lab-nic-1"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  ip_configuration {
    name                 = "internal"
    subnet_id            = azurerm_subnet.subnet-2.id #public subnet
    public_ip_address_id = azurerm_public_ip.public_ip_kali.id
    # Associate the public IP address with the NIC  
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a network security group for the Kali VM


# Create a Network Security Group (NSG) for the Kali VM
resource "azurerm_network_security_group" "nsg_kali" {
  name                = "kali-nsg"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  security_rule {
    name                   = "AllowSSH"
    priority               = 1000
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "22"
    #only allow SSH from a specific IP address
    source_address_prefix      = "x.x.x.x"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "lab"
  }
}

# Associate the NSG with the Kali VM's network interface
resource "azurerm_network_interface_security_group_association" "nsg_association_kali" {
  network_interface_id      = azurerm_network_interface.nic-1.id
  network_security_group_id = azurerm_network_security_group.nsg_kali.id
}

# Associate the public IP address with the Kali VM's network interface

# resource "azurerm_network_interface_public_ip_association" "public_ip_association_kali" {
#   network_interface_id = azurerm_network_interface.nic-1.id
#   public_ip_address_id = azurerm_public_ip.public_ip_kali.id
# }

# Output the public IP address of the Kali VM
output "kali_public_ip" {
  value       = azurerm_public_ip.public_ip_kali.ip_address
  description = "The public IP address of the Kali VM"
}

# Output the private IP address of the Kali VM
output "kali_private_ip" {
  value       = azurerm_network_interface.nic-1.ip_configuration[0].private_ip_address
  description = "The private IP address of the Kali VM"
}


/*
#REF: https://mikerossiter.gitlab.io/posts/linux-vm-azure-terraform/
# Create a Linux VM using the Kali Linux image
# This VM will be used for penetration testing and security research



*/
resource "azurerm_linux_virtual_machine" "vm-1" {
  name                = "kali"
  resource_group_name = azurerm_resource_group.rg-1.name
  location            = azurerm_resource_group.rg-1.location
  size                = "Standard_D2s_v3"
  admin_username      = "toor"

  # Use the network interface created 
  # This is the network interface that will be attached to the VM
  network_interface_ids = [
    azurerm_network_interface.nic-1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "kali-linux"
    offer     = "kali"
    sku       = "kali-2024-4"
    version   = "latest"
  }
  plan {
    name      = "kali-2024-4"
    publisher = "kali-linux"
    product   = "kali"
  }
  admin_ssh_key {
    username   = "toor"
    public_key = file("${path.module}/kali_toor.pub")
  }

  tags = {
    environment = "lab"
  }
}

# Create a public IP address for the Kali VM
resource "azurerm_public_ip" "public_ip_kali" {
  name                = "kali-public-ip"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
  allocation_method   = "Static"

  tags = {
    environment = "lab"
  }
}

#NIC for kali VM
resource "azurerm_network_interface" "nic-1" {
  name                = "lab-nic-1"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  ip_configuration {
    name                 = "internal"
    subnet_id            = azurerm_subnet.subnet-2.id #public subnet
    public_ip_address_id = azurerm_public_ip.public_ip_kali.id
    # Associate the public IP address with the NIC  
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a network security group for the Kali VM


# Create a Network Security Group (NSG) for the Kali VM
resource "azurerm_network_security_group" "nsg_kali" {
  name                = "kali-nsg"
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name

  security_rule {
    name                   = "AllowSSH"
    priority               = 1000
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_port_range      = "*"
    destination_port_range = "22"
    #only allow SSH from a specific IP address
    source_address_prefix      = "173.72.65.138"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "lab"
  }
}

# Associate the NSG with the Kali VM's network interface
resource "azurerm_network_interface_security_group_association" "nsg_association_kali" {
  network_interface_id      = azurerm_network_interface.nic-1.id
  network_security_group_id = azurerm_network_security_group.nsg_kali.id
}


# Output the public IP address of the Kali VM
output "kali_public_ip" {
  value       = azurerm_public_ip.public_ip_kali.ip_address
  description = "The public IP address of the Kali VM"
}

# Output the private IP address of the Kali VM
output "kali_private_ip" {
  value       = azurerm_network_interface.nic-1.ip_configuration[0].private_ip_address
  description = "The private IP address of the Kali VM"
}

