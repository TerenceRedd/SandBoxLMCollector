resource "azurerm_subnet" "snet" {
    name                            = "${var.Tags["App"]}-sn-${terraform.workspace}"
    virtual_network_name            = var.Network["Vnet"]["Name"]
    resource_group_name             = var.Network["Vnet"]["ResourceGroup"]
    address_prefixes                = var.Network["Subnet"]
}

resource "azurerm_network_security_group" "nsg" {
    name                            = "${azurerm_subnet.snet.name}-uks-nsg"
    resource_group_name             = azurerm_resource_group.rg.name
    location                        = azurerm_resource_group.rg.location
}

resource "azurerm_subnet_network_security_group_association" "snsg" {
    subnet_id                       = azurerm_subnet.snet.id
    network_security_group_id       = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_rule" "nsr" {
    name                            = "nsr-${var.Network["Nsg"]["Rules"]["Access"][count.index]}-${var.Network["Nsg"]["Rules"]["Description"][count.index]}"
    resource_group_name             = azurerm_resource_group.rg.name
    network_security_group_name     = azurerm_network_security_group.nsg.name
    description                     = var.Network["Nsg"]["Rules"]["Description"][count.index]
    direction                       = var.Network["Nsg"]["Rules"]["Direction"][count.index]
    protocol                        = var.Network["Nsg"]["Rules"]["Protocol"][count.index]
    priority                        = 1000 + count.index
    access                          = var.Network["Nsg"]["Rules"]["Access"][count.index]
    source_address_prefix           = var.Network["Nsg"]["Rules"]["SourcePrefix"][count.index]
    source_port_range               = var.Network["Nsg"]["Rules"]["SourcePorts"][count.index]
    destination_address_prefix      = var.Network["Nsg"]["Rules"]["DestinationPrefix"][count.index]
    destination_port_range          = var.Network["Nsg"]["Rules"]["DestinationPorts"][count.index]
    count	                        = length(var.Network["Nsg"]["Rules"]["Protocol"])
}

data "azurerm_route_table" "rt" {
  name                = var.Network["RouteTable"]["Name"]
  resource_group_name = var.Network["RouteTable"]["ResourceGroup"]
}

resource "azurerm_subnet_route_table_association" "srt" {
  subnet_id       = azurerm_subnet.snet.id
  route_table_id  = data.azurerm_route_table.rt.id
}