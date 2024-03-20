resource "azurerm_network_interface" "nic" {
    for_each = toset(var.names)   
     vmname                = "${each.value}-nic"
    location            = var.location
    resource_group_name = var.resource_group_name
    ip_configuration {
        name                          = "ipconfiguration1"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}
