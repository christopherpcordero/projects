/*
    This Terraform configuration file sets up a virtual network and subnets in Azure.
    
    # This configuration creates an Azure virtual network named "lab-vnet-1" with the address space "10.0.0.0/16".
    # It also defines two subnets within this virtual network:
    # - "lab-private-subnet" with address prefix "10.0.1.0/24"
    # - "lab-public-subnet" with address prefix "10.0.2.0/24"

*/


resource "azurerm_virtual_network" "vnet-1" {
  name                = "lab-vnet-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-1.location
  resource_group_name = azurerm_resource_group.rg-1.name
  tags = {
    environment = "lab"
  }
}

# This configuration creates two subnets within the virtual network:
# private subnet "lab-private-subnet" with address prefix "10.0.1.0/24"
# public subnet "lab-public-subnet" with address prefix "10.0.2.0/24"

resource "azurerm_subnet" "subnet-1" {
  name                 = "lab-private-subnet"
  resource_group_name  = azurerm_resource_group.rg-1.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  address_prefixes     = ["10.0.1.0/24"]

}
resource "azurerm_subnet" "subnet-2" {
  name                 = "lab-public-subnet"
  resource_group_name  = azurerm_resource_group.rg-1.name
  virtual_network_name = azurerm_virtual_network.vnet-1.name
  address_prefixes     = ["10.0.2.0/24"]

}


