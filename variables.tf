variable "resource_group_name" {
  type        = string
  description = "resource group name of the virtual network"
}
variable "location" {
  type        = string
  description = "location of the virtual network"
}
variable "virtual_network_name" {
  type        = string
  description = "name of the virtual network"
}
variable "virtual_network_address_space" {
  type        = list(string)
  description = "address space of the virtual network"
}
variable "subnet_name" {
  type        = string
  description = "name of the subnet"
}
variable "subnet_address_prefix" {
  type        = list(string)
  description = "address prefix of the subnet"
}
variable "vmname" {
  type        = string
  description = "name of the vm"
}

variable "names" {
  description = "VM Names"
  type        = set(string)
}
variable "vm_size" {
  type        = string
  description = "size of the virtual machine"
}
variable "os_disk_type" {
  type        = string
  description = "type of the os disk. example Standard_LRS"
}
variable "admin_usename" {
  type        = string
  description = "local admin user of the virtual machine"
}
variable "admin_password" {
  type        = string
  description = "password of the local admin user"
}
variable "image_publisher" {
  type        = string
  description = "Azure image publisher"
  default     = "MicrosoftWindowsServer"
}
variable "image_offer" {
  type        = string
  description = "Azure image offer"
  default     = "WindowsServer"
}
variable "image_sku" {
  type        = string
  description = "Azure image sku"
  default     = "2016-Datacenter"
}
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 2
}
variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}
variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}